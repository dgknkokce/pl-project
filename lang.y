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

%token IDENTIFIER INTEGER DOUBLE EQUALS WRITE PAROPEN PARCLOSE EXIT ADD MULTIPLY SUBTRACT DIVIDE SEMICOLON BOOLEAN FUNCTION CBOPEN CBCLOSE RETURN IF ELSEIF WHILE FOR ELSE LOWER GREATER AND OR

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