#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "mlir/InitAllTranslations.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Translation.h"
#include <iostream>

#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/ScopedHashTable.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/raw_ostream.h"

#include "lambdapure/Dialect.h"
#include "Hask/HaskDialect.h"
#include "Pointer/PointerDialect.h"

// https://github.com/llvm/llvm-project/blob/e21adfa32d8822f9ea4058c3e365a841d87cb3ee/mlir/lib/Target/LLVMIR/ConvertFromLLVMIR.cpp
using namespace mlir;
using namespace llvm;


// I cry. Remove this to pass indent as state.
static std::string offset = "";


bool startswith(std::string haystack, std::string needle) {
  if (haystack.size() < needle.size()) return false;
  for(int i = 0; i < (int) needle.size(); ++i) {
    if (haystack[i] != needle[i]) { return false; }
  }
  return true;
}


const char * GLOBAL_BOX_NAME = "HACK_SPECIAL_BOX"; 
extern "C" {
const char *__asan_default_options() { return "detect_leaks=0"; }
}

// === AST ===
// === AST ===
// === AST ===
// === AST ===
// === AST ===
// === AST ===
// === AST ===
// === AST ===
// === AST ===
// === AST ===

enum VarType { object, u64, u32, u16, u8 , box};
std::string stringOfType(VarType t);
std::string stringOfType(std::vector<VarType> ts);
std::string stringOfType(std::vector<VarType> ts, VarType t);

class ExprAST {

public:
  enum Kind {
    NumberExpr,
    VarExpr,
    AppExpr,
    PapExpr,
    CallExpr,
    ProjExpr,
    CtorExpr,
    StringExpr,
  };

  ExprAST(Kind kind) : kind(kind) {}
  virtual ~ExprAST() = default;
  virtual void print() = 0;

  Kind getKind() const { return kind; }

private:
  Kind kind;
};

/// Numeral literal expression
class NumberExprAST : public ExprAST {
  int Val;

public:
  NumberExprAST(double Val) : ExprAST(NumberExpr), Val(Val) {}
  void print() override;
  int getValue() { return Val; }
  /// LLVM style RTTI
  static bool classof(const ExprAST *c) { return c->getKind() == NumberExpr; }
};


// Strings
class StringExprAST : public ExprAST {
  std::string s;

public:
  StringExprAST(std::string s) : ExprAST(StringExpr), s(s) {}
  void print() override { std::cerr << s; }
  std::string getValue() { return s; }
  /// LLVM style RTTI
  static bool classof(const ExprAST *c) { return c->getKind() == StringExpr; }
};


// Variable expression
class VariableExprAST : public ExprAST {
  std::string Name;

public:
  VariableExprAST(const std::string &Name) : ExprAST(VarExpr), Name(Name) {}
  std::string getName() { return Name; }
  void print() override;
  static bool classof(const ExprAST *c) { return c->getKind() == VarExpr; }
};

// AppAST -indirect function call
class AppExprAST : public ExprAST {
  std::string FName;
  std::vector<std::unique_ptr<VariableExprAST>> Args;

public:
  AppExprAST(const std::string &FName,
             std::vector<std::unique_ptr<VariableExprAST>> Args)
      : ExprAST(AppExpr), FName(FName), Args(std::move(Args)) {}

  void print() override;
  std::string getFName() { return FName; }
  llvm::ArrayRef<std::unique_ptr<VariableExprAST>> getArgs() { return Args; }
  static bool classof(const ExprAST *c) { return c->getKind() == AppExpr; }
};

class PapExprAST : public ExprAST {
  std::string FName;
  std::vector<std::unique_ptr<VariableExprAST>> Args;

public:
  PapExprAST(const std::string &FName,
             std::vector<std::unique_ptr<VariableExprAST>> Args)
      : ExprAST(PapExpr), FName(FName), Args(std::move(Args)) {}
  void print() override;
  std::string getFName() { return FName; }
  llvm::ArrayRef<std::unique_ptr<VariableExprAST>> getArgs() { return Args; }
  static bool classof(const ExprAST *c) { return c->getKind() == PapExpr; }
};
// direct function call
class CallExprAST : public ExprAST {
  std::string FName;
  std::vector<std::unique_ptr<VariableExprAST>> Args;

public:
  CallExprAST(const std::string &FName,
              std::vector<std::unique_ptr<VariableExprAST>> Args)
      : ExprAST(CallExpr), FName(FName), Args(std::move(Args)) {}
  void print() override;
  std::string getFName() { return FName; }
  llvm::ArrayRef<std::unique_ptr<VariableExprAST>> getArgs() { return Args; }
  static bool classof(const ExprAST *c) { return c->getKind() == CallExpr; }
};

class CtorExprAST : public ExprAST {
  int Tag;
  std::vector<std::unique_ptr<VariableExprAST>> Args;

public:
  CtorExprAST(int Tag, std::vector<std::unique_ptr<VariableExprAST>> Args)
      : ExprAST(CtorExpr), Tag(Tag), Args(std::move(Args)) {}
  void print() override;
  int getTag() { return Tag; }
  llvm::ArrayRef<std::unique_ptr<VariableExprAST>> getArgs() { return Args; }
  static bool classof(const ExprAST *c) { return c->getKind() == CtorExpr; }
};

class ProjExprAST : public ExprAST {
  int I;
  std::unique_ptr<VariableExprAST> Var;

public:
  ProjExprAST(int i, std::unique_ptr<VariableExprAST> Var)
      : ExprAST(ProjExpr), I(i), Var(std::move(Var)) {}
  void print() override;
  int getIndex() { return I; }
  VariableExprAST *getVar() { return Var.get(); }
  std::string getVarName() { return Var->getName(); }
  static bool classof(const ExprAST *c) { return c->getKind() == ProjExpr; }
};

/// StatementAST - statment can be either let = expr , ret variable, or case x
/// of F
class StmtAST {
public:
  virtual ~StmtAST() = default;
  virtual void print() = 0;
  Location getLoc() { return location; }
  StmtAST(Location location) : location(location) {}

private:
  Location location;
};

class LetStmtAST : public StmtAST {
  std::string Var;
  std::unique_ptr<ExprAST> Rhs;
  VarType Vtype;

public:
  LetStmtAST(Location location, const std::string Var,
             std::unique_ptr<ExprAST> Rhs, VarType Vtype)
      : StmtAST(location), Var(Var), Rhs(std::move(Rhs)), Vtype(Vtype) {}
  void print() override;
  std::string getName() { return Var; }
  VarType getVtype() { return Vtype; }
  ExprAST *getExpr() { return Rhs.get(); }
};

class RetStmtAST : public StmtAST {

public:
  enum Kind {
    Direct,
    Case,
    Block,
  };
  RetStmtAST(Kind Kind, Location Location) : StmtAST(Location), Kind(Kind) {}
  virtual ~RetStmtAST() = default;
  virtual void print() override = 0;
  Kind getKind() const { return Kind; }

private:
  Kind Kind;
};

class DirectRetStmtAST : public RetStmtAST {
  std::string Var;

public:
  DirectRetStmtAST(Location location, const std::string &Var)
      : RetStmtAST(Direct, location), Var(Var) {}
  void print() override;
  std::string getVar() { return Var; }
  static bool classof(const RetStmtAST *c) { return c->getKind() == Direct; }
};

class BlockRetStmtAST : public RetStmtAST {
  int blockId;
  std::vector<std::unique_ptr<VariableExprAST>> Args;
  std::vector<VarType> ArgTypes;
  // can a Block have Lets? Don't know!
  std::unique_ptr<RetStmtAST> Inner; // code that is inside block
  std::unique_ptr<RetStmtAST> After; // code that comes after block
public:
  BlockRetStmtAST(Location location, int blockId,
                  std::vector<std::unique_ptr<VariableExprAST>> Args,
                  std::vector<VarType> ArgTypes,
                  std::unique_ptr<RetStmtAST> Inner,
                  std::unique_ptr<RetStmtAST> After)
  : RetStmtAST(Block, location), blockId(blockId),
        Args(std::move(Args)), ArgTypes(ArgTypes),
        Inner(std::move(Inner)), After(std::move(After)){}
  void print() override {
    std::cerr << offset << "block_" << blockId << "(";
    for (int i = 0; i < (int)Args.size(); ++i) {
      Args.at(i)->print();
      std::cerr << " ";
    }
    std::cerr << " := ";
    std::cerr << std::endl << std::endl;
    Inner->print();
    std::cerr << std::endl << std::endl;
    After->print();
  };
  static bool classof(const RetStmtAST *c) { return c->getKind() == Block; }

};

class FBodyAST {
  std::vector<std::unique_ptr<LetStmtAST>> Stmts;
  std::unique_ptr<RetStmtAST> Ret;

public:
  FBodyAST(std::vector<std::unique_ptr<LetStmtAST>> Stmts,
           std::unique_ptr<RetStmtAST> Ret)
      : Stmts(std::move(Stmts)), Ret(std::move(Ret)) {}

  void print();
  llvm::ArrayRef<std::unique_ptr<LetStmtAST>> getStmts() { return Stmts; }
  RetStmtAST *getRet() { return Ret.get(); }
};

class CaseStmtAST : public RetStmtAST {
  std::vector<std::unique_ptr<FBodyAST>> Bodies;
  std::string Var;

public:
  CaseStmtAST(Location location, std::vector<std::unique_ptr<FBodyAST>> Bodies,
              const std::string &Var)
      : RetStmtAST(Case, location), Bodies(std::move(Bodies)), Var(Var) {}
  void print() override;
  std::string getVar() { return Var; }
  llvm::ArrayRef<std::unique_ptr<FBodyAST>> getBodies() { return Bodies; }
  static bool classof(const RetStmtAST *c) { return c->getKind() == Case; }
};

class FunctionAST {
  Location location;
  std::string FName;
  std::vector<std::unique_ptr<VariableExprAST>> Args;
  std::unique_ptr<FBodyAST> FBody;
  std::vector<VarType> ArgTypes;
  VarType RetType;

public:
  FunctionAST(Location location, const std::string &FName,
              std::vector<std::unique_ptr<VariableExprAST>> Args,
              std::unique_ptr<FBodyAST> FBody, std::vector<VarType> ArgTypes,
              VarType RetType)
      : location(location), FName(FName), Args(std::move(Args)),
        FBody(std::move(FBody)), ArgTypes(std::move(ArgTypes)),
        RetType(RetType) {}

  std::string getName() { return FName; }
  Location getLoc() { return location; }
  llvm::ArrayRef<std::unique_ptr<VariableExprAST>> getArgs() { return Args; }
  FBodyAST *getFBody() { return FBody.get(); }
  VarType getRetType() { return RetType; }
  llvm::ArrayRef<VarType> getArgTypes() { return ArgTypes; }
  void print();
};

class ModuleAST {
  std::vector<std::unique_ptr<FunctionAST>> FList;

public:
  ModuleAST(std::vector<std::unique_ptr<FunctionAST>> FList)
      : FList(std::move(FList)) {}

  llvm::ArrayRef<std::unique_ptr<FunctionAST>> getFList() { return FList; }
  void print();
};

void FBodyAST::print() {
  offset = offset + " ";
  for (int i = 0; i < (int)Stmts.size(); ++i) {
    std::cerr << offset;
    Stmts.at(i)->print();
  }
  std::cerr << offset;
  Ret->print();
}

void ModuleAST::print() {
  std::cerr << "-------------------AST-----------------------" << std::endl;
  std::cerr << "---------------------------------------------" << std::endl
            << std::endl;
  for (int i = 0; i < (int)FList.size(); ++i) {
    FList.at(i)->print();
  }
  std::cerr << "--------------------------------------------" << std::endl;
}

void FunctionAST::print() {
  std::cerr << offset << FName << " (" << stringOfType(ArgTypes, RetType)
            << ") ";
  for (int i = 0; i < (int)Args.size(); ++i) {
    Args.at(i)->print();
    std::cerr << " ";
  }
  std::cerr << std::endl << std::endl;
  FBody->print();
  offset = "";
  std::cerr << std::endl << std::endl;
}

void DirectRetStmtAST::print() {
  std::cerr << offset << "return " << Var << std::endl;
}

void LetStmtAST::print() {
  std::cerr << offset << "Let " << stringOfType(Vtype) << " " << Var << " = ";
  Rhs->print();
  std::cerr << std::endl;
}

void VariableExprAST::print() { std::cerr << Name; }


void NumberExprAST::print() { std::cerr << Val; }
void AppExprAST::print() {
  std::cerr << "app " << FName;
  for (int i = 0; i < (int)Args.size(); ++i) {
    std::cerr << " ";
    Args.at(i)->print();
  }
}

void PapExprAST::print() {
  std::cerr << "pap " << FName;
  for (int i = 0; i < (int)Args.size(); ++i) {
    std::cerr << " ";
    Args.at(i)->print();
  }
}

void CallExprAST::print() {
  std::cerr << "Call " << FName;
  for (int i = 0; i < (int)Args.size(); ++i) {
    std::cerr << " ";
    Args.at(i)->print();
  }
}

void CtorExprAST::print() {
  std::cerr << "Ctor " << Tag;
  for (int i = 0; i < (int)Args.size(); ++i) {
    std::cerr << " ";
    Args.at(i)->print();
  }
}
void ProjExprAST::print() {
  std::cerr << "Proj"
            << "[" << getIndex() << "] " << getVarName() << std::endl;
}

void CaseStmtAST::print() {
  std::cerr << offset << "Case  on " << getVar() << " : " << std::endl;
  offset = offset + " ";
  for (int i = 0; i < (int)Bodies.size(); ++i) {
    Bodies.at(i)->print();
    std::cerr << std::endl;
  }
  offset = "";
}

std::string stringOfType(VarType t) {
  if (t == object) {
    return "object";
  } else {
    return "int";
  }
}
std::string stringOfType(std::vector<VarType> ts) {
  std::string result = "";
  for (VarType t : ts) {
    result = result + stringOfType(t) + " -> ";
  }
  return result;
}
std::string stringOfType(std::vector<VarType> ts, VarType t) {
  return stringOfType(ts) + "-> " + stringOfType(t);
}

// LEX & PARSE ===
// LEX & PARSE ===
// LEX & PARSE ===
// LEX & PARSE ===
// LEX & PARSE ===
// LEX & PARSE ===
// LEX & PARSE ===

class Mapping {
public:
  std::string var;
  mlir::Value val;
  mlir::Type ty;
  Mapping(std::string var, mlir::Value val, mlir::Type ty)
      : var(var), val(val), ty(ty) {}
};

class ScopeTable {
private:
  std::vector<Mapping *> curr;
  std::vector<Mapping *> prev;

  bool exist(std::string var) {
    for (auto p : curr) {
      if (p->var.compare(var) == 0) {
        return true;
      }
    }
    return false;
  }

public:
  void scope() {
    for (auto p : curr) {
      prev.push_back(p);
    }
  }
  void descope() {
    curr.clear();
    for (auto p : prev) {
      curr.push_back(p);
    }
    prev.clear();
  }
  mlir::LogicalResult declare(llvm::StringRef var, mlir::Value val,
                              mlir::Type ty) {
    return declare(var.str(), val, ty);
  }

  mlir::LogicalResult declare(std::string var, mlir::Value val, mlir::Type ty) {
    if (exist(var)) {
      return mlir::failure();
    } else {
      curr.push_back(new Mapping(var, val, ty));
    }
    return mlir::success();
  }
  mlir::Value lookup(llvm::StringRef var) { return lookup(var.str()); }
  mlir::Value lookup(std::string var) {
    for (auto p : curr) {
      if (p->var.compare(var) == 0) {
        return p->val;
      }
    }
    return nullptr;
  }

  mlir::Type lookupType(llvm::StringRef var) { return lookupType(var.str()); }
  mlir::Type lookupType(std::string var) {
    for (auto p : curr) {
      if (p->var.compare(var) == 0) {
        return p->ty;
      }
    }
    assert(false && "unable to find type.");
  }
  void print() {
    std::cerr << "-----SymbolTable-----" << std::endl;
    for (auto p : curr) {
      std::cerr << p->var << std::endl;
    }
    std::cerr << "---------------------" << std::endl;
  }

}; // class ScopeTable

// === LEXER ===
// === LEXER ===
// === LEXER ===
// === LEXER ===
// === LEXER ===
// === LEXER ===


enum TokenType : int {
  tok_eof = 0,

  // symbols
  tok_semicolon = ';',   // ';'
  tok_colon = ':',       // ':'
  tok_apostrophe = '\'', // '
  tok_l_square_brack = '[',
  tok_r_square_brack = ']',
  // keywords
  tok_def = -2,  // def
  tok_let = -3,  // let
  tok_ret = -4,  // ret
  tok_case = -5, // case
  tok_app = -6,  // app
  tok_ctor = -7, // ctor
  tok_proj = -8, // proj
  tok_pap = -9,  // pap
  tok_jmp = -10, // jmp
  tok_box = -11, // ◾
  tok_string = -11, // ◾
  //....
  // values
  tok_id = -100, // identifier
  tok_lit = -101 // literal number
};

class Lexer {
private:
  // buffer
  mlir::MLIRContext *context;
  Location lastLocation;
  llvm::StringRef buffer;
  // Location
  int curLine = 1;
  int curCol = 1;

  // tokens
  std::string identifierStr;
  double numVal = 0;
  TokenType curTok = tok_eof;
  TokenType lastChar = TokenType(' ');

  TokenType getNextChar() {
    if (buffer.size() == 0) {
      // std::cerr << "\nEOF\n";
      return TokenType(EOF);
    }
    curCol++;
    // StringRef bufCur = buffer.drop_front(bufferIndex);
    const StringRef boxstr = "◾";
    if (buffer.startswith(boxstr)) {
      buffer = buffer.drop_front(boxstr.size());
      curCol++;
      // std::cerr << "box str (after): |" << buffer.begin()[0] << "|\n";
      // assert(false && "box string");
      // std::cerr << "\nCHAR: " << std::string(boxstr) << "\n";
      return TokenType(TokenType::tok_box);
    }

    char res = buffer[0];
    buffer = buffer.drop_front(1);
    if (res == '\n') {
      curCol = 1;
      curLine++;
    }

    // std::cerr << "\nCHAR: " << (char) res << "\n";
    return TokenType(res);
  }


  TokenType getTok() {
    identifierStr = "~UNK~";

    while (isspace(lastChar)) {
      lastChar = getNextChar();
    }

    if (lastChar == '"') {
      identifierStr = "";
      while(1) {
        char c = getNextChar();
        if (c == '"') {
          lastChar = TokenType(getNextChar());
          return TokenType::tok_string;
        } else {
          identifierStr += c;
        }
      }
    }

    // mlir::Location
    // lastLocation = mlir::Location(mlir::LocationAttr())
    // lastLocation.line = curLine;
    // lastLocation.col = curCol;
    lastLocation =
        mlir::FileLineColLoc::get("UNKNOWN-FILE", curLine, curCol, context);

    if (lastChar == TokenType::tok_box) {
        TokenType ThisChar = TokenType(lastChar);
        lastChar = TokenType(getNextChar());
        return ThisChar;
    }
    


    // if this is [a-zA-Z][a-zA-Z0-9_]
    if (isalpha(lastChar) || lastChar == '_') {
      identifierStr = lastChar;
      lastChar = TokenType(getNextChar());

      //[a-zA-Z][a-zA-Z0-9_.!]
      while (lastChar == '\'' || lastChar == '.' || lastChar == '!' || lastChar == '-' ||
             isalnum(lastChar) || lastChar == '_') {
        // replace apostrophe with _prime, c cant have
        // it in function names
        if (lastChar == '\'') {
          identifierStr += "_prime_";
        } else if (lastChar == '.') {
          identifierStr += "_dot_";
        } else if (lastChar == '!') {
          identifierStr += "_not_";
        } else if (lastChar == '-') {
          identifierStr += "_hyphen_";
        }
        else {
          assert(isalnum(lastChar) || lastChar == '_');
          identifierStr += lastChar;
        }
        lastChar = TokenType(getNextChar());
      };
      if (identifierStr == "def")
        return tok_def;
      if (identifierStr == "let")
        return tok_let;
      if (identifierStr == "ret")
        return tok_ret;
      if (identifierStr == "case")
        return tok_case;
      if (identifierStr == "app")
        return tok_app;
      if (identifierStr == "proj")
        return tok_proj;
      if (identifierStr.find("ctor_") != std::string::npos)
        return tok_ctor;
      if (identifierStr == "pap")
        return tok_pap;
      if (identifierStr == "jmp")
	return tok_jmp;

      return tok_id;
    }

    if (isdigit(lastChar)) { // Number(no floats): [0-9]*
      std::string NumStr;
      do {
        NumStr += lastChar;
        lastChar = TokenType(getNextChar());
      } while (isdigit(lastChar));
      numVal = std::stoi(NumStr.c_str());
      return tok_lit;
    }

    // >>> ord("◾") |  9726
    // if (lastChar == 9726 || lastChar == -30) {
    // }

    if (lastChar == EOF) {
      return tok_eof;
    }

    // ending case: return characters in single token(ascii)
    TokenType ThisChar = TokenType(lastChar);
    lastChar = TokenType(getNextChar());
    return ThisChar;
  }

  // std::string curLineBuffer = "\n";

public:
  Lexer(mlir::MLIRContext *context, llvm::StringRef buffer)
      : context(context),
        lastLocation(mlir::FileLineColLoc::get("UNKNOWN-FILE", 1, 1, context)),
        buffer(buffer) {}

  TokenType getCurToken() { return curTok; }
  TokenType getNextToken() { return curTok = getTok(); }
  void consume(TokenType tok) {
    if (tok != curTok) {
      llvm::errs() << "\nCONSUME ERROR. Expected: |" << tok << "|"
                   << "char:|" << (char)tok << "|"
                   << "; FOUND |" << curTok << "|"
                   << "char |" << (char)curTok << "|\n";
      llvm::errs() << "location: |" << this->curLine << ":" << this->curCol << "|\n";
    }
    assert(tok == curTok && "consume Token mismatch expectation");
    getNextToken();
  }

  std::string getId() { return identifierStr; }

  double getValue() {
    assert(curTok == tok_lit);
    return numVal;
  }

  Location getLoc() { return lastLocation; }
  int getLine() { return curLine; }
  int getCol() { return curCol; }
};

// === PARSER ===
// === PARSER ===
// === PARSER ===
// === PARSER ===
// === PARSER ===
// === PARSER ===
// === PARSER ===
// === PARSER ===


void unexpectedTokenError(Lexer &lexer) {
    std::cerr << "unexpected token| id/text of token: |" << lexer.getId() << "| ";
    if (lexer.getCurToken() > 0) {
        std::cerr << "token as character: |" << (char)lexer.getCurToken() << "|";
    } else {
        std::cerr << "token: |" << lexer.getCurToken() << "|";
    }
    std::cerr << " loc |" << lexer.getLine() << ":" << lexer.getCol() << "|"
        << std::endl;
    lexer.getNextToken();
}


struct DebugCall {
  static int indent;
  const char *name;
  DebugCall (const char *name): name(name) {

    // for(int i = 0; i < indent*2; ++i) { std::cerr << " "; }
    // std::cerr << "vvv" << name << "\n"; 
    indent++;

  }

  ~DebugCall() { 
    // for(int i = 0; i < indent*2; ++i) { std::cerr << " "; }
    // std::cerr << "^^^" << name << "\n"; 
    indent--;
  }
};

int DebugCall::indent = 0;

class Parser {
private:
  Lexer &lexer;

  // we can ignore binop precedence as there are none builtin

  VarType ParseType() {
    DebugCall d(__PRETTY_FUNCTION__);
    VarType result;
    if (lexer.getId() == "obj") {
      result = object;
    } else if (lexer.getId() == "u8") {
      result = u8;
    } else if (lexer.getId() == "u16") {
      result = u16;
    } else if (lexer.getId() == "u32") {
      result = u32;
    } else if (lexer.getId() == "u64") {
      result = u64;
    } else if (lexer.getId() == "usize") {
      result = u64;
    }  else if (lexer.getCurToken() == TokenType::tok_box) {
      result = u64;
      // result = box;
    } else {
      unexpectedTokenError(lexer);
      assert(false && "unable to parse type!");
    }

    lexer.getNextToken(); // consume type
    return result;
  }

  std::unique_ptr<NumberExprAST> ParseNumberExpr() {
    DebugCall d(__PRETTY_FUNCTION__);

    auto res = std::make_unique<NumberExprAST>(lexer.getValue());
    lexer.getNextToken(); // consume number
    return res;
  }
  std::unique_ptr<VariableExprAST> ParseVarExpr() {
    DebugCall d(__PRETTY_FUNCTION__);

    if (lexer.getId() == "~UNK~") {
      llvm::errs() << "~UNK~ token type: |" << lexer.getCurToken() << " | token as char: |" << (char) lexer.getCurToken()
      <<  "| [" << lexer.getLine() << ":" << lexer.getCol() << "]\n";
      assert(lexer.getCurToken() == TokenType::tok_box);
      errs() << "SUPER HACK: Box at variable: |" << lexer.getLine() << ":" << lexer.getCol() << "|\n";
    }
    std::string varName = lexer.getCurToken() == TokenType::tok_box ? std::string(GLOBAL_BOX_NAME) : lexer.getId();
    auto res = std::make_unique<VariableExprAST>(varName);
    lexer.getNextToken(); // consume var
    return res;
  }

  std::unique_ptr<AppExprAST> ParseAppExpr() {
    DebugCall d(__PRETTY_FUNCTION__);

    lexer.getNextToken(); // consume app
    std::string fname = lexer.getId();
    lexer.getNextToken(); // consume funcname
    std::vector<std::unique_ptr<VariableExprAST>> args;
    while (lexer.getCurToken() != tok_semicolon) {
      args.push_back(ParseVarExpr());
    }
    return std::make_unique<AppExprAST>(fname, std::move(args));
  }

  std::unique_ptr<PapExprAST> ParsePapExpr() {
    lexer.getNextToken(); // consume pap
    std::string fname = lexer.getId();
    lexer.getNextToken(); // consume funcname
    std::vector<std::unique_ptr<VariableExprAST>> args;
    while (lexer.getCurToken() != tok_semicolon) {
      args.push_back(ParseVarExpr());
    }
    return std::make_unique<PapExprAST>(fname, std::move(args));
  }

  std::unique_ptr<CallExprAST> ParseCallExpr() {
    DebugCall d(__PRETTY_FUNCTION__);

    std::string fname = lexer.getId();
    lexer.getNextToken(); // consume funcname
    std::vector<std::unique_ptr<VariableExprAST>> args;
    while (lexer.getCurToken() != tok_semicolon) {
      args.push_back(ParseVarExpr());
    }
    return std::make_unique<CallExprAST>(fname, std::move(args));
  }

  std::unique_ptr<CtorExprAST> ParseCtorExpr() {
    DebugCall d(__PRETTY_FUNCTION__);

    int Tag = std::stoi(lexer.getId().substr(5).c_str());
    lexer.getNextToken(); // consume ctor_x
    lexer.getNextToken(); // consume '['
    lexer.getNextToken(); // consume ConstrName
    lexer.getNextToken(); // consume ']'
    std::vector<std::unique_ptr<VariableExprAST>> Args;
    while (lexer.getCurToken() != tok_semicolon) {
      Args.push_back(ParseVarExpr());
    }
    return std::make_unique<CtorExprAST>(Tag, std::move(Args));
  }

  std::unique_ptr<ProjExprAST> ParseProjExpr() {

    lexer.getNextToken(); // consume "proj"
    lexer.getNextToken(); // consume '['
    int i = lexer.getValue();
    lexer.getNextToken(); // consume Numval
    lexer.getNextToken(); // consume ']'

    return std::make_unique<ProjExprAST>(i, ParseVarExpr());
  }
  std::unique_ptr<ExprAST> ParseExpression() {
      DebugCall d(__PRETTY_FUNCTION__);

    if (lexer.getCurToken() == tok_id) {
      return ParseCallExpr();
    }
    if (lexer.getCurToken() == tok_app) {
      return ParseAppExpr();
    } else if (lexer.getCurToken() == tok_pap) {
      return ParsePapExpr();
    } else if (lexer.getCurToken() == tok_lit) {
      return ParseNumberExpr();
    } else if (lexer.getCurToken() == tok_ctor) {
      return ParseCtorExpr();
    } else if (lexer.getCurToken() == tok_proj) {
      return ParseProjExpr();
    } else if (lexer.getCurToken() == tok_string) {
      llvm::errs() << "STRING: |" << lexer.getId() << "| [" << lexer.getLine() << ":" << lexer.getCol() << "] \n";
      std::unique_ptr<StringExprAST> ptr =  std::make_unique<StringExprAST>(lexer.getId());
      lexer.getNextToken(); // consume semicolon.
      assert(lexer.getCurToken() == tok_semicolon);
      
      return ptr; 
    } else {
      std::cerr << "Invalid Expression, nullptr" << std::endl;
      return nullptr;
    } 
  }

  // let var := expression
  std::unique_ptr<LetStmtAST> ParseLetStmt() {
    DebugCall d(__PRETTY_FUNCTION__);

    lexer.getNextToken(); // consume let
    std::string var = lexer.getId();
    lexer.getNextToken();
    lexer.getNextToken(); // consume var name :
    VarType t = ParseType();
    lexer.getNextToken();
    lexer.getNextToken(); // consume  :=
    auto expr = ParseExpression();
    assert(lexer.getCurToken() == tok_semicolon);
    lexer.getNextToken(); // consume ';'

    return std::make_unique<LetStmtAST>(lexer.getLoc(), var, std::move(expr),
                                        t);
  }

  std::unique_ptr<DirectRetStmtAST> ParseDirectRetStmt() {
    DebugCall d(__PRETTY_FUNCTION__);

    lexer.consume(TokenType::tok_ret);
    assert(lexer.getCurToken() == TokenType::tok_id);
    std::string var = lexer.getId();
    lexer.consume(TokenType::tok_id); // consume var
    return std::make_unique<DirectRetStmtAST>(lexer.getLoc(), var);
  }

  std::unique_ptr<CaseStmtAST> ParseCaseStmt() {
    DebugCall d(__PRETTY_FUNCTION__);

    lexer.getNextToken(); // consume case
    std::string var = lexer.getId();
    std::vector<std::unique_ptr<FBodyAST>> bodies;
    lexer.getNextToken(); // consume var name
    lexer.getNextToken(); // consume :
    lexer.getNextToken(); // consume type
    lexer.getNextToken(); // consume of

    while (lexer.getCurToken() == tok_id) {
      lexer.getNextToken(); // consume branch
      lexer.getNextToken();
      lexer.getNextToken();
      lexer.getNextToken(); // consume ->
      bodies.push_back(ParseFBody());
    }
    return std::make_unique<CaseStmtAST>(lexer.getLoc(), std::move(bodies),
                                         var);
  }

  std::unique_ptr<BlockRetStmtAST> ParseBlockRetStmt(int blockId) {
    Location loc = lexer.getLoc();
    std::vector<std::unique_ptr<VariableExprAST>> Args;
    std::vector<VarType> ArgTypes;

    while (true) {
      if (lexer.getCurToken() != '(') { break; }
      lexer.consume(TokenType('('));
      Args.push_back(ParseVarExpr());
      lexer.consume(TokenType(':'));
      ArgTypes.push_back(ParseType());
      lexer.consume(TokenType(')'));
    }

    // pls cleanup eventually.
    lexer.consume(TokenType(':'));
    lexer.consume(TokenType('='));

    llvm::errs() << "=======parsing inner...=======\n";

    std::unique_ptr<RetStmtAST> inner = this->ParseRetStmt();

    llvm::errs() << "=======parsed inner!=======\n";

    lexer.consume(TokenType::tok_semicolon); // consume ; between the inner and outer

    llvm::errs() << "=======parsing outer...=======\n";

    std::unique_ptr<RetStmtAST> outer = this->ParseRetStmt();

    llvm::errs() << "=======parsed outer!=======\n";

    return std::make_unique<BlockRetStmtAST>(loc, blockId,
                                             std::move(Args),
                                             ArgTypes,
                                             std::move(inner),
                                             std::move(outer));
    assert(false && "don't know how to parse block ret statement");
  }

  std::unique_ptr<RetStmtAST> ParseRetStmt() {
    DebugCall d(__PRETTY_FUNCTION__);
    const std::string id = lexer.getId();

    if (lexer.getCurToken() == tok_ret) {
      return ParseDirectRetStmt();
    } else if (lexer.getCurToken() == tok_case) {
      return ParseCaseStmt();
    } else if (startswith(id, "block_")) {
       // unexpectedTokenError(lexer);
       const  std::string blockIdStr = id.substr(strlen("block_"));
       int blockId = atoi(blockIdStr.c_str());
       lexer.getNextToken(); // eat current identifier;
       return ParseBlockRetStmt(blockId);
       assert(false && "unable to parse block_");
    } else {
      unexpectedTokenError(lexer);
      assert(false && "unable to parse return statement.");
      // std::cerr << lexer.getCurToken() << std::endl;
      // std::cerr << "Error in return statement, nullptr"
      //         << std::endl;
      return nullptr;
    }
  }

  std::unique_ptr<FBodyAST> ParseFBody() {
    DebugCall d(__PRETTY_FUNCTION__);
    std::vector<std::unique_ptr<LetStmtAST>> stmts;
    while (lexer.getCurToken() == tok_let) {
      stmts.push_back(ParseLetStmt());
    }
    
    return std::make_unique<FBodyAST>(std::move(stmts), ParseRetStmt());
    
  }

  std::unique_ptr<FunctionAST> ParseFunction() {
    DebugCall d(__PRETTY_FUNCTION__);

    std::vector<std::unique_ptr<VariableExprAST>> Args;
    std::vector<VarType> ArgTypes;
    lexer.getNextToken(); // eat def
    std::string FName = lexer.getId();
    if (FName == "main") {
      FName = "_lean_main";
    }
    while (true) {
      lexer.getNextToken(); // eat fname or ) depending on first or later
                            // iteration
      if (lexer.getCurToken() != '(') {
        break;
      }
      
      lexer.getNextToken(); // eat '('
      Args.push_back(ParseVarExpr());
      lexer.getNextToken(); // consume :
      ArgTypes.push_back(ParseType());
    }

    lexer.getNextToken(); // consume :
    VarType retType = ParseType();
    lexer.getNextToken();
    lexer.getNextToken(); // eat :=
    auto FBody = ParseFBody();
    return std::make_unique<FunctionAST>(lexer.getLoc(), FName, std::move(Args),
                                         std::move(FBody), std::move(ArgTypes),
                                         retType);
  }

public:
  Parser(Lexer &lexer) : lexer(lexer) {}

  std::unique_ptr<ModuleAST> parse() {
    lexer.getNextToken(); // get rid of start of file token
    std::vector<std::unique_ptr<FunctionAST>> FList;
    while (true) {
      switch (lexer.getCurToken()) {
      case tok_eof:
        return std::make_unique<ModuleAST>(std::move(FList));
      case tok_def:
        FList.push_back(ParseFunction());
        break;
     case tok_l_square_brack: {
        // TODO: check that we found [init]
        lexer.getNextToken(); // eatj
        TokenType rbrack = lexer.getNextToken();
        assert (rbrack == tok_r_square_brack && "expected [init]");

        lexer.getNextToken();
        break;
    }

      default: {
        unexpectedTokenError(lexer);
        assert(false && "unkexpected token");
        break;
      }
      } // end switch
    }
  }
}; // class Parser

// === MLIRGEN ===
// === MLIRGEN ===
// === MLIRGEN ===
// === MLIRGEN ===
// === MLIRGEN ===
// === MLIRGEN ===
// === MLIRGEN ===
// === MLIRGEN ===
// === MLIRGEN ===
// === MLIRGEN ===
class MLIRGenImpl {
public:
  MLIRGenImpl(mlir::MLIRContext &context)
      : builder(&context), lastLoc(builder.getUnknownLoc()) {}
  // converts lambdapure AST -> MLIR
  mlir::ModuleOp mlirGen(ModuleAST &moduleAST) {
    theModule = mlir::ModuleOp::create(loc());
    auto funcs = moduleAST.getFList();
    for (auto &funcAST : funcs) {
      mlir::FuncOp func = mlirGen(*funcAST);
      if (!func) {
        return nullptr;
      }
      theModule.push_back(func);
    }
    // for(int i = 0; i < funcs.size(); ++i){
    //   // auto func = mlirGen(*funcs.at(i));
    // }
    // for(FunctionAST &funcAST : moduleAST.getFList()){
    //   // auto func = mlirGen(funcAST);
    //   // if(!func){
    //   //   return nullptr;
    //   // }
    //   // theModule.push_back(func);
    // }

    // if (failed(mlir::verify(theModule))) {
    //   theModule.emitError("module verification error");
    //   return nullptr;
    // }
    return theModule;
  }

  mlir::ModuleOp emptyModuleOp() {
    return mlir::ModuleOp::create(builder.getUnknownLoc());
  }

private:
  mlir::ModuleOp theModule;
  mlir::OpBuilder builder;
  llvm::ScopedHashTable<StringRef, mlir::Value> symbolTable;
  ScopeTable scopeTable = ScopeTable();
  mlir::Location lastLoc;
  mlir::Block lastBlock;
  mlir::Location loc() { return lastLoc; }

  mlir::Location loc(Location loc) {
    lastLoc = loc;
    return loc;
  }

  mlir::Type typeGen(VarType t) {
    switch (t) {
    case object:
      // return mlir::lambdapure::ObjectType::get(builder.getContext());
      return standalone::ValueType::get(builder.getContext());
    case u8:
      return builder.getIntegerType(8);
    default:
      return builder.getIntegerType(64);
    }
  }

  mlir::FuncOp mlirGen(FunctionAST &functionAST) {
    // create scope
    scopeTable.scope();
    ScopedHashTableScope<StringRef, mlir::Value> var_scope(symbolTable);
    // setup type
    std::vector<mlir::Type> inputs;
    for (VarType t : functionAST.getArgTypes()) {
      inputs.push_back(typeGen(t));
    }
    // mlir::Type retTy;
    auto FName = functionAST.getName();
    auto func_type =
        builder.getFunctionType(inputs, typeGen(functionAST.getRetType()));
    // if(FName.compare("main") == 0){
    //   FName = "main";
    //   // if(inputs.size() > 0 ) {assert(false && "Invalid function main_, no
    //   input types allowed");} func_type =
    //   builder.getFunctionType(inputs,llvm::None);
    // }

    // setup loc,name,type
    //--------------------------------------------------------
    mlir::FuncOp function =
        mlir::FuncOp::create(loc(functionAST.getLoc()), FName, func_type);
    mlir::Block &entryBlock = *function.addEntryBlock();

    for (unsigned i = 0; i < functionAST.getArgs().size(); ++i) {
      if (failed(scopeTable.declare(
              functionAST.getArgs().begin()[i]->getName(),
              entryBlock.getArguments().begin()[i],
              typeGen(functionAST.getArgTypes().begin()[i])))) {
        return nullptr;
      }
    }
    //
    builder.setInsertionPointToStart(&entryBlock);
    // auto region = function.getCallableRegion();
    (void)mlirGen(*functionAST.getFBody());

    //--------------------------------------------------------
    // experimenting
    // ReturnOp returnOp;
    // builder.create<ReturnOp>(loc());
    //===============

    scopeTable.descope();
    return function;
  }

  mlir::LogicalResult mlirGen(DirectRetStmtAST &direct) {
    // llvm::StringRef var = direct.getVar();
    std::string var = std::string(direct.getVar());
    mlir::Value result = scopeTable.lookup(var);
    // builder.create<lambdapure::ReturnOp>(loc(), result);
    // builder.create<standalone::HaskReturnOp>(loc(), result);
    builder.create<standalone::HaskReturnOp>(loc(), result);
    // if(!result){
    //   builder.create<ReturnOp>(loc());
    //
    // }
    // else {
    //   builder.create<ReturnOp>(loc(),result);
    // }
    return mlir::success();
  }

  mlir::LogicalResult mlirGen(CaseStmtAST &casestmt) {
    // llvm::StringRef var = casestmt.getVar();
    std::string var = std::string(casestmt.getVar());
    mlir::Value curr_val = scopeTable.lookup(var);
    auto bodies = casestmt.getBodies();
    mlir::Type t = curr_val.getType();
    if (t.isa<mlir::standalone::ValueType>()) {
      curr_val = builder.create<mlir::standalone::TagGetOp>(
          loc(), curr_val);
    }

    // assert(false && "TODO: switch up case");
    // auto caseOp = builder.create<mlir::lambdapure::CaseOp>(loc(), curr_val,
    //                                                         bodies.size());
    auto caseOp = builder.create<mlir::standalone::CaseOp>(loc(), curr_val,
                                                           bodies.size());

    int i = 0;
    for (auto &body : bodies) {
      mlir::Region &region = caseOp->getRegion(i);
      mlir::Block *block = builder.createBlock(&region);
      builder.setInsertionPointToStart(block);
      (void)mlirGen(*body);
      ++i;
    }
    builder.setInsertionPointAfter(caseOp);
    // builder.create<mlir::ReturnOp>(loc(), caseOp.getResult());
    builder.create<standalone::HaskReturnOp>(loc(), caseOp.getResult());
    return mlir::success();
  }

  mlir::LogicalResult mlirGen(RetStmtAST &ret) {
    switch (ret.getKind()) {
    case RetStmtAST::Direct:
      return mlirGen(cast<DirectRetStmtAST>(ret));
    case RetStmtAST::Case:
      return mlirGen(cast<CaseStmtAST>(ret));
    case RetStmtAST::Block:
      assert(false && "don't know how to codegen block!");
      }

    assert(false && "unhandled retstmt");
  }

  mlir::Value mlirGen(NumberExprAST &expr) {
    // return builder.create<mlir::lambdapure::IntegerConstOp>(loc(), expr.getValue());
    return builder.create<standalone::IntegerConstOp>(loc(), expr.getValue());
  }

  mlir::Value mlirGenVar(VariableExprAST &expr) {
    if (expr.getName() == GLOBAL_BOX_NAME) {
      // create the box value
      return builder.create<standalone::ErasedValueOp>(loc());
    } else {
      return scopeTable.lookup(expr.getName());
    }
  }

  mlir::Value mlirGen(AppExprAST &expr, mlir::Type ty) {
    llvm::SmallVector<mlir::Value, 4> args;
    mlir::Value funcVal = scopeTable.lookup(expr.getFName());
    for (auto &varExpr : expr.getArgs()) {
      args.push_back(mlirGenVar(*varExpr));
    }
    // return builder.create<mlir::lambdapure::AppOp>(loc(), funcVal, args, ty);
    return builder.create<standalone::ApOp>(loc(), funcVal, args, ty);

  }

  mlir::Value mlirGenString(StringExprAST &expr, mlir::Type ty) {
    return builder.create<ptr::PtrStringOp>(loc(), expr.getValue());
    // assert(false && "codegen of string is unhandled");
  }

  mlir::Value mlirGenCall(CallExprAST &expr, mlir::Type ty) {
    llvm::SmallVector<mlir::Value, 4> args;
    int i = 0; 
    llvm::errs() << "\nCALLOP:\n";
    for (auto &varExpr : expr.getArgs()) {
      llvm::errs() << "generating argument |" << varExpr->getName() << "|\n";
      varExpr->print();
      mlir::Value v = mlirGenVar(*varExpr);
      assert(v && "incorrect value");
      llvm::errs() << i++ << ":\n";
      llvm::errs() << "\t" << v << "\n";
      llvm::errs() << "---\n";
      args.push_back(v);
    }
    llvm::errs() << "\nReturn type: |" << ty << "|\n";
    llvm::errs() << "======\n";

    std::string fName = expr.getFName();
    // llvm::SmallVector<mlir::Type, 4> results;
    // results.push_back(ty);
    // TODO HACK: need to resolve all functions correctly.
    return builder.create<mlir::lambdapure::CallOp>(loc(), fName, args, ty);
    // mlir::CallOp call =  builder.create<mlir::CallOp>(loc(), ty, fName, args);
    // return call.getResult(0);
  }

  mlir::Value mlirGen(PapExprAST &expr, mlir::Type ty) {
    llvm::SmallVector<mlir::Value, 4> args;
    for (auto &varExpr : expr.getArgs()) {
      args.push_back(mlirGenVar(*varExpr));
    }

    std::string fName = expr.getFName();
    return builder.create<standalone::PapOp>(loc(), fName, args);
  }

  mlir::Value mlirGen(ProjExprAST &expr, mlir::Type ty) {
    auto varExpr = expr.getVar();
    // return builder.create<mlir::lambdapure::ProjectionOp>(
    //     loc(), expr.getIndex(), mlirGen(*varExpr), ty);
    return builder.create<standalone::ProjectionOp>(
        loc(), expr.getIndex(), mlirGenVar(*varExpr), ty);

  }

  mlir::Value mlirGen(CtorExprAST &expr, mlir::Type ty) {
    llvm::SmallVector<mlir::Value, 4> args;
    for (auto &varExpr : expr.getArgs()) {
      args.push_back(mlirGenVar(*varExpr));
    }
    // return builder.create<mlir::lambdapure::ConstructorOp>(loc(), expr.getTag(),
    //                                                        args, ty);

    assert(ty.isa<standalone::ValueType>() && "expected type to be a value type!");
    return builder.create<standalone::HaskConstructOp>(loc(), std::to_string(expr.getTag()), args);

    // return nullptr;
  }

  mlir::Value mlirGen(ExprAST &expr, mlir::Type ty) {

    switch (expr.getKind()) {
    case ExprAST::NumberExpr:
      return mlirGen(cast<NumberExprAST>(expr));
    case ExprAST::VarExpr:
      return mlirGenVar(cast<VariableExprAST>(expr));
    case ExprAST::AppExpr:
      return mlirGen(cast<AppExprAST>(expr), ty);
    case ExprAST::CallExpr:
      return mlirGenCall(cast<CallExprAST>(expr), ty);
    case ExprAST::CtorExpr:
      return mlirGen(cast<CtorExprAST>(expr), ty);
    case ExprAST::ProjExpr:
      return mlirGen(cast<ProjExprAST>(expr), ty);
    case ExprAST::PapExpr:
      return mlirGen(cast<PapExprAST>(expr), ty);
    case ExprAST::StringExpr:
      return mlirGenString(cast<StringExprAST>(expr), ty);
    };

    assert(false && "unhandled expression");
  }

  mlir::LogicalResult mlirGen(FBodyAST &fBodyAST) {
    for (const std::unique_ptr<LetStmtAST> &letstmt : fBodyAST.getStmts()) {
      auto expr = letstmt->getExpr();
      mlir::Type ty = typeGen(letstmt->getVtype());
      mlir::Value value = mlirGen(*expr, ty);
      if (failed(scopeTable.declare(letstmt->getName(), value, ty))) {
        std::cerr << "Failed to declare variable in let stament" << std::endl;
        return mlir::failure();
      }
    }
    auto ret = mlirGen(*fBodyAST.getRet());
    return ret;
  }
};

// mlir::OwningModuleRef mlirGen(mlir::MLIRContext &context,
//                              ModuleAST &moduleAST) {
//}

//  === translateLambdapureToModule ===
//  === translateLambdapureToModule ===
//  === translateLambdapureToModule ===
//  === translateLambdapureToModule ===
//  === translateLambdapureToModule ===
//  === translateLambdapureToModule ===
//  === translateLambdapureToModule ===
//  === translateLambdapureToModule ===
//  === translateLambdapureToModule ===

OwningModuleRef translateLambdapureToModule(llvm::SourceMgr &sourceMgr,
                                            MLIRContext *context) {
  // llvm::SMDiagnostic err;
  // llvm::LLVMContext llvmContext;
  // int *lambdapureModule = nullptr;
  // std::unique_ptr<llvm::Module> llvmModule = llvm::parseIR(
  //     *sourceMgr.getMemoryBuffer(sourceMgr.getMainFileID()), err,
  //     llvmContext);
  // if (!llvmModule) {
  //   std::string errStr;
  //   llvm::raw_string_ostream errStream(errStr);
  //   err.print(/*ProgName=*/"", errStream);
  //   emitError(UnknownLoc::get(context)) << errStream.str();
  //   return {};
  // }

  const llvm::MemoryBuffer *file =
      sourceMgr.getMemoryBuffer(sourceMgr.getMainFileID());

  llvm::StringRef buffer = file->getBuffer();
  Lexer lexer = Lexer(context, buffer);
  Parser parser = Parser(lexer);
  std::unique_ptr<ModuleAST> lambdapureModule = parser.parse();

  context->loadDialect<mlir::StandardOpsDialect>();
  context->loadDialect<mlir::lambdapure::LambdapureDialect>();
  context->loadDialect<standalone::HaskDialect>();
  context->loadDialect<ptr::PtrDialect>();
  // OwningModuleRef module(ModuleOp::create(
  //     FileLineColLoc::get("", /*line=*/0, /*column=*/0, context)));

  // Importer deserializer(context, module.get());
  // for (llvm::GlobalVariable &gv : llvmModule->globals()) {
  //   if (!deserializer.processGlobal(&gv))
  //     return {};
  // }
  // for (llvm::Function &f : llvmModule->functions()) {
  //   if (failed(deserializer.processFunction(&f)))
  //     return {};
  // }

  return MLIRGenImpl(*context).mlirGen(*lambdapureModule);
  // return mlirGen(*context, *lambdapureModule);
}

int main(int argc, char **argv) {
  mlir::TranslateToMLIRRegistration fromLambdapure(
      "import-lambdapure",
      [](llvm::SourceMgr &sourceMgr, MLIRContext *context) {
        return ::translateLambdapureToModule(sourceMgr, context);
      });

  // TODO: Register standalone translations here.

  return failed(
      mlir::mlirTranslateMain(argc, argv, "MLIR Translation Testing Tool"));
}

