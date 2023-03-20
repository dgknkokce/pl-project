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
if                     return 19;
elseif                 return 20;
while                  return 21;
for                    return 22;
else                   return 23;

%%
int yywrap(void){
        return 1;

}
