%{
    #define YYSTYPE char*
    #include <stdio.h>
    #include "y.tab.h"
    extern char* yylval;
    int yyerror();
	int maxscope= 0;
	int scopeid = 0;
	int scopedepth = 0;
    int yyerror();
    void addTokenToFile(char *t, char *s);
    int yylineno;
%}

%%
"\n"                        {yylineno++;}
for                         {return FOR;}
true                        {return TRUE;}
false                       {return FALSE;}
if                          {return IF;}
else                        {return ELSE;}
return                      {return RETURN;}
in                          {return IN;}
of                          {return OF;}
var                         {return VAR;}
[a-zA-Z_$][a-zA-Z_0-9$]*    {yylval=strdup(yytext); addTokenToFile("Identifier", yytext); return IDENTIFIER;}
[0-9]+                      {return NUM;}
;                           {return SEMICOLON;}
\".*\"                      {return STRING;}
"++"                        {return UNARYPLUS;}
"--"                        {return UNARYMINUS;}
[\t|' ']                    {;}
"//".*                      {;}
"/"\*[\n|.]*\*"/"           {}
"{"                         {scopeid=maxscope+1; scopedepth+=1; return yytext[0];}
"}"                         {scopeid-=1; scopedepth-=1; maxscope+=1; return yytext[0];}
\+                          {return yytext[0];}
.                           {return yytext[0];}
%%

void addTokenToFile(char *t, char *s)
{
   	FILE *fptr;
	fptr = fopen("tokens.txt", "w");
   	if(fptr == NULL)
   	{
	      printf("Error!");
	      exit(1);
   	}

   	fprintf(fptr,"%s : %s\n", t, s);
   	fclose(fptr);
}

int yywrap()
{
	return 1;
}