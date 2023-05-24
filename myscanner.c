#include <stdio.h>
#include "mylangcommon.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

DEFINETOKENS

int main(void) {
    int templineno = yylineno;
    int token = yylex();
    
    while (token) {
        printf("Token %s is seen on line %d: %s\n", text[token], yylineno, yytext);
        token = yylex();
        
        if (yylineno != templineno) {
            printf("\n");
            templineno = yylineno;
        }
    }

    return 0;
}
