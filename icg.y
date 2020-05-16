%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "header.c"
	void yyerror(const char *);
	#define YYSTYPE YACC
	FILE *yyin;
	int yylex();
	FILE* fp;
	int ln = 1, tn = 1;
	char* newLabel();
	char* newTemp();
	char* cont;
	char* br;
	char* sw;
	char* snxt;
	char* swt;
	char* tru;
	char* fals;
	extern int line;
%}
%error-verbose
%expect 1
%token RETURN SEMICOLON NUM VAR TRUE FALSE IF FOR ELSE STRING IDENTIFIER UNARYPLUS UNARYMINUS OROR ANDAND

%%

Program: Statement {YYACCEPT;};

Statement: IF '(' { $1.tr = newLabel(); $1.fal = newLabel(); $1.next = newLabel();  tru = $1.tr; fals = $1.fal;} Condition {fprintf(fp," go to %s \n",$1.tr); fprintf(fp,"go to %s \n%s:",$1.fal,$1.tr);} ')' '{' Statement '}'{ fprintf(fp,"go to %s\n%s:",$1.next,$1.fal); } ELSE '{' Statement '}' {fprintf(fp,"%s:",$1.next);}Statement|
	FOR '(' Initialisation SEMICOLON {$1.next = newLabel();  $1.tr = newLabel(); $1.fal = newLabel();  fprintf(fp,"%s:",$1.next); tru = $1.tr; fals = $1.fal;}Condition SEMICOLON {fprintf(fp," go to %s \n",$1.tr); fprintf(fp,"go to %s \n%s:",$1.fal,$1.tr);} ForExpression ')' '{' Statement '}'{ fprintf(fp,"go to %s\n%s:",$1.next,$1.fal); } Statement |
	RETURN Expression SEMICOLON Statement |
	Declaration SEMICOLON Statement |
	AssignmentExpression SEMICOLON  Statement |
	UnaryExpression SEMICOLON Statement |;

ForExpression: UnaryExpression | AssignmentExpression{$$.v=$1.v;};

UnaryExpression: IDENTIFIER UNARYMINUS {$$.v = newTemp(); $$.a = newTemp(); fprintf(fp,"%s = %s\n",$$.v,$1.v); fprintf(fp,"%s = %s - 1\n",$$.a,$1.v); fprintf(fp,"%s = %s\n",$1.v,$$.a);}|
	IDENTIFIER UNARYPLUS {$$.v = newTemp(); $$.a = newTemp(); fprintf(fp,"%s = %s\n",$$.v,$1.v); fprintf(fp,"%s = %s + 1\n",$$.a,$1.v); fprintf(fp,"%s = %s\n",$1.v,$$.a);}|
	UNARYMINUS IDENTIFIER {$$.v = newTemp(); fprintf(fp,"%s = %s - 1\n",$$.v,$2.v); fprintf(fp,"%s = %s\n",$2.v,$$.v);}	|
	UNARYPLUS IDENTIFIER {$$.v = newTemp(); fprintf(fp,"%s = %s + 1\n",$$.v,$2.v); fprintf(fp,"%s = %s\n",$2.v,$$.v);}	;

Declaration: VAR Variables;

Variables: Variables ',' Variable |
	Variable ;

Variable: IDENTIFIER |
	IDENTIFIER '=' AssignmentRHS {fprintf(fp,"%s = %s\n",$1.v,$3.v);} ;

Condition: '!' OrExpression {$$.v = newTemp(); fprintf(fp,"%s = ! %s\n",$$.v,$2.v);}|
	OrExpression ;

OrExpression: OrExpression OROR AndExpression {$2.a = newLabel(); fprintf(fp," go to to%s\ngo to to %s\n%s:",tru,$2.a,$2.a);}|
	AndExpression ;

AndExpression: AndExpression ANDAND ConditionalBase {$2.a = newLabel(); fprintf(fp," go to to%s\ngo to to %s\n%s:",$2.a,fals,$2.a);}|
	ConditionalBase;

ConditionalBase: '(' Condition ')' |
	RelationalExpression |
	TRUE {fprintf(fp,"if %s",$1.v);}|
	FALSE {fprintf(fp,"if %s",$1.v);};

RelationalExpression: RelationalExpression RelationalOperator Expression {$1.a = newTemp(); fprintf(fp,"%s = %s %s %s\n",$1.a,$1.v,$2.v,$3.v); fprintf(fp,"if %s",$1.a);} |
	Expression {$$.v = $1.v;} ;

RelationalOperator: '<' {$$.v="<";}|
		'>' {$$.v=">";}| 
		'<''='{$$.v="<=";} |
		 '>''='{$$.v=">=";}| 
		'=''=' {$$.v="==";}| 
		'!''=' {$$.v="!=";};

Expression: Expression '+' MultDiv  { $$.v = newTemp(); fprintf(fp,"%s = %s + %s\n",$$.v,$1.v,$3.v); }|
	Expression '-' MultDiv  {$$.v = newTemp(); fprintf(fp,"%s = %s - %s\n",$$.v,$1.v,$3.v); }|
	MultDiv;

MultDiv: MultDiv '*' UnaryPostExpression {$$.v = newTemp(); fprintf(fp,"%s = %s * %s\n",$$.v,$1.v,$3.v); } |
	MultDiv '/' UnaryPostExpression {$$.v = newTemp(); fprintf(fp,"%s = %s / %s\n",$$.v,$1.v,$3.v); } |
	UnaryPostExpression  ;

UnaryPostExpression: UnaryPreExpression UNARYPLUS {$$.v = newTemp(); $$.a = newTemp(); fprintf(fp,"%s = %s\n",$$.v,$1.v); fprintf(fp,"%s = %s + 1\n",$$.a,$1.v); fprintf(fp,"%s = %s\n",$1.v,$$.a);}|
	UnaryPreExpression UNARYMINUS {$$.v = newTemp(); $$.a = newTemp(); fprintf(fp,"%s = %s\n",$$.v,$1.v); fprintf(fp,"%s = %s - 1\n",$$.a,$1.v); fprintf(fp,"%s = %s\n",$1.v,$$.a);} |
	UnaryPreExpression  ;

UnaryPreExpression: UNARYPLUS ExpressionBase {$$.v = newTemp(); fprintf(fp,"%s = %s + 1\n",$$.v,$2.v); fprintf(fp,"%s = %s\n",$2.v,$$.v);}	 |
	UNARYMINUS ExpressionBase {$$.v = newTemp(); fprintf(fp,"%s = %s - 1\n",$$.v,$2.v); fprintf(fp,"%s = %s\n",$2.v,$$.v);}	 |
	ExpressionBase  ;

ExpressionBase:'(' Expression ')' {$$.v = $2.v;} |
	IDENTIFIER |
	NUM ;

Initialisation: AssignmentExpression | VAR AssignmentExpression | ;

AssignmentExpression: IDENTIFIER '=' AssignmentRHS {fprintf(fp,"%s =%s\n",$1.v,$3.v);} ;

AssignmentRHS: RelationalExpression | STRING ;


%%
void yyerror(const char *s)
{
	printf("%s", s);
}
int main(int argc, char* argv[])
{
	fp = fopen("icg.txt","w");
	fprintf(fp,"start\n");
	cont = (char*)malloc(sizeof(char)*10);
	br = (char*)malloc(sizeof(char)*10);
	sw = (char*)malloc(sizeof(char)*10);
	snxt = (char*)malloc(sizeof(char)*10);
	swt = (char*)malloc(sizeof(char)*10);
	tru = (char*)malloc(sizeof(char)*10);
	fals = (char*)malloc(sizeof(char)*10);
	yyin = fopen(argv[1], "r"); 
	if(!yyparse())
	{
		fprintf(fp,"stop\n");
		printf("Parsing successful \n");
	}
	else
		printf("Unsuccessful \n");
	return 0;

	//start

}

char* newLabel()
{
	char *s = (char*)malloc(4*sizeof(char));
	sprintf(s,"L%d",ln);
	ln++;
	return s;
}

char* newTemp()
{
	char *s = (char*)malloc(4*sizeof(char));
	sprintf(s,"T%d",tn);
	tn++;
	return s;
}
