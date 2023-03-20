%{
#include "mylangcommon.h"
%}

%%
"WRITE"                return 5;
"EXIT"                 return 8;
"("                    return 6;
")"                    return 7;
"+"                    return 9;
"*"                    return 10;
"-"                    return 11;
"/"                    return 12;
"="                    return 4;

%%
int yywrap(void){
        return 1;

}
