%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mylangcommon.h"
extern int yylex();
extern int yylineno;
extern char* yytext;
void yyerror(char*);
%}

%token IDENTIFIER INTEGER DOUBLE EQUALS WRITE PAROPEN PARCLOSE EXIT ADD MULTIPLY SUBTRACT DIVIDE SEMICOLON BOOLEAN FUNCTION CBOPEN CBCLOSE RETURN IF ELSEIF WHILE FOR ELSE LOWER GREATER

%%

program : statements
        ;

statements : statement SEMICOLON
           | statements statement SEMICOLON
           ;

statement : assignment
          | write_statement
          | exit_statement
          | conditional_statement
          | loop_statement
          | function_declaration
          | return_statement
          ;

assignment : IDENTIFIER EQUALS expression
           ;

expression : term
           | expression ADD term
           | expression SUBTRACT term
           ;

term : factor
     | term MULTIPLY factor
     | term DIVIDE factor
     ;

factor : value
       | SUBTRACT value
       ;

value : INTEGER
      | DOUBLE
      | boolean_value
      | IDENTIFIER
      | function_call
      | PAROPEN expression PARCLOSE
      ;

boolean_value : BOOLEAN
              ;

function_call : FUNCTION PAROPEN argument_list PARCLOSE
              ;

argument_list : expression
              | argument_list ADD expression
              ;

write_statement : WRITE value
                ;

exit_statement : EXIT
               ;

conditional_statement : if_statement
                      | if_else_statement
                      | if_elseif_else_statement
                      ;

if_statement : IF PAROPEN expression PARCLOSE CBOPEN statements CBCLOSE
             ;

if_else_statement : IF PAROPEN expression PARCLOSE CBOPEN statements CBCLOSE ELSE CBOPEN statements CBCLOSE
                  ;

if_elseif_else_statement : IF PAROPEN expression PARCLOSE CBOPEN statements CBCLOSE elseif_list else_part
                          ;

elseif_list : ELSEIF PAROPEN expression PARCLOSE CBOPEN statements CBCLOSE
            | elseif_list ELSEIF PAROPEN expression PARCLOSE CBOPEN statements CBCLOSE
            ;

else_part : ELSE CBOPEN statements CBCLOSE
          ;

loop_statement : while_statement
               | for_statement
               ;

while_statement : WHILE PAROPEN expression PARCLOSE CBOPEN statements CBCLOSE
                ;

for_statement : FOR PAROPEN assignment SEMICOLON expression SEMICOLON assignment PARCLOSE CBOPEN statements CBCLOSE
              ;

function_declaration : FUNCTION IDENTIFIER PAROPEN parameter_list PARCLOSE CBOPEN statements CBCLOSE
                     ;

parameter_list : /* empty */
               | parameter
               | parameter_list COMMA parameter
               ;

parameter : IDENTIFIER
          ;

return_statement : RETURN value
                 ;

%%

void yyerror(char* s) {
    fprintf(stderr, "Error: %s at line %d near token %s\n", s, yylineno, yytext);
    exit(1);
}

int main(void) {
    int token = yyparse();
    return 0;
}
