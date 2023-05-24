#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mylangcommon.h"

extern int yylex();
extern char* yytext;
extern int yylineno;
extern FILE* yyin;

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("fopen");
        return 1;
    }

