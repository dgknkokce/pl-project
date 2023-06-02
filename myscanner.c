#include <stdio.h>
#include "mylangcommon.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

int main(void) {
    int token;
    int templineno = yylineno;

    token = yylex();
    while (token) {
        printf("Token %d is seen on line %d: %s\n", token, yylineno, yytext);
        token = yylex();

        if (yylineno != templineno) {
            printf("\n");
            templineno = yylineno;
        }
    }

    return 0;
}
