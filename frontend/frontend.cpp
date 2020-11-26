#include <assert.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <optional>

// dialect includes
#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "Hask/Scope.h"
#include "Interpreter.h"

// more MLIR includes...
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Verifier.h"

#define GIVE
#define TAKE
#define KEEP

#define debug_assert assert

using namespace std;

extern "C" {
const char *__asan_default_options() { return "detect_leaks=0"; }
}

bool G_PRETTY_PRINT = false;
bool G_DUMP_MLIR = false;

// https://github.com/jorendorff/rust-grammar/blob/master/Rust.g4
// https://github.com/harpocrates/language-rust/blob/master/src/Language/Rust/Parser/Internal.y
using ll = long long;

// struct string;
struct Span;

// HACK: useful for debugging! flushes after *each character write*. Of course
// this is fucking stupid.
struct OutFile {
public:
  OutFile(FILE *f) : f(f){};
  ~OutFile() { fflush(f); }

  void write(ll i) {
    fprintf(f, "%lld", i);
    fflush(f);
  }
  void write(int i) {
    fprintf(f, "%d", i);
    fflush(f);
  }

  void write(char c) {
    fputc(c, f);
    if (c == '\n') {
      for (int i = 0; i < indentLevel; ++i) {
        for (int j = 0; j < 2; ++j) {
          fputc(' ', f);
        }
        // fputc('|', f);
      }
    }
    fflush(f);
  }
  void write(const char *s) {
    while (*s != '\0') {
      write(*s++);
    };
    fflush(f);
  }

  void indent() { indentLevel++; }
  void dedent() {
    indentLevel--;
    assert(indentLevel >= 0);
  }

private:
  ll indentLevel = 0;
  FILE *f;
};

OutFile &operator<<(OutFile &f, int i) {
  f.write(i);
  return f;
}

OutFile &operator<<(OutFile &f, ll i) {
  f.write(i);
  return f;
}
OutFile &operator<<(OutFile &f, const char *const s) {
  f.write(s);
  return f;
}
OutFile &operator<<(OutFile &f, char *s) {
  f.write(s);
  return f;
}

OutFile &operator<<(OutFile &f, const std::string s) {
  f.write(s.c_str());
  return f;
}

OutFile &operator<<(OutFile &f, char c) {
  f.write(c);
  return f;
}
template <typename T> OutFile &operator<<(OutFile &f, optional<T> ot) {
  if (!ot) {
    return f << "nothing;";
  } else {
    return f << "just[" << *ot << "]";
  }
}

template <typename T> OutFile &operator<<(OutFile &out, const T &v) {
  v.print(out);
  return (out);
}

static OutFile cerr(stderr);
static OutFile cout(stdout);

// L for location
struct Loc {
  const char *filename;
  ll si, line, col;

  Loc(const char *filename, ll si, ll line, ll col)
      : filename(filename), si(si), line(line), col(col){};

  Loc nextline() const { return Loc(filename, si + 1, line + 1, 1); }

  Loc nextc(char c) const {
    if (c == '\n') {
      return nextline();
    } else {
      return nextcol();
    }
  }

  Loc nextstr(const string &s) const;

  Loc prev(char c) const {
    if (c == '\n') {
      assert(false && "don't know how to walk back newline");
    } else {
      return prevcol();
    }
  }

  Loc prev(const char *s) const {
    Loc l = *this;
    for (int i = strlen(s) - 1; i >= 0; --i) {
      l = l.prev(s[i]);
    }
    return l;
  }

  bool operator==(const Loc &other) const {
    return si == other.si && line == other.line && col == other.col;
  }

  bool operator!=(const Loc &other) const { return !(*this == other); }

  // move the current location to the location Next, returning
  // the distance spanned.
  Span moveMut(Loc next);

private:
  Loc nextcol() const { return Loc(filename, si + 1, line, col + 1); }

  Loc prevcol() const {
    assert(col - 1 >= 1);
    return Loc(filename, si - 1, line, col - 1);
  }
};

OutFile &operator<<(OutFile &o, const Loc &l) {
  return cout << ":" << l.line << ":" << l.col;
}

// half open [...)
// substr := str[span.begin...span.end-1];
struct Span {
  Loc begin, end;

  Span(Loc begin, Loc end) : begin(begin), end(end) {
    debug_assert(end.si >= begin.si);
    debug_assert(!strcmp(begin.filename, end.filename));
  };

  ll nchars() const { return end.si - begin.si; }

  Span extendRight(Span rightward) const {
    assert(this->end.si <= rightward.begin.si);
    return Span(this->begin, rightward.end);
  }

  Span extendRight(Loc rightward) const {
    assert(this->end.si <= rightward.si);
    return Span(this->begin, rightward);
  }
};

Span Loc::moveMut(Loc next) {
  assert(next.si >= this->si);
  Span s(*this, next);
  *this = next;
  return s;
}

OutFile &operator<<(OutFile &o, const Span &s) {
  return cout << s.begin << " - " << s.end;
}

// TODO: upgrade this to take a space, not just a location.
void vprintfspan(Span span, const char *raw_input, const char *fmt,
                 va_list args) {
  char *outstr = nullptr;
  vasprintf(&outstr, fmt, args);
  assert(outstr);
  cerr << "===\n";
  cerr << span.begin << ":" << span.end << "\n";

  cerr << "===\n";
  cerr << span << "\t" << outstr << "\n";
  for (ll i = span.begin.si; i < span.end.si; ++i) {
    cerr << raw_input[i];
  }
  cerr << "\n===\n";
}

void printfspan(Span span, const char *raw_input, const char *fmt, ...) {
  va_list args;
  va_start(args, fmt);
  vprintfspan(span, raw_input, fmt, args);
  va_end(args);
}


void vprintferrspan(Span span, const char *raw_input, const char *fmt, va_list args) {
  const int CONTEXTLEN = 25;
  const int LINELEN = 80;

  char *outstr = nullptr;
  vasprintf(&outstr, fmt, args);
  assert(outstr);


  if (span.begin.line == span.end.line) {
      std::string errstr, cursorstr;
      const ll nchars_back = ({
        ll i = 0;
        while(1) {
          if(span.begin.si - i == 0) { break; }      
          if(raw_input[span.begin.si - i] == '\n') { i--; break; }      
          if (i > CONTEXTLEN) { break; }
          i++;
        }
        i;
      });

      const ll nchars_fwd = ({
        ll i = 0;
        while(1) {
          if(raw_input[span.begin.si + i] == 0) { break; }      
          if(raw_input[span.begin.si + i] == '\n') { i--; break; }      
          if (i > CONTEXTLEN) { break; }
          i++;
        }
        i;
      });

    if (nchars_back > CONTEXTLEN) { 
      cursorstr += "..."; errstr += "...";
    }


    errstr += std::string(raw_input+span.begin.si-nchars_back, raw_input+span.end.si+nchars_fwd);
    cursorstr += std::string(nchars_back, ' ');
    cursorstr += std::string(span.end.si - span.begin.si, '^');
    cursorstr += std::string(nchars_fwd, ' ');

    
    if (nchars_fwd > CONTEXTLEN) {
      cursorstr += "..."; errstr += "...";
    }

    cerr << "\n==\n"
       << outstr << "\n"
       << span.begin.filename << span << "\n"
       << errstr.c_str() << "\n"
       << cursorstr.c_str() << "\n==\n";
  } else {
    // multi-line error.
    std::string errstr = "";
    for(int i = span.begin.si; i != span.end.si; ++i) {
        errstr += raw_input[i];
        if (raw_input[i] == '\n') {errstr += '>'; }
    }
    cerr << "\n==\n"
       << outstr << "\n"
       << span.begin.filename << span << "\n"
       << errstr << "\n==\n";
  }
}


void vprintferr(Loc loc, const char *raw_input, const char *fmt, va_list args) {
  char *outstr = nullptr;
  vasprintf(&outstr, fmt, args);
  assert(outstr);

  const int LINELEN = 80;
  const int CONTEXTLEN = 25;
  char line_buf[2 * LINELEN];
  char pointer_buf[2 * LINELEN];

  // find the previous newline character, or some number of characters back.
  // Keep a one window lookahead.
  ll nchars_back = 0;
  for (; loc.si - nchars_back >= 1 &&
         raw_input[loc.si - (nchars_back + 1)] != '\n';
       nchars_back++) {
  }

  int outix = 0;
  if (nchars_back > CONTEXTLEN) {
    nchars_back = CONTEXTLEN;
    for (int i = 0; i < 3; ++i, ++outix) {
      line_buf[outix] = '.';
      pointer_buf[outix] = ' ';
    }
  }

  {
    int inix = loc.si - nchars_back;
    for (; inix - loc.si <= CONTEXTLEN; ++inix, ++outix) {
      if (raw_input[inix] == '\0') {
        break;
      }
      if (raw_input[inix] == '\n') {
        break;
      }
      line_buf[outix] = raw_input[inix];
      pointer_buf[outix] = (inix == loc.si) ? '^' : ' ';
    }

    if (raw_input[inix] != '\0' && raw_input[inix] != '\n') {
      for (int i = 0; i < 3; ++i, ++outix) {
        line_buf[outix] = '.';
        pointer_buf[outix] = ' ';
      }
    }
    line_buf[outix] = pointer_buf[outix] = '\0';
  }

  cerr << "\n==\n"
       << outstr << "\n"
       << loc.filename << loc << "\n"
       << line_buf << "\n"
       << pointer_buf << "\n==\n";
  free(outstr);
}

void printferr(Span span, const char *raw_input, const char *fmt, ...) {
  va_list args;
  va_start(args, fmt);
  vprintferrspan(span, raw_input, fmt, args);
  va_end(args);
}

bool isWhitespace(char c) { return c == ' ' || c == '\n' || c == '\t'; }
bool isReservedSigil(char c) {
  return c == '(' || c == ')' || c == '{' || c == '}' || c == ',' || c == ';' ||
         c == '[' || c == ']' || c == ':' || c == '-' || c == '*' || c == '+' ||
         c == '/' || c == '!';
}

/*
 * struct string;

struct stringView {
    friend struct string;

    char operator[](int ix);

    ll nchars() const { return sp.nchars(); }

   private:
    stringView(string &str, Span sp) : str(str), sp(sp){};
    string &str;
    Span sp;
};

// representation of string as str+number of characters.
struct string {
    const ll nchars;

    string substring(Span span) const {
        assert(span.begin.si <= nchars);
        assert(span.end.si <= nchars);
        return string::copyBuf(this->str + span.begin.si, span.nchars());
    }

    static string copyBuf(KEEP const char *buf, int len) {
        char *s = (char *)malloc(len + 1);
        memcpy(s, buf, len);
        s[len] = 0;
        return string(s, len);
    }

    static string copyCStr(KEEP const char *str) {
        const ll len = strlen(str);
        char *out = strdup(str);
        out[len] = 0;
        return string(out, len);
    }

    const char *asCStr() const { return str; }
    std::string const {

      cout << __FILE__ << ":" << __LINE__ << "\n";
      cout << str << "\n";
      std::string s; s = str; return s;
    }

    static string sprintf(const char *fmt, ...) {
        va_list args;
        va_start(args, fmt);
        return sprintf_(fmt, args);
        va_end(args);
    }

    char operator[](ll ix) const {
        assert(ix >= 0);
        assert(ix <= nchars);
        return str[ix];
    }

    bool operator==(const string &other) {
        if (nchars != other.nchars) {
            return false;
        }
        for (ll i = 0; i < nchars; ++i) {
            if (str[i] != other.str[i]) {
                return false;
            }
        }
        return true;
    }

    bool equals(const char *c) const {
      if (nchars != strlen(c)) {
        return false;
      }
      for (ll i = 0; i < nchars; ++i) {
        if (str[i] != c[i]) { return false; }
      }
      return true;
    }
   private:
    // str is null terminated
    const char *str;

    string(TAKE const char *str, int nchars) : nchars(nchars), str(str) {
      assert(str[nchars] == '\0');
      assert(strlen(str) == nchars);
    }

    static string sprintf_(const char *fmt, va_list args) {
        char *str;
        ll len = vasprintf(&str, fmt, args);
        debug_assert(len == (ll)strlen(str));
        return string(str, len);
    }
};

OutFile & operator << (OutFile &o, const string &s) {
    o << s.asCStr(); return o;
}


char stringView::operator[](int ix) {
    debug_assert(ix < this->sp.nchars());
    debug_assert(ix >= 0);
    return (this->str[ix]);
};

Loc Loc::nextstr(const string &s) const {
    Loc cur = *this;
    for (int i = 0; i < s.nchars; ++i) {
        cur = cur.nextc(s[i]);
    }
    return cur;
}
*/
struct ParseError {
  std::string errmsg;
  Span span;

  ParseError(Span span, std::string errmsg) : errmsg(errmsg), span(span){};
};

std::string substring(const std::string &s, Span span) {
  assert(span.end.si - span.begin.si >= 0);
  std::string sub = s.substr(span.begin.si, span.end.si - span.begin.si);
  return sub;
}

// === IR ===
// === IR ===
// === IR ===
// === IR ===
// === IR ===

struct IRTypeError; // forward decl.

enum class IRTypeKind { Int, Enum, Tuple, Fn };
struct IRType {
  IRType(IRTypeKind kind, bool strict) : kind(kind), strict(strict){};
  const IRTypeKind kind;
  // TODO: convert into a virtual method. Derived classes can choose
  // if they want to expose a lazy version of their type or not.
  // Tbh this whole thing is unclear if it's correct or not.
  bool strict;

  virtual void print(OutFile &f) const = 0;
  virtual IRType *clone(bool forced) const = 0;
  // returns nullptr if there is no mismatch between this and other.
  // If there is a mismatch, returns the segment that mismatches.
  // TODO: think about how nice this would be if we could have lenses,
  // and we could pretty print lenses! Alternatively, if we had the diffing
  // mechanism.
  virtual optional<IRTypeError *> mismatch(const IRType *other) const = 0;
};

// TODO: consider making an Enum of type errors?
// TODO: strongly consider this.
struct IRTypeError {
  const IRType *defn;
  const IRType *use;
  IRTypeError(const IRType *defn, const IRType *use) : defn(defn), use(use){};
  virtual void print(const char *raw_input, Span span) = 0;
};

struct IRTypeErrorKindMismatch : public IRTypeError {
  IRTypeErrorKindMismatch(const IRType *defn, const IRType *use)
      : IRTypeError(defn, use){};
  virtual void print(const char *raw_input, Span span) {
    printferr(span, raw_input, "type kind mismatch\n");
    cerr << "expected: ";
    defn->print(cerr);
    cerr << "\n";
    cerr << "found: ";
    use->print(cerr);
    cerr << "\n";
  };
};

struct IRTypeErrorTupleArityMismatch : public IRTypeError {
  IRTypeErrorTupleArityMismatch(const IRType *defn, const IRType *use)
      : IRTypeError(defn, use){};
  virtual void print(const char *raw_input, Span span) {
    printferr(span, raw_input, "tuple arity mismatch\n");
    cerr << "expected: ";
    defn->print(cerr);
    cerr << "\n";
    cerr << "found: ";
    use->print(cerr);
    cerr << "\n";
  };
};

struct IRTypeErrorEnumMissingConstructor : public IRTypeError {
  IRTypeErrorEnumMissingConstructor(const IRType *defn, const IRType *use,
                                    std::string name)
      : IRTypeError(defn, use), name(name){};
  std::string name;

  virtual void print(const char *raw_input, Span span) {
    printferr(span, raw_input, "enum missing constructor: |%s|\n",
              name.c_str());
    cerr << "expected: ";
    defn->print(cerr);
    cerr << "\n";
    cerr << "found: ";
    use->print(cerr);
    cerr << "\n";
  };
};
struct IRTypeErrorEnumExtraConstructor : public IRTypeError {
  IRTypeErrorEnumExtraConstructor(const IRType *defn, const IRType *use,
                                  std::string name)
      : IRTypeError(defn, use), name(name){};
  std::string name;

  virtual void print(const char *raw_input, Span span) {
    printferr(span, raw_input, "enum has extra constructor: |%s|\n",
              name.c_str());
    cerr << "expected: ";
    defn->print(cerr);
    cerr << "\n";
    cerr << "found: ";
    use->print(cerr);
    cerr << "\n";
  };
};

struct IRTypeInt : public IRType {
  IRTypeInt(bool strict) : IRType(IRTypeKind::Int, strict){};
  void print(OutFile &f) const {
    f << (strict ? "!" : "~");
    f << "t-i64";
  }
  static bool classof(const IRType *ty) { return ty->kind == IRTypeKind::Int; }

  IRType *clone(bool forced) const override { return new IRTypeInt(forced); };

  optional<IRTypeError *> mismatch(const IRType *other) const {
    if (other->kind == IRTypeKind::Int) {
      return {};
    }
    return new IRTypeErrorKindMismatch(this, other);
  }
};

struct IRTypeTuple : public IRType {
  IRTypeTuple(vector<IRType *> types, bool strict)
      : IRType(IRTypeKind::Tuple, strict), types(types){};

  IRType *clone(bool forced) const override {
    return new IRTypeTuple(types, forced);
  };

  using iterator = std::vector<IRType *>::iterator;
  using const_iterator = std::vector<IRType *>::const_iterator;

  iterator begin() { return this->types.begin(); }
  iterator end() { return this->types.end(); }

  const_iterator begin() const { return this->types.begin(); }
  const_iterator end() const { return this->types.end(); }

  void print(OutFile &f) const {
    f << "[";
    f << (strict ? "!" : "~");
    f << "tuple ";
    for (IRType *t : types) {
      t->print(f);
      f << " ";
    }
    f << "]";
  }
  static bool classof(const IRType *ty) {
    return ty->kind == IRTypeKind::Tuple;
  }

  int size() const { return this->types.size(); }
  IRType *get(int i) { return this->types[i]; }
  const IRType *get(int i) const { return this->types[i]; }
  
  optional<IRTypeError *> mismatch(const IRType *other) const {
    auto otherTuple = mlir::dyn_cast<IRTypeTuple>(other);
    if (!otherTuple) {
      return new IRTypeErrorKindMismatch(this, other);
    }
    if (this->types.size() != otherTuple->types.size()) {
      return new IRTypeErrorTupleArityMismatch(this, other);
    }
    for (int i = 0; i < this->types.size(); ++i) {
      optional<IRTypeError *> err =
          this->types[i]->mismatch(otherTuple->types[i]);
      if (err) {
        return err;
      }
    }
    return {};
  }
  private:
    vector<IRType *> types;

};

// an enum is NOT A type, it's a *description* of a type. So it doesn't have a
// notion of strictness (?)
struct IRTypeEnum : public IRType {
  string name;
  map<string, IRTypeTuple*> constructors;

  IRTypeEnum(string name, map<string, IRTypeTuple*> constructors, bool strict)
      : IRType(IRTypeKind::Enum, strict), name(name),
        constructors(constructors) {}

  IRType *clone(bool forced) const override {
    return new IRTypeEnum(name, constructors, forced);
  };

  void print(OutFile &f) const {
    f << "[";
    f << (strict ? "!" : "~");
    f << "t-enum";
    for (auto it : constructors) {
      f << "[struct" << it.first << " ";
      it.second->print(f);
      f << "]";
    }

    f << "]";
  }

  optional<IRTypeError *> mismatch(const IRType *other) const {
    auto otherEnum = mlir::dyn_cast<IRTypeEnum>(other);
    if (!otherEnum) {
      return new IRTypeErrorKindMismatch(this, other);
    }
    for (auto itThis : this->constructors) {
      auto itOther = otherEnum->constructors.find(itThis.first);
      if (itOther == otherEnum->constructors.end()) {
        return new IRTypeErrorEnumMissingConstructor(this, other, itThis.first);
      }
    }

    for (auto itOther : otherEnum->constructors) {
      auto itThis = constructors.find(itOther.first);
      if (itThis == constructors.end()) {
        return new IRTypeErrorEnumExtraConstructor(this, other, itOther.first);
      }
    }

    return {};
  }

  static bool classof(const IRType *ty) { return ty->kind == IRTypeKind::Enum; }
};

struct IRTypeFn : public IRType {
  IRTypeFn(IRTypeTuple argTys, IRType *retty, bool strict)
      : IRType(IRTypeKind::Fn, strict), argTys(argTys), retty(retty){};

  IRTypeTuple argTys;
  IRType *retty;
  virtual void print(OutFile &f) const {
    f << "[";
    f << (strict ? "!" : "~");
    f << "t-fn";
    argTys.print(f);
    f << "-> ";
    retty->print(f);
    f << "]";
  }

  IRType *clone(bool forced) const {
    return new IRTypeFn(argTys, retty, strict);
  }

  optional<IRTypeError *> mismatch(const IRType *other) const {
    auto otherFn = mlir::dyn_cast<IRTypeFn>(other);
    if (!otherFn) {
      return new IRTypeErrorKindMismatch(this, other);
    }
    optional<IRTypeError *> argsCheck = this->argTys.mismatch(&otherFn->argTys);
    if (argsCheck) {
      return argsCheck;
    }
    return this->retty->mismatch(otherFn->retty);
  }

  static bool classof(const IRType *ty) { return ty->kind == IRTypeKind::Fn; }
};

// === AST ===
// === AST ===
// === AST ===
// === AST ===
// === AST ===
// === AST ===

// TODO: consider replacing this with the class ExprIdentifier?
struct Identifier {
  const Span span;
  const std::string name;
  Identifier(const Identifier &other) = default;
  Identifier(Span span, std::string name) : span(span), name(name){};

  Identifier operator=(const Identifier &other) { return Identifier(other); }

  void print(OutFile &f) const { f << name; }
};

struct Parser {
  Parser(const char *filename, const char *raw)
      : s(raw), l(filename, 0, 1, 1){};

  void parseOpenCurly() { parseSigil("{"); }
  void parseCloseCurly() { parseSigil("}"); }
  void parseFatArrow() { parseSigil("=>"); }
  bool parseOptionalCloseCurly() { return bool(parseOptionalSigil("}")); }
  Span parseOpenRoundBracket() { return parseSigil("("); }
  optional<Span> parseOptionalOpenCurly() { return parseOptionalSigil("{"); }

  optional<Span> parseOptionalOpenRoundBracket() {
    return parseOptionalSigil("(");
  }

  Span parseCloseRoundBracket(Span open) {
    return parseMatchingSigil(open, ")");
  }

  bool parseOptionalCloseRoundBracket() {
    return bool(parseOptionalSigil(")"));
  }
  void parseColon() { parseSigil(":"); }
  void parseEqual() { parseSigil("="); }

  bool parseOptionalComma() { return bool(parseOptionalSigil(",")); }

  void parseComma() { parseSigil(","); }
  void parseSemicolon() { parseSigil(";"); }
  bool parseOptionalSemicolon() { return bool(parseOptionalSigil(";")); }
  void parseThinArrow() { parseSigil("->"); }

  pair<Span, ll> parseInteger() {
    optional<pair<Span, ll>> out = parseOptionalInteger();
    if (!out) {
      this->addErr(ParseError(Span(l, l), "unble to find integer"));
      exit(1);
    }
    return *out;
  }

  // [-][0-9]+
  optional<pair<Span, ll>> parseOptionalInteger() {
    eatWhitespace();
    bool negate = false;
    optional<char> ccur; // peeking character
    Loc lcur = l;

    ccur = this->at(lcur);
    if (!ccur) {
      return {};
    }
    if (*ccur == '-') {
      negate = true;
      lcur = lcur.nextc(*ccur);
    }

    ll number = 0;
    while (1) {
      ccur = this->at(lcur);
      if (!ccur) {
        break;
      }
      if (!isdigit(*ccur)) {
        break;
      }
      number = number * 10 + (*ccur - '0');
      lcur = lcur.nextc(*ccur);
    }
    Span span = l.moveMut(lcur);
    if (span.nchars() == 0) {
      return {};
    }
    if (negate) {
      number *= -1;
    }

    return {{span, number}};
  }

  Span parseSigil(const string sigil) {
    optional<Span> span = parseOptionalSigil(sigil);
    if (span) {
      return *span;
    }

    addErr(ParseError(Span(l, l), "expected sigil> |" + sigil + "|"));
    exit(1);
  }

  Span parseMatchingSigil(Span open, const string sigil) {
    optional<Span> span = parseOptionalSigil(sigil);
    if (span) {
      return *span;
    }

    addErr(ParseError(Span(l, l), "expected sigil: |" + sigil + "|"));
    exit(1);
  }

  // difference is that a sigil needs no whitespace after it, unlike
  // a keyword.
  optional<Span> parseOptionalSigil(const string sigil) {
    //        cerr << __FUNCTION__ << "|" << sigil << "|\n";
    optional<char> ccur;
    eatWhitespace();
    Loc lcur = l;
    // <sigil>

    for (ll i = 0; i < sigil.size(); ++i) {
      ccur = this->at(lcur);
      if (!ccur) {
        return {};
      }
      //            cerr << "-sigil: |" << ccur << "|\n";
      if (*ccur != sigil[i]) {
        return {};
      }
      lcur = lcur.nextc(*ccur);
    }

    Span span = l.moveMut(lcur);
    return span;
  }

  Identifier parseIdentifier() {
    optional<Identifier> ms = parseOptionalIdentifier();
    if (ms.has_value()) {
      return *ms;
    }
    addErr(ParseError(Span(l, l), "expected identifier"));
    exit(1);
  }

  optional<Identifier> parseOptionalIdentifier() {

    eatWhitespace();
    Loc lcur = l;

    optional<char> fst = this->at(lcur);
    if (!fst) {
      return {};
    }
    if (!isalpha(*fst)) {
      return {};
    }
    lcur = lcur.nextc(*fst);

    while (1) {
      optional<char> cchar = this->at(lcur);
      if (!cchar) {
        return {};
      }
      if (isWhitespace(*cchar) || isReservedSigil(*cchar)) {
        break;
      }
      lcur = lcur.nextc(s[lcur.si]);
    }

    const Span span = l.moveMut(lcur);
    return Identifier(span, substring(s, span));
  }

  optional<Span> parseOptionalKeyword(const string keyword) {
    eatWhitespace();
    // <keyword><non-alpha-numeric>
    Loc lcur = l;
    for (int i = 0; i < keyword.size(); ++i) {
      optional<char> c = this->at(lcur);
      if (!c) {
        return {};
      }
      if (c != keyword[i]) {
        return {};
      }
      lcur = lcur.nextc(*c);
    }
    optional<char> c = this->at(lcur);
    if (!c) {
      return {};
    }
    if (isalnum(*c)) {
      return {};
    }

    return l.moveMut(lcur);
  };

  Span parseKeyword(const string keyword) {
    optional<Span> ms = parseOptionalKeyword(keyword);
    if (ms) {
      return *ms;
    }
    addErr(ParseError(Span(l, l), "expected |" + keyword + "|"));
    exit(1);
  }

  void addErr(ParseError e) {
    errs.push_back(e);
    printferr(e.span, s.c_str(), e.errmsg.c_str());
  }

  void addErrAtCurrentLoc(string err) { addErr(ParseError(Span(l, l), err)); }

  bool eof() {
    eatWhitespace();
    return l.si == s.size();
  }

  // eat till newline
  void eatTillNewline() {
    while (1) {
      optional<char> c = this->at(l);
      if (!c) {
        return;
      }
      l = l.nextc(*c);
      if (c == '\n') {
        return;
      }
    }
  }

  Loc getCurrentLoc() {
    eatWhitespace();
    return l;
  }

private:
  const string s;
  Loc l;
  vector<ParseError> errs;

  optional<char> at(Loc loc) {
    if (loc.si >= s.size()) {
      return optional<char>();
    }
    return s[loc.si];
  }

  void eatWhitespace() {
    while (1) {
      optional<char> ccur = this->at(l);
      if (!ccur) {
        return;
      }
      if (!isWhitespace(*ccur)) {
        return;
      }
      l = l.nextc(*ccur);
    }
  }
};

// TODO: at some point, need to differentiate between the AST encoding of the
// type and the "real" types
struct SurfaceType {
  const Span span;
  const Identifier tyname;
  bool strict; // tracks if type is lazy or strict.
  SurfaceType(Span span, Identifier tyname, bool strict)
      : span(span), tyname(tyname), strict(strict) {}
  void print(OutFile &out) const { out << (strict ? "!" : "") << tyname; }
};

enum class CaseLHSKind { Int, Identifier, TupleStruct };

struct CaseLHS {
  const Span span;
  const CaseLHSKind kind;

  CaseLHS(Span span, CaseLHSKind kind) : span(span), kind(kind) {}
  virtual OutFile &print(OutFile &o) const = 0;
};

struct CaseLHSInt : public CaseLHS {
  const ll value;

  CaseLHSInt(Span span, ll value)
      : CaseLHS(span, CaseLHSKind::Int), value(value) {}

  OutFile &print(OutFile &out) const override { return out << value; }

  static bool classof(const CaseLHS *e) { return e->kind == CaseLHSKind::Int; }
};

struct CaseLHSIdentifier : public CaseLHS {
  const Identifier ident;
  CaseLHSIdentifier(Span span, Identifier ident)
      : CaseLHS(span, CaseLHSKind::Identifier), ident(ident){};
  IRType *type;

  OutFile &print(OutFile &out) const override { return out << ident; }

  static bool classof(const CaseLHS *e) {
    return e->kind == CaseLHSKind::Identifier;
  }
};

struct CaseLHSTupleStruct : public CaseLHS {
  const Identifier name;
  vector<Identifier > fields;
  IRTypeTuple *type;

  CaseLHSTupleStruct(Span span, Identifier name, vector<Identifier> fields)
      : CaseLHS(span, CaseLHSKind::TupleStruct), name(name), fields(fields), type(nullptr) {};

  OutFile &print(OutFile &out) const override {
    out << name << "(";
    for (int i = 0; i < fields.size(); ++i) {
      out << fields[i];
      if (i + 1 < fields.size()) {
        out << ", ";
      }
    }
    out << ")";
    return out;
  }

  static bool classof(const CaseLHS *e) {
    return e->kind == CaseLHSKind::TupleStruct;
  }
};

enum class ExprKind { Case, Identifier, Integer, FnCall, Binop, Construct };

struct Expr {
  const Span span;
  const ExprKind kind;
  Expr(Span span, ExprKind kind) : span(span), kind(kind){};
  virtual OutFile &print(OutFile &out) const = 0;
  IRType *type = nullptr;
};

struct Block;
struct ExprCase : public Expr {
  using Alt = pair<CaseLHS *, Block *>;

  ExprCase(Span span, Expr *scrutinee, vector<Alt> alts)
      : Expr(span, ExprKind::Case), scrutinee(scrutinee), alts(alts){};
  Expr *scrutinee;
  vector<Alt> alts;

  OutFile &print(OutFile &out) const override;

  static bool classof(const Expr *e) { return e->kind == ExprKind::Case; }
};

struct ExprIdentifier : public Expr {
  const string name;
  ExprIdentifier(Span span, string name)
      : Expr(span, ExprKind::Identifier), name(name) {}

  OutFile &print(OutFile &out) const override {
    return out << name;
    //        return out << "ident:" << name << "|[" << int(this->kind) << "]";
  }

  Identifier toIdentifier() const { return Identifier(span, name); }

  static bool classof(const Expr *e) { return e->kind == ExprKind::Identifier; }
};

struct ExprInteger : public Expr {
  const ll value;
  ExprInteger(Span span, ll value)
      : Expr(span, ExprKind::Integer), value(value) {}

  OutFile &print(OutFile &out) const override { return out << value; }

  static bool classof(const Expr *e) { return e->kind == ExprKind::Integer; }
};

enum class Binop { Mul, Sub };

OutFile &operator<<(OutFile &o, Binop b) {
  switch (b) {
  case Binop::Mul:
    return o << "*";
  case Binop::Sub:
    return o << "-";
  }

  assert(false && "unreachable!");
}

struct ExprBinop : public Expr {
  Expr *left;
  Expr *right;
  const Binop binop;
  ExprBinop(Span span, Expr *left, Binop binop, Expr *right)
      : Expr(span, ExprKind::Binop), left(left), right(right), binop(binop){};

  OutFile &print(OutFile &out) const override {
    out << "[bop " << binop;
    out << " ";
    left->print(out);
    out << " ";
    right->print(out);
    out << "]";
    return out;
  }

  static bool classof(const Expr *e) { return e->kind == ExprKind::Binop; }
};

struct ExprConstruct : public Expr {
  Identifier constructorName;
  vector<Expr *> args;

  ExprConstruct(Span span, Identifier constructorName, vector<Expr *> args)
      : Expr(span, ExprKind::Construct), constructorName(constructorName),
        args(args){};

  OutFile &print(OutFile &out) const override {
    out << "[construct ";
    out << constructorName.name << " ";
    for (int i = 0; i < (ll)args.size(); ++i) {
      args[i]->print(out);
      if (i + 1 < (ll)args.size())
        out << ", ";
    }
    out << " ]";
    return out;
  }

  static bool classof(const Expr *e) { return e->kind == ExprKind::Construct; }
};

struct ExprFnCall : public Expr {
  Identifier fnname;
  vector<Expr *> args;
  bool strict;

  ExprFnCall(Span span, Identifier fnname, vector<Expr *> args, bool strict)
      : Expr(span, ExprKind::FnCall), fnname(fnname), args(args),
        strict(strict){};

  OutFile &print(OutFile &out) const override {
    out << "[call ";
    out << fnname.name;
    out << (strict ? "!" : "~");
    out << " ";
    for (int i = 0; i < (ll)args.size(); ++i) {
      args[i]->print(out);
      if (i + 1 < (ll)args.size())
        out << ", ";
    }
    out << " ]";
    return out;
  }

  static bool classof(const Expr *e) { return e->kind == ExprKind::FnCall; }
};

enum class StmtKind { Return, Let };

struct Stmt {
  virtual void print(OutFile &out) const = 0;
  Stmt(Span span, StmtKind Kind) : span(span), Kind(Kind){};
  const StmtKind Kind;
  Span span;
};

struct StmtReturn : public Stmt {
  Expr *e;
  StmtReturn(Span span, TAKE Expr *e) : Stmt(span, StmtKind::Return), e(e){};

  void print(OutFile &o) const { o << "return " << *e; }

  static bool classof(const Stmt *S) { return S->Kind == StmtKind::Return; }
};

struct StmtLet : public Stmt {
  Identifier name;
  SurfaceType type;
  Expr *rhs;
  StmtLet(Span span, Identifier name, SurfaceType type, TAKE Expr *rhs)
      : Stmt(span, StmtKind::Let), name(name), type(type), rhs(rhs){};
  void print(OutFile &o) const {
    o << "let ";
    name.print(o);
    o << " : ";
    type.print(o);
    o << " = ";
    rhs->print(o);
  }

  static bool classof(const Stmt *S) { return S->Kind == StmtKind::Let; }
};

struct Block {
  const vector<Stmt *> stmts;
  Span span;
  IRType *type = nullptr;

  Block(Span span, vector<Stmt *> stmts) : span(span), stmts(stmts){};

  OutFile &print(OutFile &out) const {
    out.indent();
    out << "{\n";
    for (const Stmt *s : stmts) {
      s->print(out);
      out << "\n";
    }
    out.dedent();
    out << "\n}";
    return out;
  }
};

SurfaceType parseType(Parser &in) {
  Loc lbegin = in.getCurrentLoc();
  optional<Identifier> ident;
  bool strict = false;
  if (in.parseOptionalSigil("!")) {
    strict = true;
  }
  if ((ident = in.parseOptionalIdentifier())) {
    return SurfaceType(Span(lbegin, in.getCurrentLoc()), *ident, strict);
  } else {
    in.addErrAtCurrentLoc("expected type.");
    exit(1);
  }
}

OutFile &ExprCase::print(OutFile &out) const {
  out << "match ";
  scrutinee->print(out);
  out.indent();
  out << " {\n";

  for (int i = 0; i < (ll)alts.size(); ++i) {
    alts[i].first->print(out);
    out << " => ";
    alts[i].second->print(out);
    if (i + 1 < (ll)alts.size()) {
      out << ",\n";
    }
  }

  out.dedent();
  out << "\n}";
  return out;
}

CaseLHS *parseCaseLHS(Parser &in) {
  optional<pair<Span, ll>> integer(in.parseOptionalInteger());
  // parse pattern match
  if (integer) {
    return new CaseLHSInt(integer->first, integer->second);
  }

  // <ident>  |  <struct-name> (<struct-fields>)

  Identifier ident = in.parseIdentifier();
  optional<Span> structFieldRoundOpen;
  structFieldRoundOpen = in.parseOptionalOpenRoundBracket();
  if (!structFieldRoundOpen) {
    return new CaseLHSIdentifier(ident.span, ident);
  }

  Span tupleStructSpan(ident.span);

  vector<Identifier> fields;

  // parse identifiers
  while (1) {
    Identifier field = in.parseIdentifier();
    fields.push_back(field);
    if (!in.parseOptionalComma()) {
      tupleStructSpan.extendRight(
          in.parseCloseRoundBracket(*structFieldRoundOpen));
      break;
    }
  }
  return new CaseLHSTupleStruct(tupleStructSpan, ident, fields);
}

Expr *parseExprTop(Parser &in);

// fncall identifier | number |
Expr *parseExprLeaf(Parser &in) {
  Loc lbegin = in.getCurrentLoc();
  std::optional<Identifier> ident = in.parseOptionalIdentifier();
  if (ident) {
    optional<Span> strict = in.parseOptionalSigil("!");
    // function call or constructor!
    optional<Span> open;
    if ((open = in.parseOptionalOpenRoundBracket())) {
      if (in.parseOptionalCloseRoundBracket()) {
        return new ExprFnCall(Span(lbegin, in.getCurrentLoc()), *ident, {},
                              bool(strict));
      }

      vector<Expr *> args;
      while (1) {
        args.push_back(parseExprTop(in));
        if (in.parseOptionalComma()) {
          continue;
        } else {
          in.parseCloseRoundBracket(*open);
          break;
        }
      }

      if (islower(ident->name[0])) {
        return new ExprFnCall(Span(lbegin, in.getCurrentLoc()), *ident, args,
                              bool(strict));
      } else {
        return new ExprConstruct(Span(lbegin, in.getCurrentLoc()), *ident,
                                 args);
      }

    } else {
      return new ExprIdentifier(ident->span, ident->name);
    }
  }

  std::optional<pair<Span, ll>> integer = in.parseOptionalInteger();
  if (integer) {
    return new ExprInteger(integer->first, integer->second);
  }

  in.addErrAtCurrentLoc("expected expression");
  exit(1);
}

// EMulDiv = ELeaf * E | ELeaf / E
Expr *parseExprArithMulDiv(Parser &in) {
  Loc lbegin = in.getCurrentLoc();
  Expr *left = parseExprLeaf(in);
  if (in.parseOptionalSigil("*")) {
    Expr *right = parseExprTop(in);
    return new ExprBinop(Span(lbegin, in.getCurrentLoc()), left, Binop::Mul,
                         right);
  }
  return left;
}

// EAddSub = EMulDiv + E | EMulDiv - E
Expr *parseExprArithAddSub(Parser &in) {
  Loc lbegin = in.getCurrentLoc();
  Expr *left = parseExprArithMulDiv(in);
  if (in.parseOptionalSigil("-")) {
    Expr *right = parseExprTop(in);
    return new ExprBinop(Span(lbegin, in.getCurrentLoc()), left, Binop::Sub,
                         right);
  }
  return left;
}

// forward declaration.
Block *parseBlockOrStmt(Parser &in);
Expr *parseExprTop(Parser &in) {
  const Loc lbegin = in.getCurrentLoc();

  if (in.parseOptionalKeyword("match")) {
    Expr *scrutinee = parseExprTop(in);
    in.parseOpenCurly();
    vector<pair<CaseLHS *, Block *>> alts;
    while (1) {
      CaseLHS *lhs = parseCaseLHS(in);
      in.parseFatArrow();
      Block *rhs = parseBlockOrStmt(in);
      // Expr *rhs = parseExprTop(in);
      alts.push_back({lhs, rhs});

      if (in.parseOptionalCloseCurly()) {
        break;
      }
      // } else {
      //     in.parseComma();
      // }
    }
    return new ExprCase(Span(lbegin, in.getCurrentLoc()), scrutinee, alts);
  }

  Expr *e = parseExprArithAddSub(in);
  if (e) {
    return e;
  }

  in.addErrAtCurrentLoc("unable to parse expression");
  exit(1);
}

Stmt *parseStmt(Parser &in) {
  Loc begin = in.getCurrentLoc();
  if (in.parseOptionalKeyword("return")) {
    Expr *e = parseExprTop(in);
    return new StmtReturn(Span(begin, e->span.end), e);
  } else if (in.parseOptionalKeyword("let")) {
    Identifier name = in.parseIdentifier();
    in.parseColon();
    SurfaceType t = parseType(in);
    in.parseEqual();
    Expr *e = parseExprTop(in);
    return new StmtLet(Span(begin, e->span.end), name, t, e);
  }

  in.addErrAtCurrentLoc("expected statement");
  exit(1);
}

// parse either a block, or a single statement
Block *parseBlockOrStmt(Parser &in) {
  Loc lbegin = in.getCurrentLoc();
  if (in.parseOptionalOpenCurly()) {
    vector<Stmt *> stmts;

    while (!in.parseOptionalCloseCurly()) {
      stmts.push_back(parseStmt(in));
      in.parseSemicolon();
    }
    return new Block(Span(lbegin, in.getCurrentLoc()), stmts);
  } else {
    vector<Stmt *> stmts = {parseStmt(in)};
    in.parseSemicolon();
    return new Block(Span(lbegin, in.getCurrentLoc()), stmts);
  }
}

Block *parseBlock(Parser &in) {
  vector<Stmt *> stmts;
  Loc lbegin = in.getCurrentLoc();
  in.parseOpenCurly();

  while (!in.parseOptionalCloseCurly()) {
    stmts.push_back(parseStmt(in));
    in.parseSemicolon();
  }
  return new Block(Span(lbegin, in.getCurrentLoc()), stmts);
}

struct Fn {
  using Argument = std::pair<Identifier, SurfaceType>;
  const Span span;
  const Identifier name;
  const vector<Argument> args;
  SurfaceType retty;
  Block *body;
  IRTypeFn *type;

  Fn(Span span, Identifier name, vector<Argument> args, SurfaceType retty,
     Block *body)
      : span(span), name(name), args(args), retty(retty), body(body), type(nullptr) {};

  OutFile &print(OutFile &out) const {
    out << name.name << "(";
    for (int i = 0; i < (ll)args.size(); ++i) {
      out << args[i].first.name << " : " << args[i].second;
      if (i + 1 < (ll)args.size()) {
        out << ", ";
      }
    }
    out << ")";
    out << " -> "; this->retty.print(out); out << " ";
    body->print(out);
    return out;
  }
};

Fn parseFn(Parser &in) {
  Loc lbegin = in.getCurrentLoc();
  Identifier ident = in.parseIdentifier();
  Span open = in.parseOpenRoundBracket();
  vector<pair<Identifier, SurfaceType>> params;
  if (!in.parseOptionalCloseRoundBracket()) {
    while (1) {
      Identifier name = in.parseIdentifier();
      in.parseColon();
      SurfaceType t = parseType(in);
      params.push_back({name, t});
      if (in.parseOptionalComma()) {
        continue;
      }
      in.parseCloseRoundBracket(open);
      break;
    }
  }

  in.parseThinArrow();
  SurfaceType retty = parseType(in);
  Block *b = parseBlock(in);
  return Fn(Span(lbegin, in.getCurrentLoc()), ident, params, retty, b);
}

enum class StructFieldsKind { Tuple };
struct StructFields {
  Span span;
  const StructFieldsKind kind;
  StructFields(Span span, StructFieldsKind kind) : span(span), kind(kind){};
};

struct StructFieldsTuple : public StructFields {
  StructFieldsTuple(Span span, vector<SurfaceType> types)
      : StructFields(span, StructFieldsKind::Tuple), types(types){};
  const vector<SurfaceType> types;

  static bool classof(const StructFields *base) {
    return base->kind == StructFieldsKind::Tuple;
  }
};

StructFields *parseStructFields(Parser &in) {
  Loc lbegin = in.getCurrentLoc();
  in.parseOpenRoundBracket();
  vector<SurfaceType> types;

  if (in.parseOptionalCloseRoundBracket()) {
    /*done*/
  } else {
    while (1) {
      types.push_back(parseType(in));
      if (in.parseOptionalCloseRoundBracket()) {
        break;
      } else {
        in.parseComma();
      }
    }
  }
  return new StructFieldsTuple(Span(lbegin, in.getCurrentLoc()), types);
}

struct Struct {
  const Span span;
  const Identifier name;
  StructFields *fields;

  // IRTypeEnum *type = nullptr;
  Struct(Span span, Identifier name, StructFields *fields)
      : span(span), name(name), fields(fields){};
};

Struct parseStruct(Parser &in) {
  Loc lbegin = in.getCurrentLoc();
  Identifier ident = in.parseIdentifier();
  StructFields *fields = parseStructFields(in);
  in.parseOptionalSemicolon();
  return Struct(Span(lbegin, in.getCurrentLoc()), ident, fields);
}

struct Enum {
  const Span span;
  const Identifier name;
  using EnumConstructor = pair<Identifier, StructFields *>;
  const vector<EnumConstructor> constructors;

  Enum(Span span, Identifier name, vector<EnumConstructor> constructors)
      : span(span), name(name), constructors(constructors){};
};

Enum parseEnum(Parser &in) {
  Loc lbegin = in.getCurrentLoc();
  vector<Enum::EnumConstructor> cs;

  Identifier enumName = in.parseIdentifier();
  in.parseOpenCurly();
  // enum must have 1 or more fields
  while (1) {
    Identifier cname = in.parseIdentifier();
    StructFields *f = parseStructFields(in);
    cs.push_back({cname, f});

    if (in.parseOptionalCloseCurly()) {
      break;
    } else {
      in.parseComma();
    }
  }
  in.parseSemicolon();
  return Enum(Span(lbegin, in.getCurrentLoc()), enumName, cs);
}

struct Module {
  vector<Fn> fns;
  vector<Struct> structs;
  vector<Enum> enums;
  OutFile &print(OutFile &out) const {
    for (Fn f : fns) {
      f.print(out);
      out << "\n";
    }
    return out;
  };
};

Module parseModule(Parser &in) {
  Module m;
  while (!in.eof()) {
    if (in.parseOptionalKeyword("fn")) {
      m.fns.push_back(parseFn(in));
    } else if (in.parseOptionalKeyword("struct")) {
      m.structs.push_back(parseStruct(in));
    } else if (in.parseOptionalKeyword("enum")) {
      m.enums.push_back(parseEnum(in));
    } else if (in.parseOptionalSigil("//")) {
      in.eatTillNewline();
    } else {
      in.addErrAtCurrentLoc("unknown top level starter");
      assert(false && "unknown top level form.");
    }
  }

  return m;
}

// == TYPE CHECKING / TYPE INFO GATHERING ==
// == TYPE CHECKING / TYPE INFO GATHERING ==
// == TYPE CHECKING / TYPE INFO GATHERING ==
// == TYPE CHECKING / TYPE INFO GATHERING ==
// == TYPE CHECKING / TYPE INFO GATHERING ==
// == TYPE CHECKING / TYPE INFO GATHERING ==

struct TypeContext {
public:
  TypeContext(const char *raw_input) : raw_input(raw_input){};

  void assertNonStrict(const IRType *t, Span span) {
    if (!t->strict) return;
    printferr(span, raw_input, "expected lazy type, found strict type:\n");
    t->print(cerr); cerr << "\n";
    assert(false && "expected lazy type");
  }

  void assertStrict(const IRType *t, Span span) {
    if (t->strict) return;
    printferr(span, raw_input, "expected strict type, found lazy type:\n");
    t->print(cerr); cerr << "\n";
    assert(false && "expected strict type");
  }

  void assertTypeEquality(const IRType *defn, const IRType *use, Span span) {
    optional<IRTypeError *> err = defn->mismatch(use);
    if (!err) {
      return;
    }
    (*err)->print(this->raw_input, span);
    printferr(span, raw_input,
              "type error mismatch generated from def/use:\n", span.begin);
    cerr << "defn: ";
    defn->print(cerr);
    cerr << "\n";
    cerr << "use: ";
    use->print(cerr);
    cerr << "\n";
    assert(false && "type error");
  };

  void assertFntyNArgs(const IRTypeFn *fnty, int nargs, Span span) {
    if (fnty->argTys.size() == nargs) {
      return;
    }
    printferr(span, raw_input,
              "mismatched number of arguments at call site: ");
    cerr << "function type:\n";
    fnty->print(cerr);
    cerr << "\n";
    assert(false && "mismatched number of arguments!");
  };

  void assertVoidBlock(Span span) {
    printferr(span, raw_input, "block has no return instruction\n");
    assert(false && "found block with no return");
  }

  // check that enum has the constructor and return the corresponding tuple,
  // or error out.
  IRTypeTuple *assertExpectedConstructorInEnum(IRTypeEnum *enumty,
                                              Identifier constructor,
                                              int size) {
    auto it = enumty->constructors.find(constructor.name);
    if (it == enumty->constructors.end()) {
      printferr(constructor.span, raw_input,
                "unable to find constructor |%s| in enum |%s|\n",
                constructor.name.c_str(), enumty->name.c_str());
      assert(false && "unknown constructor for type");
    }

    if (it->second->size() != size) {
      printferr(constructor.span, raw_input,
                "expected |%d| fields in constructor |%s| of enum |%s|, found "
                "|%d| fields\n",
                size, constructor.name.c_str(), enumty->name.c_str(),
                it->second->size());
      assert(false && "incorrect number of args to tuple type");
    }

    return it->second;
  }

  void assertInteger(const IRType *user, Span span) {
    if (user->kind == IRTypeKind::Int) { return; }
    printferr(span, raw_input, "expected integer type. found:\n");
    user->print(cerr); cerr << "\n";
    assert(false && "expected integer type");
  }

  IRType *lookupValue(Identifier ident) const {
    auto it = ident2ty.find(ident.name);

    if (it == ident2ty.end()) {
      printferr(ident.span, raw_input,
                "unable to find value |%s| during type checking!\n", ident.name.c_str());
      assert(false && "unable to find value");
    }
    return it->second;
  }

  template <typename T>
  T *lookupValueOfType(Identifier ident, std::string error) const {
    IRType *t = lookupValue(ident);
    return this->cast<T>(t, ident.span, error);
  }

  IRTypeInt *getIntType(bool strict) { return new IRTypeInt(strict); }

  IRType *lookupTypeName(Identifier typenam) const {
    auto it = surface2ty.find(typenam.name);
    if (it == surface2ty.end()) {
      printferr(typenam.span, raw_input, "unable to find type named: |%s|\n",
                typenam.name.c_str());
      // TODO: find some way to smuggle |raw_input| here.
      // raw_input? from where the fuck am I supposed to get that to print an
      // error? smh.
      assert(false && "unable to find type");
    }
    return it->second;
  }

    template<typename T>
    T *lookupTypeNameOfType(Identifier typenam) const {
      T* result = mlir::dyn_cast<T>(lookupTypeName(typenam));
      if (result) { return result; }
      assert(false && "unable to cast type to expected type");
  }

  void insertIRType(std::string name, IRType *t) {
    assert(surface2ty.find(name) == surface2ty.end());
    surface2ty.insert({name, t});
  }

  void insertIdentifier(Identifier name, IRType *t) {
    if (ident2ty.find(name.name) != ident2ty.end()) {
      printferr(name.span, raw_input, "identifier |%s| already present in scope during type checking", name.name.c_str());
    };

    assert(ident2ty.find(name.name) == ident2ty.end());
    ident2ty.insert({name.name, t});
  }

  template <typename T> T *cast(IRType *base, Span span, std::string error) const {
    if (T::classof(base)) {
      return (T *)base;
    }
    printferr(span, raw_input, error.c_str());
    assert(false && "mismatched types");
  }

private:
  std::map<string, IRType *> surface2ty;
  std::map<string, IRType *> ident2ty;
  const char *raw_input;
};

// forward declaration.
void typeCheckBlock(TypeContext tc, Block *b);

// NOTE: mutates Expr to set the e->type.
void typeCheckExpr(TypeContext &tc, Expr *e) {
  if (auto binop = mlir::dyn_cast<ExprBinop>(e)) {
    typeCheckExpr(tc, binop->left);
    typeCheckExpr(tc, binop->right);
    tc.assertTypeEquality(binop->left->type, tc.getIntType(true),
                          binop->left->span);
    tc.assertTypeEquality(binop->right->type, tc.getIntType(true),
                          binop->right->span);
    e->type = tc.getIntType(true);
    return;
  }

  if (auto ecase = mlir::dyn_cast<ExprCase>(e)) {
    typeCheckExpr(tc, ecase->scrutinee);
    tc.assertStrict(ecase->scrutinee->type, ecase->scrutinee->span);

    if (IRTypeEnum *scrutineety =
            mlir::dyn_cast<IRTypeEnum>(ecase->scrutinee->type)) {
      for (ExprCase::Alt &a : ecase->alts) {
        if (auto lhsIdentifier = mlir::dyn_cast<CaseLHSIdentifier>(a.first)) {
          TypeContext inner = tc;
          inner.insertIdentifier(lhsIdentifier->ident, ecase->scrutinee->type);
          lhsIdentifier->type = ecase->scrutinee->type;
          typeCheckBlock(inner, a.second);
          continue;
        } // end identifier alt.

        if (auto lhsTuple = mlir::dyn_cast<CaseLHSTupleStruct>(a.first)) {
          IRTypeTuple *tuplety = tc.assertExpectedConstructorInEnum(
              scrutineety, lhsTuple->name, lhsTuple->fields.size());
          lhsTuple->type = tuplety;
          TypeContext inner = tc;
          for (int i = 0; i < lhsTuple->fields.size(); ++i) {
            // TODO: actually handle recursive pattern matching.
            inner.insertIdentifier(lhsTuple->fields[i], tuplety->get(i));
            typeCheckBlock(inner, a.second);
          }
          continue;
        } // end tuples alt.

        assert(false &&
               "unreachable: should have handled all types of alternatives");

      } // end alts loop for constructor scrutinee.
    }   // end constructor scrutinee.

    if (IRTypeInt *intty = mlir::dyn_cast<IRTypeInt>(ecase->scrutinee->type)) {
      for (ExprCase::Alt a : ecase->alts) {
        if (auto lhsInt = mlir::dyn_cast<CaseLHSInt>(a.first)) {
          // TODO: add error saying *why* we exepect int type.
          tc.assertTypeEquality(tc.getIntType(true), ecase->scrutinee->type,
                                ecase->scrutinee->span);
          TypeContext inner = tc;
          typeCheckBlock(inner, a.second);
          continue;
        }
        if (auto lhsIdentifier = mlir::dyn_cast<CaseLHSIdentifier>(a.first)) {
          TypeContext inner = tc;
          inner.insertIdentifier(lhsIdentifier->ident, ecase->scrutinee->type);
          typeCheckBlock(inner, a.second);
          continue;
        } // end identifier alt.

        assert(false &&
               "unreachable: should have handled all types of alternatives");
      } // end alts loop for int scurtinee.
    }   // end int scrutinee

    // check that all alts have the same type.
    assert(ecase->alts.size() > 0);
    ecase->type = ecase->alts[0].second->type;
    for (int i = 1; i < ecase->alts.size(); ++i) {
      tc.assertTypeEquality(ecase->type,
                            ecase->alts[i].second->type,
                            ecase->alts[i].second->span);
    }
    return;
  } // end case.

  if (auto construct = mlir::dyn_cast<ExprConstruct>(e)) {
      for (Expr *arg : construct->args) {
        typeCheckExpr(tc, arg);
      }
      IRTypeEnum *enumty = tc.lookupTypeNameOfType<IRTypeEnum>(construct->constructorName);
      // IRTypeEnum *enumty = tc.lookupValueOfType<IRTypeEnum>(construct->constructorName,
      //                           "expected constructor to be an enumeration type");

      auto it = enumty->constructors.find(construct->constructorName.name);
      assert(it != enumty->constructors.end());
      IRTypeTuple *constructorty = it->second;

      // TODO: convert to a type error.
      assert(constructorty->size() == construct->args.size());

      for(int i = 0; i < construct->args.size(); ++i) {
        tc.assertTypeEquality(constructorty->get(i), 
          construct->args[i]->type, construct->args[i]->span);
      }

    construct->type = enumty;
    return;
    // assert(false && "unimplemented");

  } // end constructor.

  if (auto fncall = mlir::dyn_cast<ExprFnCall>(e)) {

    IRTypeFn *fnty = tc.lookupValueOfType<IRTypeFn>(
        fncall->fnname, "expected function to have a function type!");

    vector<IRType *> argTys;
    // check argument list equality.

    // TODO: find better way to do this.
    tc.assertFntyNArgs(fnty, fncall->args.size(), fncall->span);
    for (int i = 0; i < fncall->args.size(); ++i) {
      typeCheckExpr(tc, fncall->args[i]);
      tc.assertTypeEquality(fnty->argTys.get(i), fncall->args[i]->type,
                            fncall->args[i]->span);
    }
    // set strictness info here.
    fncall->type = fnty->retty->clone(fncall->strict);
    return;
  } // end function call.

  if (auto ident = mlir::dyn_cast<ExprIdentifier>(e)) {
    ident->type = tc.lookupValue(ident->toIdentifier());
    return;
  } // end identifier

  if (auto eint = mlir::dyn_cast<ExprInteger>(e)) {
    eint->type = tc.getIntType(true);
    return;
  } // end integer

  cerr << "\n===unknown expr===\n";
  e->print(cerr);
  assert(false && "unkown expression type");
}

// type check a block. If `retty` exists, check that all returns return a
// thing of type retty.
void typeCheckBlock(TypeContext tc, Block *b) {
  for (Stmt *s : b->stmts) {
    if (auto let = mlir::dyn_cast<StmtLet>(s)) {
      typeCheckExpr(tc, let->rhs);
      if (let->type.strict) {
        tc.assertStrict(let->rhs->type, let->rhs->span);
      } else {
        tc.assertNonStrict(let->rhs->type, let->rhs->span);
      }
      IRType *declaredty = tc.lookupTypeName(let->type.tyname);
      tc.assertTypeEquality(declaredty, let->rhs->type, let->span);
      tc.insertIdentifier(let->name, let->rhs->type);
      continue;
    }

    if (auto ret = mlir::dyn_cast<StmtReturn>(s)) {
      typeCheckExpr(tc, ret->e);
      assert(ret->e->type);
      if (b->type) {
        tc.assertTypeEquality(b->type, ret->e->type, ret->e->span);
      } else {
        b->type = ret->e->type;
        assert(b->type);
      }
      continue;
    }

    assert(false && "unknown type of statment");
  }

  if (!b->type) {
    tc.assertVoidBlock(b->span);
  }
};

// NOTE: this MUTATES THE MODULE! by changing `Fn.type` and `Expr.type` fields.-
TypeContext typeCheckModule(const char *raw_input, Module &m) {
  TypeContext tcGlobal(raw_input);
  tcGlobal.insertIRType("i64", new IRTypeInt(true));

  // insert all structs as single constructor enums
  for (Struct s : m.structs) {
    StructFieldsTuple *fields = mlir::cast<StructFieldsTuple>(s.fields);
    vector<IRType *> fieldTys;
    for (SurfaceType t : fields->types) {
      fieldTys.push_back(tcGlobal.lookupTypeName(t.tyname));
    }

    // a struct is an enum with a single constructor whose constructor
    // name is the same as the type name.
    map<string, IRTypeTuple*> constructor2Type;
    constructor2Type.insert({s.name.name, new IRTypeTuple(fieldTys, true)});
    // TODO: asking for strictness on Enum is sort of nonsensical?
    tcGlobal.insertIRType(s.name.name,
                          new IRTypeEnum(s.name.name, constructor2Type, true));
    // add all constructors into the scope of the typechecker.
  }

  // generate  all function types.
  for (Fn &f : m.fns) {
    vector<IRType *> argTys;
    for (Fn::Argument arg : f.args) {
      argTys.push_back(tcGlobal.lookupTypeName(arg.second.tyname));
    }
    IRType *retty = tcGlobal.lookupTypeName(f.retty.tyname);

    // global *functions* are indeed values, not thunks (?)
    // Once again, we need a distinction between "types of stuff" and
    // "types of values?"
    IRTypeFn *fnty =  new IRTypeFn(IRTypeTuple(argTys, true), retty, true);
    f.type = fnty;
    tcGlobal.insertIdentifier(f.name, fnty);
  }

  for (Fn &f : m.fns) {
    TypeContext tc = tcGlobal;
    for (Fn::Argument arg : f.args) {
      tc.insertIdentifier(arg.first, tc.lookupTypeName(arg.second.tyname));
    }

    // TODO: each block should have a scope; For now, fuck it.
    // we are in WHNF, so return type will always be a value.
    IRType *retty = tc.lookupTypeName(f.retty.tyname);
    typeCheckBlock(tc, f.body);
    tc.assertTypeEquality(retty, f.body->type, f.retty.span);
  }
  return tcGlobal;
}

// == MLIR CODEGEN ==
// == MLIR CODEGEN ==
// == MLIR CODEGEN ==
// == MLIR CODEGEN ==
// == MLIR CODEGEN ==

using ScopeFn = Scope<std::string, mlir::FuncOp>;
using ScopeValue = Scope<std::string, mlir::Value>;

using SymbolTable = map<std::string, mlir::Value>;
// mlir::Type mlirGenTypeOrDefault(SurfaceType t, mlir::OpBuilder &builder,
//                                 mlir::Type defaultty) {
//   //  return builder.getI64Type();

//   if (t.tyname.name == ("i64")) {
//     return builder.getI64Type();
//   }
//   return defaultty;
// }

// mlir::Type mlirGenTypeOrThunk(SurfaceType t, mlir::OpBuilder &builder) {
//   auto valty = mlir::standalone::ValueType::get(builder.getContext());
//   auto thunkty = mlir::standalone::ThunkType::get(builder.getContext(), valty);

//   return mlirGenTypeOrDefault(t, builder, thunkty);
// }

// mlir::Type mlirGenTypeOrValue(SurfaceType t, mlir::OpBuilder &builder) {
//   auto valty = mlir::standalone::ValueType::get(builder.getContext());
//   return mlirGenTypeOrDefault(t, builder, valty);
// }
mlir::Type mlirGenType(mlir::OpBuilder &builder, const IRType *ty);


mlir::FunctionType mlirGenTypeFn(mlir::OpBuilder &builder, const IRTypeFn *fnty) {
  vector<mlir::Type> argtys;
  for(IRType *argty : fnty->argTys) {
    argtys.push_back(mlirGenType(builder, argty));
  }

  mlir::FunctionType out =  builder.getFunctionType(argtys,
      mlirGenType(builder, fnty->retty));
  assert(fnty->strict && "cannot handle lazy function");
  return out;
}

mlir::Type mlirGenType(mlir::OpBuilder &builder, const IRType *ty) {
  mlir::Type out;
  if (const IRTypeFn *fnty = mlir::dyn_cast<IRTypeFn>(ty)) {
    return mlirGenTypeFn(builder, fnty);
  }
  if (const IRTypeInt *i = mlir::dyn_cast<IRTypeInt>(ty)) {
    out = builder.getI64Type();
    if (!ty->strict) { out = mlir::standalone::ThunkType::get(builder.getContext(), out); }
    return out;
  }

  if (const IRTypeEnum *enumty = mlir::dyn_cast<IRTypeEnum>(ty)) {
    out = mlir::standalone::ValueType::get(builder.getContext());
    if (!ty->strict) { out = mlir::standalone::ThunkType::get(builder.getContext(), out); }
    return out;
  }

  if (const IRTypeTuple *tuplety = mlir::dyn_cast<IRTypeTuple>(ty)) {
    assert(false && "cannot code generate tuples.");
  }

  assert(false && "unknown type");
}

void mlirGenBlock(const Block *b, mlir::OpBuilder &builder, ScopeFn scopeFn,
                  ScopeValue &scopeValue, const TypeContext &tc);


std::pair<mlir::Attribute, mlir::Region*>
mlirGenCaseAlt(mlir::Value scrutinee, const ExprCase::Alt alt, mlir::OpBuilder builder,
                        ScopeFn scopeFn, ScopeValue scopeValue,
                        const TypeContext &tc) {

  if (CaseLHSInt *i = llvm::dyn_cast<CaseLHSInt>(alt.first)) {
    mlir::Region *r = new mlir::Region();
    r->push_back(new mlir::Block);
    mlir::Block &bodyBlock = r->front();
    {
      mlir::OpBuilder nestedBuilder = builder;
      nestedBuilder.setInsertionPointToEnd(&bodyBlock);
      mlirGenBlock(alt.second, nestedBuilder, scopeFn, scopeValue, tc);
    }

    return {builder.getI64IntegerAttr(i->value), r};
  }

  // TODO: differentiate of if we are caseing on an int or something else
  if (CaseLHSIdentifier *id =
          llvm::dyn_cast<CaseLHSIdentifier>(alt.first)) {
    mlir::Region *r = new mlir::Region();
    r->push_back(new mlir::Block);
    mlir::Block &bodyBlock = r->front();
    mlir::OpBuilder nestedBuilder = builder;
    ScopeValue nestedScopeValue = scopeValue;
    nestedScopeValue.insert(id->ident.name, scrutinee);
    nestedBuilder.setInsertionPointToEnd(&bodyBlock);
    mlirGenBlock(alt.second, nestedBuilder, scopeFn, nestedScopeValue, tc);
    mlir::Attribute  lhs = mlir::FlatSymbolRefAttr::get("default", builder.getContext());
    return {lhs, r};
  }

  if (auto tuplestruct = llvm::dyn_cast<CaseLHSTupleStruct>(alt.first)) {
    mlir::Region *r = new mlir::Region();
    r->push_back(new mlir::Block);
    mlir::Block &bodyBlock = r->front();

    mlir::OpBuilder nestedBuilder = builder;
    ScopeValue nestedScopeValue = scopeValue;

    for (int i = 0; i< tuplestruct->fields.size(); ++ i) {
      mlir::BlockArgument arg = bodyBlock.addArgument(mlirGenType(builder, tuplestruct->type->get(i)));
      nestedScopeValue.insert(tuplestruct->fields[i].name, arg);
    }

    nestedBuilder.setInsertionPointToEnd(&bodyBlock);
    mlirGenBlock(alt.second, nestedBuilder, scopeFn, nestedScopeValue, tc);
    mlir::Attribute lhs = mlir::FlatSymbolRefAttr::get(tuplestruct->name.name,
                                        builder.getContext());
    return {lhs, r};
  }

  assert(false && "unknown case alt");
}

// https://github.com/llvm/llvm-project/blob/76257422378e54dc2b59ff034e2955e9518e6c99/mlir/lib/Dialect/SCF/SCF.cpp
mlir::Value mlirGenExpr(const Expr *e, mlir::OpBuilder &builder,
                        ScopeFn scopeFn, ScopeValue &scopeValue,
                        const TypeContext &tc) {
  if (const ExprInteger *i = mlir::dyn_cast<ExprInteger>(e)) {
    return builder.create<mlir::ConstantIntOp>(builder.getUnknownLoc(),
                                               i->value, builder.getI64Type());
  }

  if (const ExprBinop *bop = mlir::dyn_cast<ExprBinop>(e)) {
    mlir::Value l = mlirGenExpr(bop->left, builder, scopeFn, scopeValue, tc);
    mlir::Value r = mlirGenExpr(bop->right, builder, scopeFn, scopeValue, tc);
    switch (bop->binop) {
    case Binop::Sub:
      return builder.create<mlir::SubIOp>(builder.getUnknownLoc(), l, r);
    case Binop::Mul:
      return builder.create<mlir::MulIOp>(builder.getUnknownLoc(), l, r);
    };

    assert(false && "unreachable codegen expr binop");
  }

  if (const ExprCase *c = mlir::dyn_cast<ExprCase>(e)) {
    mlir::Value scrutinee = mlirGenExpr(c->scrutinee, builder, scopeFn, scopeValue, tc);
    mlir::SmallVector<mlir::Attribute, 4> lhss;
    mlir::SmallVector<mlir::Region *, 4> rhss;
    for(ExprCase::Alt alt : c->alts) {
      mlir::Attribute lhs;
      mlir::Region *rhs;
      std::tie(lhs, rhs) = mlirGenCaseAlt(scrutinee, alt, builder, scopeFn, scopeValue, tc);
      lhss.push_back(lhs);
      rhss.push_back(rhs);
    }

    if (mlir::isa<IRTypeInt>(c->scrutinee->type)) {
      return builder.create<mlir::standalone::CaseIntOp>(
             builder.getUnknownLoc(), scrutinee, lhss, rhss, mlirGenType(builder, c->type));
    } else {
      assert(mlir::isa<IRTypeEnum>(c->scrutinee->type));
      return builder.create<mlir::standalone::CaseOp>(
             builder.getUnknownLoc(), scrutinee, lhss, rhss, mlirGenType(builder, c->type));
    }



    /*
    mlir::Value scrutinee =
        mlirGenExpr(c->scrutinee, builder, scopeFn, scopeValue, tc);
    llvm::SmallVector<mlir::Attribute, 4> lhss;
    llvm::SmallVector<mlir::Region *, 4> rhss;

    // mlir::Type scrutineety = builder.getI64Type();
    // mlir::Type retty = builder.getI64Type();

    for (ExprCase::Alt alt : c->alts) {
      mlir::Attribute lhs;
      mlir::Region *r = nullptr;

      if (CaseLHSInt *i = llvm::dyn_cast<CaseLHSInt>(alt.first)) {
        lhs = builder.getI64IntegerAttr(i->value);
        r = new mlir::Region();
        r->push_back(new mlir::Block);
        mlir::Block &bodyBlock = r->front();
        {
          mlir::OpBuilder nestedBuilder = builder;
          nestedBuilder.setInsertionPointToEnd(&bodyBlock);
          mlirGenBlock(alt.second, nestedBuilder, scopeFn, scopeValue, tc);
        }
      }

      // TODO: differentiate of if we are caseing on an int or something else
      if (CaseLHSIdentifier *id =
              llvm::dyn_cast<CaseLHSIdentifier>(alt.first)) {
        lhs = mlir::FlatSymbolRefAttr::get("default", builder.getContext());
        r = new mlir::Region();
        r->push_back(new mlir::Block);
        mlir::Block &bodyBlock = r->front();
        mlir::OpBuilder nestedBuilder = builder;
        ScopeValue nestedScopeValue = scopeValue;
        nestedScopeValue.insert(id->ident.name, scrutinee);
        nestedBuilder.setInsertionPointToEnd(&bodyBlock);
        mlirGenBlock(alt.second, nestedBuilder, scopeFn, nestedScopeValue, tc);
      }

      if (auto tuplestruct = llvm::dyn_cast<CaseLHSTupleStruct>(alt.first)) {
        lhs = mlir::FlatSymbolRefAttr::get(tuplestruct->name.name,
                                           builder.getContext());
        r = new mlir::Region();
        r->push_back(new mlir::Block);
        mlir::Block &bodyBlock = r->front();

        mlir::OpBuilder nestedBuilder = builder;
        ScopeValue nestedScopeValue = scopeValue;

        for (CaseLHS *lhs : tuplestruct->fields) {
          assert(lhs->kind == CaseLHSKind::Identifier &&
                 "unhandled case where tuple struct matches on a non-field. "
                 "TODO: implement recursive caseing");
          CaseLHSIdentifier *lhsFieldCase = llvm::cast<CaseLHSIdentifier>(lhs);
          // mlir::Type mlirFieldTy =

          mlir::BlockArgument arg = bodyBlock.addArgument(mlirFieldTy);
          nestedScopeValue.insert(lhsFieldCase->ident.name, arg);
        }

        nestedBuilder.setInsertionPointToEnd(&bodyBlock);
        mlirGenBlock(alt.second, nestedBuilder, scopeFn, nestedScopeValue, tc);
      }

      assert(lhs && "unable to generate LHS of case");
      lhss.push_back(lhs);
      rhss.push_back(r);
    }

    mlir::standalone::CaseIntOp case_ =
        builder.create<mlir::standalone::CaseIntOp>(
            builder.getUnknownLoc(), scrutinee, lhss, rhss, retty);
    return case_;
    */
  }
  if (const ExprIdentifier *id = mlir::dyn_cast<ExprIdentifier>(e)) {
    mlir::Value identVal = scopeValue.lookupExisting(id->name);
    return identVal;
  }

  if (const ExprFnCall *call = mlir::dyn_cast<ExprFnCall>(e)) {
    llvm::SmallVector<mlir::Value, 4>  args;
    for(Expr *arg : call->args) {
      args.push_back(mlirGenExpr(arg, builder, scopeFn, scopeValue, tc));
    }

    mlir::Type retty = builder.getI64Type();

    IRTypeFn *fnty = tc.lookupValueOfType<IRTypeFn>(call->fnname,
      "expected function to have function type");
    mlir::FunctionType mlirfnty = mlirGenTypeFn(builder, fnty);
    mlir::Value vf = builder.create<mlir::standalone::HaskRefOp>(
        builder.getUnknownLoc(), call->fnname.name, mlirfnty);
    mlir::Value out =  builder.create<mlir::standalone::ApOp>(builder.getUnknownLoc(), vf, args);
    if (call->strict) {
       out = builder.create<mlir::standalone::ForceOp>(builder.getUnknownLoc(), out);
    }
    return out;
  }

  if (auto *construct = mlir::dyn_cast<ExprConstruct>(e)) {
    llvm::SmallVector<mlir::Value, 4> args;
    for (Expr *arg : construct->args) {
      args.push_back(mlirGenExpr(arg, builder, scopeFn, scopeValue, tc));
    }

    // creates an lz.value
    return builder.create<mlir::standalone::HaskConstructOp>(
        builder.getUnknownLoc(), construct->constructorName.name, args);
    assert(false && "construct");
  }

  llvm::errs() << "\n====\n";
  e->print(cerr);
  llvm::errs() << "\n====\n";
  assert(false && "unknown expression");
}
void mlirGenStmt(const Stmt *s, mlir::OpBuilder &builder, ScopeFn scopeFn,
                 ScopeValue &scopeValue, const TypeContext &tc) {
  if (const StmtLet *l = mlir::dyn_cast<StmtLet>(s)) {
    mlir::Value v = mlirGenExpr(l->rhs, builder, scopeFn, scopeValue, tc);
    // generate a force expression if need be.
    scopeValue.insert(l->name.name, v);
    return;
  }

  if (const StmtReturn *r = mlir::dyn_cast<StmtReturn>(s)) {
    mlir::Value v = mlirGenExpr(r->e, builder, scopeFn, scopeValue, tc);
    builder.create<mlir::ReturnOp>(builder.getUnknownLoc(), v);
    return;
  }

  cerr << "\n===\n";
  s->print(cerr);
  cerr << "\n===\n";
  assert(false && "unknown statement type");
}

void mlirGenBlock(const Block *b, mlir::OpBuilder &builder, ScopeFn scopeFn,
                  ScopeValue &scopeValue, const TypeContext &tc) {
  for (Stmt *s : b->stmts) {
    mlirGenStmt(s, builder, scopeFn, scopeValue, tc);
  }
}

mlir::FuncOp mlirGenFnDeclaration(const TypeContext &tc, mlir::ModuleOp &mod, mlir::OpBuilder &builder,
                                  const Fn &f) {
  auto location = builder.getUnknownLoc(); // loc(proto.loc());
  llvm::SmallVector<mlir::Type, 4> argtys;


  mlir::FuncOp fn = mlir::FuncOp::create(
      location, f.name.name, mlirGenTypeFn(builder, f.type));
  return fn;
}

void mlirGenFnBody(mlir::FuncOp mlirfn, mlir::OpBuilder &builder, const Fn &f,
                   ScopeFn scopeFn, const TypeContext &tc) {
  mlirfn.addEntryBlock();
  builder.setInsertionPointToStart(&mlirfn.getRegion().front());
  ScopeValue scopeValue;
  for (int i = 0; i < f.args.size(); ++i) {
    scopeValue.insert(f.args[i].first.name, mlirfn.getArgument(i));
  }

  mlirGenBlock(f.body, builder, scopeFn, scopeValue, tc);
}

// https://github.com/llvm/llvm-project/blob/master/mlir/examples/toy/Ch2/mlir/MLIRGen.cpp#L57
mlir::ModuleOp mlirGen(mlir::MLIRContext &ctx, const TypeContext &tc,
                       const Module &m) {
  mlir::OpBuilder builder(&ctx);
  mlir::ModuleOp theModule = mlir::ModuleOp::create(builder.getUnknownLoc());
  ScopeFn scopeFn;

  for (const Fn &f : m.fns) {
    mlir::FuncOp fn = mlirGenFnDeclaration(tc, theModule, builder, f);
    theModule.push_back(fn);
    scopeFn.insert(f.name.name, fn);
  }

  theModule.dump();

  for (const Fn &f : m.fns) {
    mlirGenFnBody(scopeFn.lookupExisting(f.name.name), builder, f, scopeFn, tc);
  }

  return theModule;
}

int main(int argc, const char *const *argv) {
  // assert_err(argc > 1 && "usage: %s <path-to-file> [-dump-mlir]
  // [-dump-pretty]", argv[0]);
  assert(argc > 1 && "expected path to input file");

  for (int i = 1; i < argc; ++i) {
    G_DUMP_MLIR |= !strcmp(argv[i], "-dump-mlir");
    G_PRETTY_PRINT |= !strcmp(argv[i], "-dump-pretty");
  }

  FILE *f = fopen(argv[1], "rb");
  if (f == nullptr) {
    cerr << "unable to open file: |" << argv[1] << "|\n";
    return 1;
  }
  fseek(f, 0, SEEK_END);
  ll len = ftell(f);
  rewind(f);
  char *buf = (char *)malloc(len + 1);
  ll nread = fread(buf, 1, len, f);
  assert(nread == len);
  buf[nread] = 0;

  Parser s(argv[1], buf);
  Module mod = parseModule(s);
  if (G_PRETTY_PRINT) {
    mod.print(cerr);
  }

  // == TYPE CHECK ==
  // == TYPE CHECK ==
  // == TYPE CHECK ==
  TypeContext typeContext = typeCheckModule(buf, mod);

  // == MLIR ==
  // == MLIR ==
  // == MLIR ==
  mlir::MLIRContext context;
  // Load our Dialect in this MLIR Context.
  // https://github.com/llvm/llvm-project/blob/79105e464429d2220c81b38bf5339b9c41da1d21/mlir/examples/toy/Ch2/toyc.cpp#L70
  context.getOrLoadDialect<mlir::standalone::HaskDialect>();
  context.getOrLoadDialect<mlir::StandardOpsDialect>();

  mlir::OwningModuleRef mlirmod = mlirGen(context, typeContext, mod);
  if (!mlirmod) {
    assert(false && "unable to codegen module");
  }
  mlirmod->print(llvm::outs());
  llvm::outs() << "\n";
  if (mlir::failed(mlirmod->verify())) {
    llvm::outs() << "ERROR: module fails verification\n";
    assert(false && "module failed verification");
    exit(1);
  } else {
    llvm::outs() << "module succeeded verification!\n";
  }

  std::pair<InterpValue, InterpStats> interpOut =
      interpretModule(mlirmod.get());
  llvm::outs() << "===running program===\n";
  llvm::outs() << "value: " << interpOut.first << "\n";
  llvm::outs() << "statistics:\n" << interpOut.second;
  llvm::outs() << "\n";
  llvm::errs().flush();
  return 0;
}
