%{
    #define YYSTYPE char*
    #include <stdio.h>
    #include "y.tab.h"
    extern YYSTYPE yylval;
    int yyerror();
	int maxscope= 0;
	char *p;
	int scopeid = 0;
	int scopedepth = 0;
    int yyerror();
    void addTokenToFile(char *t, char *s);
    int yylineno;
%}

%%
"\n"                        {yylineno++;}
for                         {printf("FOR\n"); return FOR;}
true                        {printf("TRUE\n"); return TRUE;}
false                       {printf("FALSE\n"); return FALSE;}
if                          {printf("IF\n"); return IF;}
else                        {printf("ELSE\n"); return ELSE;}
return                      {printf("RETURN\n"); return RETURN;}
in                          {printf("IN\n"); return IN;}
of                          {printf("OF\n"); return OF;}
var                         {printf("VAR\n"); return VAR;}
[a-zA-Z_$][a-zA-Z_0-9$]*    {printf("IDENTIFIER: %s\n", yytext); p=(char *)calloc(strlen(yytext)+1,sizeof(char)); strcpy(p, yytext); yylval=p; addTokenToFile("Identifier", yytext); return IDENTIFIER;}
[0-9]+                      {printf("NUMBER: %s\n", yytext); return NUM;}
;                           {printf("SEMICOLON\n\n"); return SEMICOLON;}
\".*\"                      {printf("STRING: %s\n", yytext); return STRING;}
"++"                        {printf("UNARYPLUS\n"); return UNARYPLUS;}
"--"                        {printf("UNARYMINUS\n"); return UNARYMINUS;}
[\t|' ']                    {;}
"//".*                      {;}
"/"\*[\n|.]*\*"/"           {;}
"{"                         {printf("{\n"); scopeid=maxscope+1; scopedepth+=1; return yytext[0];}
"}"                         {printf("}\n"); scopedepth-=1; if(scopedepth == 0){scopeid = 0;} maxscope+=1; return yytext[0];}
.                           {printf("%s\n", yytext); return yytext[0];}
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