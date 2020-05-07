%option yylineno

%{
	#include <string.h>
	#include "header.h"
    #include "y.tab.h"


	Symbol table[TABLE_SIZE];
	int lastSym = -1;
%}

%%



"\n"                        ;
for                         {
				 return FOR;}
true                        {return TRUE;}
false                       { return FALSE;}
if                          { return IF;}
else                        {return ELSE;}
return                      {return RETURN;}
in                          { return IN;}
of                          {return OF;}
var                         { return VAR;}
"++"                        { return UNARYPLUS;}
"--"                        { return UNARYMINUS;}
[\t|' ']                    ;
"//".*                      ;
"/"\*[\n|.]*\*"/"           ;
"{"                         { return yytext[0];}
"}"                         { return yytext[0];}
[0-9]+                      {strcpy(yylval.type, "number");
				strcpy(yylval.value, yytext);
				return NUM;}
;                           { return SEMICOLON;}
\".*\"                      {strcpy(yylval.type, "string");
			strcpy(yylval.value, yytext);
  			return STRING; }
[a-zA-Z_$][a-zA-Z_0-9$]*    {installID(yytext, yylineno);			
				strcpy(yylval.value, yytext);
  				return IDENTIFIER;}
.                           { return yytext[0];}
        
%%

int yywrap() { return 1; }

int exists(char *sym)
{
    int flag=0;
    for(int i=0;i<TABLE_SIZE;i++){
        if(strcmp(sym,table[i].sym) == 0){
            flag=1;
            break;
        }
    }
    return flag;
}

Symbol *getSymbol(char *sym)
{
	for(int i=0;i<TABLE_SIZE;i++){
        if(strcmp(sym,table[i].sym) == 0){
            return &table[i];
        }
    }

	return NULL;
}

void installID(char *sym_name, int lineno)
{
	if(!exists(sym_name))
	{
		lastSym++;
		strcpy(table[lastSym].sym, sym_name);
		table[lastSym].lineno = lineno;
	}
}

void modifyID(char *symbol, char *dtype, char *value){
	for(int i=0; i<lastSym+1; i++){
		if(strcmp(symbol,table[i].sym)==0){
			strcpy(table[i].dtype, dtype);
			strcpy(table[i].value, value);
		}
	}
}


void display_table(Symbol *table, int n)                                            
{                                                                                   
    
    int i;                                                                          
    
    // printf("%-20s %-10s %-20s %-10s\n", "SYMBOL", "TYPE", "VALUE", "LINE NO.");   
	printf("\t\t\t%s\t%s\t%s\t\t%s\n",
           "SYMBOL", "TYPE", "VALUE", "LINE NO.");                               
    for (i = 0; i < n; i++) {
        char *sym = table[i].sym;                                                   
        /*
        char *type;
        switch (table[i].type) {                                                    
            case NUMBER:
                type = "NUMBER";                                                    
                break;
            case STRING:
                type = "STRING";                                                    
                break;                                                              
        }
        printf("%-20s %-10s %-20s %-10s\n",                                         
        sym, type, ad);                                                             
        */
        printf("%p\t\t%s\t%s\t%s\t\t%d\n",                                    
        &table[i], sym, table[i].dtype, table[i].value, table[i].lineno);                                              
    }                                                                               

}

/*
int main()
{

	int c;
	extern FILE *yyin;

	yyin = fopen("test.r", "r"); 
	// yylex();

	
	while(!feof(yyin))
	{
		yylex();
	} 

	display_table(table, lastSym+1);
} */
