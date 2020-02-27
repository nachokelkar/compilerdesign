%{

#include "y.tab.h"
    extern int yylval;
    int yyerror();
    int a = 1;
%}

%%
for {return FOR;}
true {return TRUE;}
false {return FALSE;}
if {return IF;}
else {return ELSE;}
return {return RETURN;}
in {return IN;}
of {return OF;}
var {return VAR;}
[a-zA-Z_$][a-zA-Z_0-9$]* {return IDENTIFIER;}
[0-9]+ {return NUM;}
; {return SEMICOLON;}
\".*\" {return STRING;}
[\t|' '] ;
(\n) {printf("%d\n", a++);}
"//".* {;}
"/"\*[\n|.]*\*"/" {;}
.	{return yytext[0];}
%%

int yywrap()
{
	return 1;
}