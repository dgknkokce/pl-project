%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mylangcommon.h"
extern int yylineno;
extern char* yytext;
%}
%option noyywrap

%%
[ \t]                   /* ignore whitespaces */
\n                      { yylineno++; }
"=="                    { return EQUALS; }
"="                     { return ASSIGNMENT; }
";"                     { return SEMICOLON; }
"+"                     { return ADD; }
"-"                     { return SUBTRACT; }
"*"                     { return MULTIPLY; }
"/"                     { return DIVIDE; }
"("                     { return PAROPEN; }
")"                     { return PARCLOSE; }
"{"                     { return CBOPEN; }
"}"                     { return CBCLOSE; }
"write"                 { return WRITE; }
"exit"                  { return EXIT; }
"if"                    { return IF; }
"else"                  { return ELSE; }
"elseif"                { return ELSEIF; }
"while"                 { return WHILE; }
"for"                   { return FOR; }
"return"                { return RETURN; }
"true"                  { return BOOLEAN; }
"false"                 { return BOOLEAN; }
[0-9]+                  { yylval.number = atoi(yytext); return INTEGER; }
[0-9]+"."[0-9]*         { yylval.decimal = atof(yytext); return DECIMAL; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.identifier = strdup(yytext); return IDENTIFIER; }
%%
