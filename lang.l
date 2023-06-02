%{
#include <stdio.h>
#include "mylangcommon.h"
%}

%%
WRITE                 return WRITE;
EXIT                  return EXIT;
\(                    return PAROPEN;
\)                    return PARCLOSE;
\+                    return ADD;
\*                    return MULTIPLY;
\-                    return SUBTRACT;
\/                    return DIVIDE;
\=                    return EQUALS;
if                    return IF;
elseif                return ELSEIF;
while                 return WHILE;
for                   return FOR;
else                  return ELSE;
\<                    return LOWER;
\>                    return GREATER;
\&\&                  return AND;
\|\|                  return OR;
true|false            return BOOLEAN;
func                  return FUNCTION;
\{                    return CBOPEN;
\}                    return CBCLOSE;
[-]?[a-zA-Z]+         return IDENTIFIER;
[-]?[0-9]+            return INTEGER;
[-]?[0-9]+\.[0-9]+    return DOUBLE;
[ \t]                 ;
\;                    return SEMICOLON;
\n                    { yylineno++; }
.                     printf("Error, unexpected character in line %d!\n", yylineno);
%%

int yywrap(void) {
    return 1;
}
