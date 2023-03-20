
#include<stdio.h>
#include "mylangcommon.h"

extern int yylex(); // It will return the tokens  1,2,3,4.... that corresponds to INTEGER, IDENTIFIER, etc.
extern int yylineno; //Current line number that our scanner is in
extern char* yytext; //is current actual lexeme

DEFINETOKENS

int main(void){
        int templineno=yylineno;
	int token=yylex();
	while(token){		printf("Token %s is seen on line %d is %s\n",text[token], yylineno, yytext);
		token=yylex();
	if(yylineno!=templineno){
		printf("\n");
 		templineno=yylineno;
	}
	}

	return 0; 
}
