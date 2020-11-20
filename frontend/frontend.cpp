#include <assert.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <optional>
#include <vector>

// dialect includes
#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "Hask/Scope.h"
#include "Interpreter.h"

// more MLIR includes...
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/StandardTypes.h"


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

struct OutFile {
   public:
    OutFile(FILE *f) : f(f){};
    ~OutFile() { fflush(f); }

    void write(ll i) { fprintf(f, "%lld", i); }
    void write(int i) { fprintf(f, "%d", i); }

    void write(char c) {
        fputc(c, f);
        if (c == '\n') {
            for(int i = 0; i < indentLevel; ++i) {
                for(int j = 0; j < 2; ++j) { fputc(' ', f); }
                // fputc('|', f);
            }
        }
    }
    void write(const char *s) { while(*s != '\0') { write(*s++); } }

    void indent() { indentLevel++; }
    void dedent() { indentLevel--; assert(indentLevel >= 0); }

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
template <typename T>
OutFile &operator<<(OutFile &f, optional<T> ot) {
    if (!ot) {
        return f << "nothing;";
    } else {
        return f << "just[" << *ot << "]";
    }
}

template <typename T>
OutFile &operator << (OutFile &out, const T &v) { v.print(out); return(out); }

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
    for (; loc.si - nchars_back >= 1 && raw_input[loc.si - (nchars_back+1)] != '\n';
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

void printferr(Loc loc, const char *raw_input, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    vprintferr(loc, raw_input, fmt, args);
    va_end(args);
}

bool isWhitespace(char c) { return c == ' ' || c == '\n' || c == '\t'; }
bool isReservedSigil(char c) {
    return c == '(' || c == ')' || c == '{' || c == '}' || c == ',' || 
        c == ';' || c == '[' || c == ']' || c == ':' || c == '-' || c == '*'
      || c == '+' || c == '/';
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
struct Error {
    std::string errmsg;
    Loc loc;

    Error(Loc loc, std::string errmsg) : errmsg(errmsg), loc(loc){};
};

std::string substring(const std::string &s, Span span) {
  assert(span.end.si - span.begin.si >= 0);
  std::string sub = s.substr(span.begin.si,
                             span.end.si - span.begin.si);
  cout << "substring: |" << sub << "|\n";
  return sub;
}

struct Identifier {
    const Span span;
    const std::string name;
    Identifier(const Identifier &other) = default;
    Identifier(Span span, std::string name) : span(span), name(name){};

    Identifier operator = (const Identifier &other) {
        return Identifier(other);
    }

    void print(OutFile &f) const {
        f << name;
    }
};

struct Parser {
    Parser(const char *filename, const char *raw)
        : s(raw), l(filename, 0, 1, 1){};

    void parseOpenCurly() { parseSigil("{"); }
    void parseCloseCurly() { parseSigil("}"); }
    void parseFatArrow() { parseSigil("=>"); }
    bool parseOptionalCloseCurly() {
        return bool(parseOptionalSigil("}"));
    }
    Span parseOpenRoundBracket() { return parseSigil("("); }
    
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

  bool parseOptionalComma() {
        return bool(parseOptionalSigil(","));
    }

    void parseComma() { parseSigil(","); }
    void parseSemicolon() { parseSigil(";"); }
    bool parseOptionalSemicolon() {
        return bool(parseOptionalSigil(";"));
    }
    void parseThinArrow() { parseSigil("->"); }

    pair<Span, ll> parseInteger() {
        optional<pair<Span, ll>> out = parseOptionalInteger();
        if (!out) {
            this->addErr(Error(l, "unble to find integer"));
            exit(1);
        }
        return *out;
    }

    // [-][0-9]+
    optional<pair<Span, ll>> parseOptionalInteger() {
        eatWhitespace();
        bool negate = false;
        optional<char> ccur;  // peeking character
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

        addErr(Error(l, "expected sigil> |" + sigil + "|"));
        exit(1);
    }

    Span parseMatchingSigil(Span open, const string sigil) {
        optional<Span> span = parseOptionalSigil(sigil);
        if (span) {
            return *span;
        }

        addErr(
            Error(l, "expected sigil: |" +  sigil + "|"));
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
        addErr(Error(l, "expected identifier"));
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
        addErr(Error(l, "expected |" + keyword + "|"));
        exit(1);
    }

    void addErr(Error e) {
        errs.push_back(e);
        printferr(e.loc, s.c_str(), e.errmsg.c_str());
    }

    void addErrAtCurrentLoc(string err) { addErr(Error(l, err)); }

    bool eof() {
        eatWhitespace();
        return l.si == s.size();
    }

    // eat till newline
    void eatTillNewline() {
      while(1) {
        optional<char> c = this->at(l);
        if (!c) { return; }
        l = l.nextc(*c);
        if (c == '\n') { return; }
      }
    }

    Loc getCurrentLoc() { 
        eatWhitespace();
        return l; 
    }

   private:
    const string s;
    Loc l;
    vector<Error> errs;

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

struct Type {
    const Span span;
    const Identifier tyname;

    Type(Span span, Identifier tyname) : span(span), tyname(tyname) {}

    void print(OutFile &out) const {
        out << tyname;
    }
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

    OutFile &print(OutFile &out) const override  { return out << value; }

  static bool classof(const CaseLHS *e) {
    return e->kind == CaseLHSKind::Int;
  }

};

struct CaseLHSIdentifier : public CaseLHS {
    const string ident;
    CaseLHSIdentifier(Span span, string ident)
        : CaseLHS(span, CaseLHSKind::Identifier), ident(ident){};

    OutFile &print(OutFile &out) const override { return out << ident; }

    static bool classof(const CaseLHS *e) {
      return e->kind == CaseLHSKind::Identifier;
    }
};

struct CaseLHSTupleStruct : public CaseLHS {
    const Identifier name;
    vector<CaseLHS *> fields;
    CaseLHSTupleStruct(Span span, Identifier name, vector<CaseLHS *> fields) :
        CaseLHS(span, CaseLHSKind::TupleStruct), name(name), fields(fields) {};

    OutFile &print(OutFile &out) const override {
      out << name << "(";
      for(int i = 0; i < fields.size(); ++i) {
        fields[i]->print(out);
        if (i + 1 < fields.size()) { out << ", "; }
      }
      out << ")";
      return out;
    }

    static bool classof(const CaseLHS *e) {
      return e->kind == CaseLHSKind::TupleStruct;
    }
};

enum class ExprKind { Case, Identifier, Integer, FnCall, Binop };

struct Expr {
    const Span span;
    const ExprKind kind;
    Expr(Span span, ExprKind kind) : span(span), kind(kind){};
    virtual OutFile print(OutFile &out) const = 0;
};

struct ExprCase : public Expr {
    using Alt = pair<CaseLHS *, Expr *>;

    ExprCase(Span span, Expr *scrutinee, vector<Alt> alts)
        : Expr(span, ExprKind::Case), scrutinee(scrutinee), alts(alts){};
    const Expr *scrutinee;
    const vector<Alt> alts;

    OutFile print(OutFile &out) const override {
        out << "match ";
        scrutinee->print(out);
        out.indent();
        out << " {\n";

        for(int i = 0; i < (ll)alts.size(); ++i) {
            alts[i].first->print(out);
            out << " => ";
            alts[i].second->print(out);
            if (i + 1 < (ll)alts.size()) { out << ",\n"; }
        }

        
        out.dedent();
        out << "\n}";
        return out;
    }

    static bool classof(const Expr *e) {
      return e->kind == ExprKind::Case;
    }
};

struct ExprIdentifier : public Expr {
    const string name;
    ExprIdentifier(Span span, string name)
        : Expr(span, ExprKind::Identifier), name(name) {}

    OutFile print(OutFile &out) const override {
      return out << name;
      //        return out << "ident:" << name << "|[" << int(this->kind) << "]";
    }

  static bool classof(const Expr *e) {
    return e->kind == ExprKind::Identifier;
  }

};

struct ExprInteger : public Expr {
    const ll value;
    ExprInteger(Span span, ll value)
        : Expr(span, ExprKind::Integer), value(value) {}

    OutFile print(OutFile &out) const override {
        return out << value; 
    }

  static bool classof(const Expr *e) {
    return e->kind == ExprKind::Integer;
  }
};

enum class Binop { Mul, Sub };

OutFile &operator << (OutFile &o, Binop b) {
    switch(b) {
        case Binop::Mul: return o <<"*";
        case Binop::Sub: return o <<"-";
    }

    assert(false && "unreachable!");
}

struct ExprBinop : public Expr {
    const Expr *left;
    Expr *right;
    const Binop binop;
    ExprBinop(Span span, Expr *left, Binop binop, Expr *right)
        : Expr(span, ExprKind::Binop), left(left), right(right), binop(binop){};

    OutFile print(OutFile &out) const override {
        out << "[bop " << binop; out << " ";
        left->print(out); out << " ";
        right->print(out); out << "]";
        return out;
    }

  static bool classof(const Expr *e) {
    return e->kind == ExprKind::Binop;
  }

};


struct ExprFnCall : public Expr {
    Identifier fnname;
    vector<Expr *> args;

    ExprFnCall(Span span, Identifier fnname, vector<Expr *> args)
        : Expr(span, ExprKind::FnCall), fnname(fnname), args(args){};

    OutFile print(OutFile &out) const override {
        out << "[call "; out <<  fnname.name  << " ";
        for(int i = 0; i  < (ll)args.size(); ++i) {
            args[i]->print(out);
            if (i + 1 < (ll)args.size()) out << ", ";
        }
        out << " ]";
        return out;
    }

  static bool classof(const Expr *e) {
    return e->kind == ExprKind::FnCall;
  }
};

enum class StmtKind {
  Return, Let, LetBang
};


struct Stmt {
  virtual void print(OutFile &out) const = 0;
  Stmt(StmtKind Kind) : Kind(Kind) {};
  const StmtKind Kind;
};


struct StmtReturn : public Stmt {
    const Expr *e;
    StmtReturn(TAKE Expr *e) : Stmt(StmtKind::Return), e(e){};

    void print(OutFile &o) const {
        o << "return " << *e;
    }

    static bool classof(const Stmt *S) {
      return S->Kind == StmtKind::Return;
    }

};

struct StmtLet : public Stmt {
  Identifier name;
  Type type;
  Expr *rhs;
  StmtLet(Identifier name, Type type, Expr *rhs) : Stmt(StmtKind::Let), name(name), type(type), rhs(rhs) {};
  void print(OutFile &o) const {
    o << "let "; name.print(o); o << " : "; type.print(o); o << " = ";
    rhs->print(o);
  }

  static bool classof(const Stmt *S) {
    return S->Kind == StmtKind::Let;
  }
};

struct StmtLetBang : public Stmt {
  Identifier name;
  Type type;
  Expr *rhs;
  StmtLetBang(Identifier name, Type type, Expr *rhs) : Stmt(StmtKind::LetBang), name(name), type(type), rhs(rhs) {};
  void print(OutFile &o) const {
    o << "let! "; name.print(o); o << " : "; type.print(o); o << " = ";
    rhs->print(o);
  }
  static bool classof(const Stmt *S) {
    return S->Kind == StmtKind::LetBang;
  }
};


Type parseType(Parser &in) {
    Loc lbegin = in.getCurrentLoc();
    optional<Identifier> ident;
    if ((ident = in.parseOptionalIdentifier())) {
        return Type(Span(lbegin, in.getCurrentLoc()), *ident);
    } else {
        in.addErrAtCurrentLoc("expected type.");
        exit(1);
    }
}


CaseLHS *parseCaseLHS(Parser &in) {
    optional<pair<Span, ll>> integer(in.parseOptionalInteger());
    // parse pattern match
    if (integer) {
        return new CaseLHSInt(integer->first, integer->second);
    }

    // <ident>  |  <struct-name> (<struct-fields>)
    optional<Identifier> ident(in.parseOptionalIdentifier());
    if (!ident) {
        in.addErrAtCurrentLoc("expected case LHS.");
        exit(1);
    }
    optional<Span> structFieldRoundOpen;
    structFieldRoundOpen = in.parseOptionalOpenRoundBracket();
    if (!structFieldRoundOpen) { 
        return new CaseLHSIdentifier(ident->span, ident->name);
    }

    Span tupleStructSpan(ident->span);

    vector<CaseLHS *> fields;

    // parse identifiers
    while(1) {
        CaseLHS * field = parseCaseLHS(in); 
        fields.push_back(field);
        if (!in.parseOptionalComma()) {
            tupleStructSpan.extendRight(in.parseCloseRoundBracket(*structFieldRoundOpen));
            break;
        }
    }
    return new CaseLHSTupleStruct(tupleStructSpan, *ident, fields);
}

Expr *parseExprTop(Parser &in);

// fncall identifier | number |
Expr *parseExprLeaf(Parser &in) {
    Loc lbegin = in.getCurrentLoc();
    std::optional<Identifier> ident = in.parseOptionalIdentifier();
    if (ident) {
        // function call!
        optional<Span> open;
        if ((open = in.parseOptionalOpenRoundBracket())) {
            if (in.parseOptionalCloseRoundBracket()) {
                return new ExprFnCall(Span(lbegin, in.getCurrentLoc()), *ident,
                                      {});
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
            return new ExprFnCall(Span(lbegin, in.getCurrentLoc()), *ident,
                                  args);

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

Expr *parseExprTop(Parser &in) {
    const Loc lbegin = in.getCurrentLoc();

    if (in.parseOptionalKeyword("match")) {
        Expr *scrutinee = parseExprTop(in);
        in.parseOpenCurly();
        vector<pair<CaseLHS *, Expr *>> alts;
        while (1) {
            CaseLHS *lhs = parseCaseLHS(in);
            in.parseFatArrow();
            Expr *rhs = parseExprTop(in);
            alts.push_back({lhs, rhs});

            if (in.parseOptionalCloseCurly()) {
                break;
            } else {
                in.parseComma();
            }
        }
        return new ExprCase(Span(lbegin, in.getCurrentLoc()), scrutinee, alts);
    }

    Expr *e = parseExprArithAddSub(in);
    if (e) { return e; }

    in.addErrAtCurrentLoc("unable to parse expression");
    exit(1);
}

Stmt *parseStmt(Parser &in) {
    if (in.parseOptionalKeyword("return")) {
        return new StmtReturn(parseExprTop(in));
    } else if (in.parseOptionalKeyword("let")) {
      Identifier name = in.parseIdentifier();
      in.parseColon();
      Type t = parseType(in);
      in.parseEqual();
      Expr *e = parseExprTop(in);
      return new StmtLet(name, t, e);
    } else if (in.parseOptionalKeyword("letbang")) {
      Identifier name = in.parseIdentifier();
      in.parseColon();
      Type t = parseType(in);
      in.parseEqual();
      Expr *e = parseExprTop(in);
      return new StmtLetBang(name, t, e);
  }


    in.addErrAtCurrentLoc("expected statement");
    exit(1);
}

struct Block {
    const vector<Stmt*> stmts;
    Block(vector<Stmt*> stmts) : stmts(stmts) {};

    void print(OutFile &out) const {
        out.indent();
        out << "{\n";
        for(const Stmt *s : stmts) {
            s->print(out);
            out << "\n";
        }
        out.dedent();
        out << "\n}";
    }
    
};

Block parseBlock(Parser &in) {
    vector<Stmt*> stmts;
    in.parseOpenCurly();
    while (!in.parseOptionalCloseCurly()) {
        stmts.push_back(parseStmt(in));
        in.parseSemicolon();
        // if (!in.parseOptionalSemicolon()) {
        //     // we allow the last 'statement' to end without a semicolon
        //     // to indicate return
        //     in.parseCloseCurly();
        //     break;
        // }
    }
    return Block(stmts);
}

struct Fn {
    using Argument = std::pair<Identifier, Type>;
    const Span span;
    const Identifier name;
    const vector<Argument> args;
    Type retty;
    const Block body;

    Fn(Span span, Identifier name, vector<Argument> args, Type retty,
       Block body)
        : span(span), name(name), args(args), retty(retty), body(body){};

    OutFile &print(OutFile &out) const {
        out << name.name << "(";
        for(int i = 0; i < (ll)args.size(); ++i) {
            out << args[i].first.name << " : " << args[i].second; 
            if (i + 1 < (ll)args.size()) { out << ", "; }
        }
        out << ")";
        out << body;
        return out;
    }
};

Fn parseFn(Parser &in) {
    Loc lbegin = in.getCurrentLoc();
    Identifier ident = in.parseIdentifier();
    Span open = in.parseOpenRoundBracket();
    vector<pair<Identifier, Type>> params;
    if (!in.parseOptionalCloseRoundBracket()) {
      while (1) {
        Identifier name = in.parseIdentifier();
        in.parseColon();
        Type t = parseType(in);
        params.push_back({name, t});
        if (in.parseOptionalComma()) {
          continue;
        }
        in.parseCloseRoundBracket(open);
        break;
      }
    }

    in.parseThinArrow();
    Type retty = parseType(in);
    Block b = parseBlock(in);
    return Fn(Span(lbegin, in.getCurrentLoc()), ident, params, retty, b);
}

enum class StructFieldsType { Tuple };
struct StructFields {
    Span span;
    StructFieldsType type;
    StructFields(Span span, StructFieldsType type): span(span), type(type) {};
};

struct StructFieldsTuple : public StructFields {
    StructFieldsTuple(Span span, vector<Type> types) : 
        StructFields(span, StructFieldsType::Tuple),  types(types) {};
    const vector<Type> types;
};

StructFields *parseStructFields(Parser &in) {
    Loc lbegin = in.getCurrentLoc();
    in.parseOpenRoundBracket();
    vector<Type> types;

    if (in.parseOptionalCloseRoundBracket()) {
        /*done*/
    } else {
        while(1) {
            types.push_back(parseType(in));
            if (in.parseOptionalCloseRoundBracket()) { break; }
            else { in.parseComma(); }
        }
    }
    return new StructFieldsTuple(Span(lbegin, in.getCurrentLoc()), types);
}

struct Struct {
    const Span span;
    const Identifier name;
    StructFields *fields;

    Struct(Span span, Identifier name, StructFields *fields) : span(span), name(name), fields(fields) {};
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
    using EnumConstructor = pair<Identifier, StructFields*>;
    const vector<EnumConstructor> constructors;

    Enum(Span span, Identifier name, vector<EnumConstructor> constructors)
        : span(span), name(name), constructors(constructors) {};
};

Enum parseEnum(Parser &in) {
    Loc lbegin = in.getCurrentLoc();
    vector<Enum::EnumConstructor> cs;

    Identifier enumName = in.parseIdentifier();
    in.parseOpenCurly();
    // enum must have 1 or more fields
    while(1) {
        Identifier cname = in.parseIdentifier();
        StructFields *f = parseStructFields(in);
        cs.push_back({cname, f});

        if (in.parseOptionalCloseCurly()) { break; }
        else { in.parseComma(); }
    }
    in.parseSemicolon();
    return Enum(Span(lbegin, in.getCurrentLoc()), enumName, cs);
}

struct Module {
    vector<Fn> fns;
    vector<Struct> structs;
    vector<Enum> enums;
    OutFile &print(OutFile &out) const {
        for(Fn f: fns) {
            f.print(out); out << "\n";
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
        }
        else if (in.parseOptionalSigil("//")) {
          in.eatTillNewline();
        }
        else {
            in.addErrAtCurrentLoc(
                "unknown top level starter");
            assert(false && "unknown top level form.");
        }
    }

    return m;
}

// == MLIR CODEGEN ==
// == MLIR CODEGEN ==
// == MLIR CODEGEN ==
// == MLIR CODEGEN ==
// == MLIR CODEGEN ==

using ScopeFn = Scope<std::string, mlir::FuncOp>;
using ScopeValue = Scope<std::string, mlir::Value>;


using SymbolTable = map<std::string, mlir::Value>;
mlir::Type mlirGenTypeOrDefault(Type t, mlir::OpBuilder &builder, mlir::Type defaultty) {
  //  return builder.getI64Type();

  if (t.tyname.name == ("i64")) {
    return builder.getI64Type();
  }
  return defaultty;
}

mlir::Type mlirGenTypeOrThunk(Type t, mlir::OpBuilder &builder) {
  auto valty =
      mlir::standalone::ValueType::get(builder.getContext());
  auto thunkty =  mlir::standalone::ThunkType::get(builder.getContext(), valty);

  return mlirGenTypeOrDefault(t, builder, thunkty);
}

mlir::Type mlirGenTypeOrValue(Type t, mlir::OpBuilder &builder) {
  auto valty =
      mlir::standalone::ValueType::get(builder.getContext());
  return mlirGenTypeOrDefault(t, builder, valty);
}



// https://github.com/llvm/llvm-project/blob/76257422378e54dc2b59ff034e2955e9518e6c99/mlir/lib/Dialect/SCF/SCF.cpp
mlir::Value mlirGenExpr(const Expr *e, mlir::OpBuilder &builder, ScopeFn scopeFn, ScopeValue scopeValue) {
  cout << __FUNCTION__ << ":" << __LINE__ << "\n"; cout.indent();
  e->print(cout);
  cout.dedent();
  cout << "\n";
  if (const ExprInteger *i = mlir::dyn_cast<ExprInteger>(e)) {
    return builder.create<mlir::ConstantIntOp>(builder.getUnknownLoc(),
                                               i->value, builder.getI64Type());
  }

  if (const ExprBinop *bop = mlir::dyn_cast<ExprBinop>(e)) {
    mlir::Value l = mlirGenExpr(bop->left, builder, scopeFn, scopeValue);
    mlir::Value r= mlirGenExpr(bop->right, builder, scopeFn, scopeValue);
    switch (bop->binop) {
    case Binop::Sub:
      return builder.create<mlir::SubIOp>(builder.getUnknownLoc(), l, r);
    case Binop::Mul:
      return builder.create<mlir::MulIOp>(builder.getUnknownLoc(), l, r);
    };

    assert(false && "unreachable codegen expr binop");
  }

  if(const ExprCase *c = mlir::dyn_cast<ExprCase>(e)) {
    assert(c->scrutinee);
    mlir::Value scrutinee = mlirGenExpr(c->scrutinee, builder, scopeFn, scopeValue);
    llvm::SmallVector<mlir::Attribute, 4> lhss;
    llvm::SmallVector<mlir::Region*, 4> rhss;

    mlir::Type scrutineety = builder.getI64Type();
    mlir::Type retty = builder.getI64Type();

    for(ExprCase::Alt a : c->alts) {
      mlir::Attribute lhs;
      mlir::Region *r = nullptr;


      if (CaseLHSInt *i = llvm::dyn_cast<CaseLHSInt>(a.first)) {
        cout << "CaseInt\n";
        lhs = builder.getI64IntegerAttr(i->value);
        r = new mlir::Region();
        r->push_back(new mlir::Block);
        mlir::Block &bodyBlock = r->front();
        bodyBlock.addArgument({scrutineety});
        {
          mlir::OpBuilder nestedBuilder = builder;
          nestedBuilder.setInsertionPointToEnd(&bodyBlock);
          mlir::Value rhsval =  mlirGenExpr(a.second, nestedBuilder, scopeFn, scopeValue);
          nestedBuilder.create<mlir::ReturnOp>(builder.getUnknownLoc(), rhsval);
        }
      }


      // TODO: differentiate of if we are caseing on an int or something else
      if (CaseLHSIdentifier *id = llvm::dyn_cast<CaseLHSIdentifier>(a.first)) {
        lhs = mlir::FlatSymbolRefAttr::get("default", builder.getContext());
        r = new mlir::Region();
        r->push_back(new mlir::Block);
        mlir::Block &bodyBlock = r->front();
        cout << "caseLHSIdentifier\n";
        {
          mlir::OpBuilder nestedBuilder = builder;
          ScopeValue  nestedScopeValue = scopeValue;
          nestedScopeValue.insert(id->ident, scrutinee);
          nestedBuilder.setInsertionPointToEnd(&bodyBlock);
          mlir::Value rhsval =  mlirGenExpr(a.second, nestedBuilder, scopeFn, nestedScopeValue);
          nestedBuilder.create<mlir::ReturnOp>(builder.getUnknownLoc(), rhsval);
        }
      }

      if (CaseLHSTupleStruct *str = llvm::dyn_cast<CaseLHSTupleStruct>(a.first)) {
        cout << "caseLHSTupleStruct\n";
        assert(false && "tuple struct");
      }

      assert(lhs && "unable to generate LHS of case");
      lhss.push_back(lhs);
      rhss.push_back(r);
      }

      mlir::standalone::CaseIntOp case_ =  builder.create<mlir::standalone::CaseIntOp>(
          builder.getUnknownLoc(), scrutinee, lhss, rhss, retty);
      return case_;
  }
  if (const ExprIdentifier *id = mlir::dyn_cast<ExprIdentifier>(e)) {
    mlir::Value identVal = scopeValue.lookupExisting(id->name);
    llvm::outs() << "ident: |" << identVal << "|\n";
    return identVal;
  }

  if (const ExprFnCall *call = mlir::dyn_cast<ExprFnCall>(e)) {
    cout << "call :" << *call << "\n";
    llvm::SmallVector<mlir::Value, 4> args;
    for(Expr *e : call->args) {
      args.push_back(mlirGenExpr(e, builder, scopeFn, scopeValue));
    }

    llvm::SmallVector<mlir::Type, 4> argTys;
    for(int i = 0; i < call->args.size(); ++i) {
      argTys.push_back(builder.getI64Type());
    }

    assert(args.size() == argTys.size() && "mismatched argument value and type list");

    mlir::Type retty = builder.getI64Type();
    mlir::standalone::HaskFnType fnty =
        mlir::standalone::HaskFnType::get(builder.getContext(), argTys, retty);
    mlir::Value vf =
        builder.create<mlir::standalone::HaskRefOp>(builder.getUnknownLoc(),
                                                    call->fnname.name, fnty);


    return builder.create<mlir::standalone::ApOp>(builder.getUnknownLoc(), vf, args);
  }
  llvm::outs() << "\n====\n";
  e->print(cout);
  llvm::outs() << "\n====\n";
  assert(false && "unknown expression");
}
void mlirGenStmt(const Stmt *s, mlir::OpBuilder &builder, ScopeFn scopeFn, ScopeValue &scopeValue) {
  if (const StmtLet *l = mlir::dyn_cast<StmtLet>(s)) {
    mlir::Value v = mlirGenExpr(l->rhs, builder, scopeFn, scopeValue);
    scopeValue.insert(l->name.name, v);
    return;
  }

  if (const StmtLetBang *l  = mlir::dyn_cast<StmtLetBang>(s)) {
    assert(false && "stmt letbang");
  }

  if (const StmtReturn *r = mlir::dyn_cast<StmtReturn>(s)) {
      mlir::Value v = mlirGenExpr(r->e, builder, scopeFn, scopeValue);
      builder.create<mlir::ReturnOp>(builder.getUnknownLoc(), v);
      return;
  }

  cout << "\n===\n";
  s->print(cout);
  cout << "\n===\n";
  assert(false && "unknown statement type");
}

void mlirGenBody(const Block &b, mlir::OpBuilder &builder, ScopeFn scopeFn, ScopeValue scopeValue) {
  for(Stmt *s : b.stmts) {
    mlirGenStmt(s, builder, scopeFn, scopeValue);
  }
}

mlir::FuncOp mlirGenFnDeclaration(mlir::ModuleOp &mod, mlir::OpBuilder & builder, const Fn &f) {
  auto location = builder.getUnknownLoc(); //loc(proto.loc());
  llvm::SmallVector<mlir::Type, 4> argtys;

  for(int i = 0; i < f.args.size(); ++i) {
    argtys.push_back(mlirGenTypeOrThunk(f.args[i].second, builder));
  }

  llvm::SmallVector<mlir::Type, 4> rettys =
      { mlirGenTypeOrValue(f.retty, builder) };
  mlir::FuncOp fn = mlir::FuncOp::create(location, f.name.name,
                                         builder.getFunctionType(argtys, rettys));
  return fn;
}

void mlirGenFnBody(mlir::FuncOp mlirfn, mlir::OpBuilder & builder, const Fn &f,
                   ScopeFn scopeFn) {
  mlirfn.addEntryBlock();
  builder.setInsertionPointToStart(&mlirfn.getRegion().front());
  ScopeValue scopeValue;
  for(int i = 0; i < f.args.size(); ++i) {
    scopeValue.insert(f.args[i].first.name, mlirfn.getArgument(i));
  }

  cout << "====f:" << "\n" << f << "\n";
  mlirGenBody(f.body, builder, scopeFn, scopeValue);
  llvm::errs() << "function body:\n" << mlirfn << "\n===\n";
}

// https://github.com/llvm/llvm-project/blob/master/mlir/examples/toy/Ch2/mlir/MLIRGen.cpp#L57
mlir::ModuleOp mlirGen(mlir::MLIRContext &ctx, const Module &m) {
  mlir::OpBuilder builder(&ctx);
  mlir::ModuleOp theModule = mlir::ModuleOp::create(builder.getUnknownLoc());
  ScopeFn scopeFn;
  for(const Fn &f : m.fns) {
    mlir::FuncOp fn =  mlirGenFnDeclaration(theModule, builder, f);
    theModule.push_back(fn);
    scopeFn.insert(f.name.name, fn);
  }

  theModule.dump();

  for (const Fn &f: m.fns) {
    mlirGenFnBody(scopeFn.lookupExisting(f.name.name), builder, f, scopeFn);
  }

  return theModule;
}

int main(int argc, const char *const *argv) {
    // assert_err(argc > 1 && "usage: %s <path-to-file> [-dump-mlir] [-dump-pretty]", argv[0]);
    assert(argc > 1 && "expected path to input file");

    for(int i = 1; i < argc; ++i) {
      G_DUMP_MLIR |= !strcmp(argv[i], "-dump-mlir");
      G_PRETTY_PRINT |= !strcmp(argv[i], "-dump-pretty");
    }

  FILE *f = fopen(argv[1], "rb");
  if (f == nullptr) {
    cout << "unable to open file: |" << argv[1] << "|\n";
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

  // == MLIR ==
  // == MLIR ==
  // == MLIR ==
  mlir::MLIRContext context;
  // Load our Dialect in this MLIR Context.
  // https://github.com/llvm/llvm-project/blob/79105e464429d2220c81b38bf5339b9c41da1d21/mlir/examples/toy/Ch2/toyc.cpp#L70
  context.getOrLoadDialect<mlir::standalone::HaskDialect>();
  context.getOrLoadDialect<mlir::StandardOpsDialect>();

  mlir::OwningModuleRef mlirmod = mlirGen(context, mod);
  if (!mlirmod) { assert(false && "unable to codegen module"); }
  mlirmod->print(llvm::outs());
  llvm::outs() << "\n";
  if(mlir::failed(mlirmod->verify())) {
    llvm::outs() << "ERROR: module fails verification\n";
    exit(1);
  } else {
    llvm::outs() << "module succeeded verification!\n";
  }

  std::pair<InterpValue, InterpStats> interpOut = interpretModule(mlirmod.get());
  llvm::errs() << "===running program===\n";
  llvm::errs() << "value: " << interpOut.first << "\n";
  llvm::errs() << "statistics:\n" << interpOut.second;
  llvm::errs() << "\n";
  llvm::errs().flush();
  return 0;
}
