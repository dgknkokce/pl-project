%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mylangcommon.h"
%}

%token IDENTIFIER INTEGER DOUBLE EQUALS WRITE PAROPEN PARCLOSE EXIT ADD MULTIPLY SUBTRACT DIVIDE SEMICOLON BOOLEAN FUNCTION CBOPEN CBCLOSE RETURN IF ELSEIF WHILE FOR ELSE LOWER GREATER

%left ADD SUBTRACT
%left MULTIPLY DIVIDE
%right UMINUS

%union {
    char* name;
    int value;
    double fvalue;
}

%token<name> ID
%token<value> NUM
%token<fvalue> FNUM

%%

program: statement_list
        | /* empty */ ;

statement_list: statement_list statement
              | statement ;

statement: assignment_statement ';' {printf("Assignment statement\n");}
         | write_statement ';' {printf("Write statement\n");}
         | if_statement {printf("If statement\n");}
         | while_statement {printf("While statement\n");}
         | for_statement {printf("For statement\n");}
         | func_declaration {printf("Function declaration\n");}
         | expression_statement ';' {printf("Expression statement\n");}
         | return_statement ';' {printf("Return statement\n");}
         | EXIT {printf("Exit statement\n"); exit(0);}
         ;
 
 
 
assignment_statement: ID EQUALS expression {$$ = $3; printf("Assigning value to %s\n", $1);} ;

write_statement: WRITE expression {printf("Writing: %f\n", $2);} ;

if_statement: IF PAROPEN expression PARCLOSE CBOPEN statement_list CBCLOSE elseif_statement_opt else_statement_opt
             | IF PAROPEN expression PARCLOSE CBOPEN statement_list CBCLOSE elseif_statement_opt
             | IF PAROPEN expression PARCLOSE CBOPEN statement_list CBCLOSE else_statement_opt
             ;

elseif_statement_opt: /* empty */
                     | elseif_statement ;

elseif_statement: ELSEIF PAROPEN expression PARCLOSE CBOPEN statement_list CBCLOSE elseif_statement_opt
                 ;

else_statement_opt: /* empty */
                  | ELSE CBOPEN statement_list CBCLOSE
                  ;

while_statement: WHILE PAROPEN expression PARCLOSE CBOPEN statement_list CBCLOSE {printf("While loop\n");} ;

for_statement: FOR PAROPEN assignment_statement SEMICOLON expression SEMICOLON expression PARCLOSE CBOPEN statement_list CBCLOSE {printf("For loop\n");} ;

func_declaration: FUNCTION ID PAROPEN PARCLOSE CBOPEN statement_list CBCLOSE {printf("Function declared: %s\n", $2);} ;

return_statement: RETURN expression {printf("Returning value %f\n", $2);} ;

expression_statement: expression ;
