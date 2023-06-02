%{
#include <stdio.h>
#include "mylangcommon.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

void yyerror(const char* s) {
    fprintf(stderr, "Syntax Error in line %d: %s\n", yylineno, s);
}

%}

%token <sval> IDENTIFIER
%token <ival> INTEGER
%token <dval> DOUBLE
%token WRITE EXIT PAROPEN PARCLOSE ADD MULTIPLY SUBTRACT DIVIDE EQUALS SEMICOLON BOOLEAN FUNCTION CBOPEN CBCLOSE RETURN IF ELSEIF WHILE FOR ELSE LOWER GREATER AND OR

%left LOWER GREATER
%left ADD SUBTRACT
%left MULTIPLY DIVIDE
%left UMINUS

%union {
    int ival;
    double dval;
    char* sval;
}

%token <ival> NUMBER
%token <sval> STRING

%type <sval> program statement assignment function_declaration parameter_list control_structure if_statement while_statement for_statement expression logical_expression relational_expression arithmetic_expression term factor

%%

program : statement
        | program statement
        ;

statement : assignment SEMICOLON
          | function_declaration
          | control_structure
          | WRITE expression SEMICOLON
          | EXIT SEMICOLON
          ;

assignment : IDENTIFIER EQUALS expression
           ;

function_declaration : FUNCTION IDENTIFIER PAROPEN parameter_list PARCLOSE CBOPEN program CBCLOSE
                     ;

parameter_list : /* empty */
               | IDENTIFIER
               | parameter_list ',' IDENTIFIER
               ;

control_structure : if_statement
                  | if_statement ELSE control_structure
                  | while_statement
                  | for_statement
                  ;

if_statement : IF expression CBOPEN program CBCLOSE
             | IF expression CBOPEN program CBCLOSE ELSEIF expression CBOPEN program CBCLOSE
             | IF expression CBOPEN program CBCLOSE ELSE CBOPEN program CBCLOSE
             ;

while_statement : WHILE expression CBOPEN program CBCLOSE
                ;

for_statement : FOR assignment SEMICOLON expression SEMICOLON assignment CBOPEN program CBCLOSE
              ;

expression : logical_expression
           ;

logical_expression : relational_expression
                   | logical_expression AND logical_expression
                   | logical_expression OR logical_expression
                   ;

relational_expression : arithmetic_expression
                      | arithmetic_expression LOWER arithmetic_expression
                      | arithmetic_expression GREATER arithmetic_expression
                      ;

arithmetic_expression : term
                      | arithmetic_expression ADD term
                      | arithmetic_expression SUBTRACT term
                      ;

term : factor
     | term MULTIPLY factor
     | term DIVIDE factor
     ;

factor : IDENTIFIER
       | INTEGER
       | DOUBLE
       | PAROPEN expression PARCLOSE
       ;

%%

int main() {
    yyparse();
    return 0;
}
