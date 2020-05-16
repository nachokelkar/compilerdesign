%{
    #define YYSTYPE char*
    extern YYSTYPE yylval;
    #include "y.tab.h"
    #include <stdio.h>
%}

%%

"start"                     {yylval = strdup(yytext);  return START;}
"stop"                      {yylval = strdup(yytext); return STOP;}
"L"[0-9]+                   {yylval = strdup(yytext);  return LABEL;}
"T"[0-9]+                   {yylval = strdup(yytext);  return TEMP;}
":"                         {yylval = strdup(yytext);  return COLON;}
"="                         {yylval = strdup(yytext); return EQUALS;}
"if"                        {yylval = strdup(yytext); return IF;}
"true"                      {yylval = strdup(yytext);  return TRUE;}
"false"                     {yylval = strdup(yytext);  return FALSE;}
"go to"                     {yylval = strdup(yytext);  return GOTO;}
[a-zA-Z_$][a-zA-Z_0-9$]*    {yylval = strdup(yytext);  return VAR;}
[0-9]+                      {yylval = strdup(yytext);  return NUM;}
"<"                         {yylval = strdup(yytext);  return LESSTHAN;}
">"                         {yylval = strdup(yytext); return GRTRTHAN;}
"+"                         {yylval = strdup(yytext); return ADD;}
"-"                         {yylval = strdup(yytext);  return SUB;}
"*"                         {yylval = strdup(yytext);  return MUL;}
"/"                         {yylval = strdup(yytext);  return DIV;}
"\n"                        {;}
" "                         {;}

%%

int yywrap()
{
	return 1;
}
