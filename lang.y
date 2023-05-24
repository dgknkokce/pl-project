%{
#include <stdio.h>
#include "mylangcommon.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s in line %d\n", s, yylineno);
}

%}

%token WRITE EXIT LPAREN RPAREN PLUS TIMES MINUS DIVIDE ASSIGN IF ELSEIF WHILE FOR ELSE LT GT TRUE FALSE FUNC LBRACE RBRACE RETURN IDENTIFIER INTEGER FLOAT SEMICOLON NEWLINE

%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc UMINUS

%%

program : statement_list
        ;

statement_list : statement
               | statement_list statement
               ;

statement : assignment_statement
          | write_statement
          | if_statement
          | while_statement
          | for_statement
          | return_statement
          ;

assignment_statement : IDENTIFIER ASSIGN expression SEMICOLON
                     ;

write_statement : WRITE expression SEMICOLON
                ;

if_statement : IF LPAREN expression RPAREN LBRACE statement_list RBRACE
             | IF LPAREN expression RPAREN LBRACE statement_list RBRACE ELSE LBRACE statement_list RBRACE
             | IF LPAREN expression RPAREN LBRACE statement_list RBRACE elseif_statement_list
             | IF LPAREN expression RPAREN LBRACE statement_list RBRACE elseif_statement_list ELSE LBRACE statement_list RBRACE
             ;

elseif_statement_list : elseif_statement
                      | elseif_statement_list elseif_statement
                      ;

elseif_statement : ELSEIF LPAREN expression RPAREN LBRACE statement_list RBRACE
                 ;

while_statement : WHILE LPAREN expression RPAREN LBRACE statement_list RBRACE
                ;

for_statement : FOR LPAREN assignment_statement SEMICOLON expression SEMICOLON assignment_statement RPAREN LBRACE statement_list RBRACE
              ;

return_statement : RETURN expression SEMICOLON
                 ;

expression : LPAREN expression RPAREN %prec UMINUS
           | expression PLUS expression
           | expression MINUS expression
           | expression TIMES expression
           | expression DIVIDE expression
           | expression LT expression
           | expression GT expression
           | TRUE
           | FALSE
           | IDENTIFIER
           | INTEGER
           | FLOAT
           | func_call
           ;

func_call : FUNC LPAREN expression_list RPAREN
          ;

expression_list : expression
                | expression_list COMMA expression
                ;

%%

int main() {
    yyparse();
    return 0;
}

