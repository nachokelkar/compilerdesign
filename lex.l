%{

#include "y.tab.h"
    extern int yylval;
    int yyerror();
    int a = 1;
%}

%%
(\n) {a++;}
for {printf("TOKEN: FOR\n"); return FOR;}
true {printf("TOKEN: TRUE\n"); return TRUE;}
false {printf("TOKEN: FALSE\n"); return FALSE;}
if {printf("TOKEN: IF\n"); return IF;}
else {printf("TOKEN: ELSE\n"); return ELSE;}
return {printf("TOKEN: RETURN\n"); return RETURN;}
in {printf("TOKEN: IN\n"); return IN;}
of {printf("TOKEN: OF\n"); return OF;}
var {printf("TOKEN: VAR\n"); return VAR;}
[a-zA-Z_$][a-zA-Z_0-9$]* {printf("TOKEN: IDENTIFIER %s\n", yytext); return IDENTIFIER;}
[0-9]+ {printf("TOKEN: NUM %s\n", yytext); return NUM;}
; {printf("TOKEN: SEMICOLON\n"); return SEMICOLON;}
\".*\" {printf("TOKEN: STRING %s\n", yytext); return STRING;}
"++" {printf("TOKEN: UNARYPLUS\n"); return UNARYPLUS;}
"--" {printf("TOKEN: UNARYMINUS\n"); return UNARYMINUS;}
[\t|' '] ;
"//".* {printf("SINGLE LINE COMMENT: %s\n", yytext);}
"/"\*[\n|.]*\*"/" {printf("MULTI LINE COMMENT: %s\n", yytext);}
\+	{printf("TOKEN: %s\n", yytext); return yytext[0];}
. {printf("TOKEN: %s\n", yytext); return yytext[0];}
%%

int yywrap()
{
	return 1;
}