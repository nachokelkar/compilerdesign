%{
	#include "header.c"
	#define YYSTYPE YACC
	#include "y.tab.h"
    #include <stdio.h>
    extern void yyerror(const char *);
    int fg = 0;
    int line = 1;
%}

%%
"\n"                        {line++;}
for                         {if(fg == 0){yylval.v=strdup(yytext); return FOR;}}
true                        {if(fg == 0){yylval.v=strdup(yytext); return TRUE;}}
false                       {if(fg == 0){yylval.v=strdup(yytext); return FALSE;}}
if                          {if(fg == 0){yylval.v=strdup(yytext); return IF;}}
else                        {if(fg == 0){yylval.v=strdup(yytext); return ELSE;}}
return                      {if(fg == 0){yylval.v=strdup(yytext); return RETURN;}}
"||"				{if(fg == 0){yylval.v=strdup(yytext); return OROR;}}
"&&"				{if(fg == 0){yylval.v=strdup(yytext); return ANDAND;}}
var                         {if(fg == 0){yylval.v=strdup(yytext); return VAR;}}
"++"                        {if(fg == 0){yylval.v=strdup(yytext); return UNARYPLUS;}}
"--"                        {if(fg == 0){yylval.v=strdup(yytext); return UNARYMINUS;}}
"{"         {if(fg == 0){yylval.v=strdup(yytext);  return *yytext;}}
"}"         {if(fg == 0){yylval.v=strdup(yytext);  return *yytext;}}
"["         {if(fg == 0){yylval.v=strdup(yytext);  return *yytext;}}
"]"         {if(fg == 0){yylval.v=strdup(yytext);  return *yytext;}}
[a-zA-Z_$][a-zA-Z_0-9$]*    {if(fg == 0) {yylval.v=strdup(yytext); return IDENTIFIER;}}
[0-9]+                      {if(fg == 0){yylval.v=strdup(yytext); return NUM;}}
;                           {if(fg == 0){yylval.v=strdup(yytext); return SEMICOLON;}}
\".*\"                      {if(fg == 0){yylval.v=strdup(yytext); return STRING;}}
"//".*                      ;
"/"\*[\n|.]*\*"/"           ;
[\t|' ']                    ;
.                           {return yytext[0];}
%%

int yywrap()
{
	return 1;
}