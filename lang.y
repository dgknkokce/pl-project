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
