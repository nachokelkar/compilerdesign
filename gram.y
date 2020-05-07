
%{
    #include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include "header.h"
	#include "ast.h"

	int valid = 1;
	int yyerror();
	extern char * yytext;
%}


%token RETURN SEMICOLON NUM VAR TRUE FALSE IF FOR IN OF ELSE STRING IDENTIFIER UNARYPLUS UNARYMINUS 

%%

Program: Statement {	
			printf("hello");
			$$.nodeptr = make_node("BODY", (data) 0, (NodePtrList) {$1.nodeptr}, 1);
			display_subtree($$.nodeptr);YYACCEPT;};

Statement: IF '(' Condition ')' '{' Statement '}' ELSE '{' Statement '}' Statement { 	$1.nodeptr = make_node("IF-ELSE", (data) 0, (NodePtrList) {$3.nodeptr, $6.nodeptr, $10.nodeptr}, 3);
											$$.nodeptr = make_node("SEQ", (data) 0, (NodePtrList) {$1.nodeptr, $12.nodeptr}, 2);}|
	IF '(' Condition ')' '{' Statement '}' Statement { 	$1.nodeptr = make_node("IF", (data) 0, (NodePtrList) {$3.nodeptr, $6.nodeptr}, 2);
								$$.nodeptr = make_node("SEQ", (data) 0, (NodePtrList) {$1.nodeptr, $8.nodeptr}, 2);}|
	FOR '(' Initialisation SEMICOLON Condition SEMICOLON Expression ')' '{' Statement '}' Statement 
							{	$1.nodeptr = make_node("FOR", (data) 0, (NodePtrList) {$3.nodeptr, $5.nodeptr, $7.nodeptr,$10.nodeptr}, 4);
								$$.nodeptr = make_node("SEQ", (data) 0, (NodePtrList) {$1.nodeptr, $12.nodeptr}, 2);}|
	FOR '(' InExpression ')' '{' Statement '}' Statement { 	$1.nodeptr = make_node("FOR", (data) 0, (NodePtrList) {$3.nodeptr, $6.nodeptr}, 2);
								$$.nodeptr = make_node("SEQ", (data) 0, (NodePtrList) {$1.nodeptr, $8.nodeptr}, 2);}|
	FOR '(' OfExpression ')' '{' Statement '}' Statement { 	$1.nodeptr = make_node("FOR", (data) 0, (NodePtrList) {$3.nodeptr, $6.nodeptr}, 2);
								$$.nodeptr = make_node("SEQ", (data) 0, (NodePtrList) {$1.nodeptr, $8.nodeptr}, 2);}|
	RETURN Expression SEMICOLON Statement { $1.nodeptr = make_node("RETURN", (data) 0, (NodePtrList) {NULL}, 0);
						$$.nodeptr = make_node("SEQ", (data) 0, (NodePtrList) {$1.nodeptr,$2.nodeptr, $4.nodeptr}, 3);}|
	Declaration SEMICOLON Statement {	$$.nodeptr = make_node("SEQ", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);}|
	AssignmentExpression SEMICOLON Statement { $$.nodeptr = make_node("SEQ", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);}|
	UnaryExpression SEMICOLON Statement { $$.nodeptr = make_node("SEQ", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);}| 
	{$$.nodeptr = make_node("EMPTY", (data) 0, (NodePtrList) {NULL}, 0);};

UnaryExpression: IDENTIFIER UNARYMINUS { 	$2.nodeptr = make_node("--", (data) 0, (NodePtrList) {NULL}, 0);
						$1.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0);
						$$.nodeptr = make_node("UNARY_EXP", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);}|
	IDENTIFIER UNARYPLUS 		{ 	$2.nodeptr = make_node("++", (data) 0, (NodePtrList) {NULL}, 0);
						$1.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0);
						$$.nodeptr = make_node("UNARY_EXP", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);}|
	UNARYMINUS IDENTIFIER 		{ 	$1.nodeptr = make_node("--", (data) 0, (NodePtrList) {NULL}, 0);
						$2.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0);
						$$.nodeptr = make_node("UNARY_EXP", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);}|
	UNARYPLUS IDENTIFIER 		{ 	$1.nodeptr = make_node("++", (data) 0, (NodePtrList) {NULL}, 0);
						$2.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0);
						$$.nodeptr = make_node("UNARY_EXP", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);}|;

Declaration: VAR Variables { 			$1.nodeptr = make_node("VAR", (data) 0, (NodePtrList) {NULL}, 0);
						$$.nodeptr = make_node("DECLARATION", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);};

Variables: Variables ',' Variable { $$.nodeptr = make_node("VARIABLES", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);}|
	Variable { $$=$1;};

Variable: IDENTIFIER {$1.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0); 
			$$=$1;}|
	IDENTIFIER '=' AssignmentRHS {	printf("eq_assign: %s %s, SYMBOL: %s\n", $3.type, $3.value, $1.value); 
										modifyID($1.value, $3.type, $3.value); 
					$1.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0); 
					$$.nodeptr = make_node("=", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2); } ;

Condition: '!' OrExpression {	$1.nodeptr = make_node("!", (data) 0, (NodePtrList) {NULL}, 0); 
				$$.nodeptr = make_node("COND", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);}|
	OrExpression {	$$.nodeptr = make_node("COND", (data) 0, (NodePtrList) {$1.nodeptr}, 1);};

OrExpression: OrExpression '|''|' AndExpression {$$.nodeptr = make_node("||", (data) 0, (NodePtrList) {$1.nodeptr, $4.nodeptr}, 2);}|
	AndExpression {$$=$1;};

AndExpression: AndExpression '&''&' ConditionalBase {$$.nodeptr = make_node("&&", (data) 0, (NodePtrList) {$1.nodeptr, $4.nodeptr}, 2);}|
	ConditionalBase {$$=$1;};

ConditionalBase: '(' Condition ')' {$$=$2;}|
	RelationalExpression {$$=$1;}|
	TRUE {$$.nodeptr = make_node("TRUE", (data) 0, (NodePtrList) {NULL}, 0);}|
	FALSE {$$.nodeptr = make_node("FALSE", (data) 0, (NodePtrList) {NULL}, 0);};

RelationalExpression: RelationalExpression RelationalOperator Expression {sprintf($$.value, "%d", 0);
									$$.nodeptr = make_node($2.value, (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);} |
	Expression {$$=$1;} ;

RelationalOperator: '<' {strcpy($$.value,"<");}|
		'>' {strcpy($$.value,">");}| 
		'<''='{strcpy($$.value,"<=");} |
		 '>''='{strcpy($$.value,">=");} | 
		'=''=' {strcpy($$.value,"==");}| 
		'!''=' {strcpy($$.value,"!=");};

Expression: Expression '+' MultDiv {sprintf($$.value, "%d", atoi($1.value)+atoi($3.value));	$$.nodeptr = make_node("+", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);} |
	Expression '-' MultDiv {sprintf($$.value, "%d", atoi($1.value)-atoi($3.value));		$$.nodeptr = make_node("-", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);} |
	MultDiv {$$=$1;} ;

MultDiv: MultDiv '*' UnaryPostExpression {sprintf($$.value, "%d", atoi($1.value)*atoi($3.value));	$$.nodeptr = make_node("*", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);} |
	MultDiv '/' UnaryPostExpression {if(atoi($3.value)!=0){sprintf($$.value, "%d", atoi($1.value)/atoi($3.value));} else{printf("Divide by zero [Line ]\n"); yyerror();}
					$$.nodeptr = make_node("/", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);} |
	UnaryPostExpression {$$=$1;} ;

UnaryPostExpression: UnaryPreExpression UNARYPLUS {sprintf($$.value, "%d", atoi($1.value)+1); 
							$2.nodeptr = make_node("++", (data) 0, (NodePtrList) {NULL}, 0);
							$$.nodeptr = make_node("UNARY_POST", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);} |
	UnaryPreExpression UNARYMINUS {sprintf($$.value, "%d", atoi($1.value)-1); 
							$2.nodeptr = make_node("--", (data) 0, (NodePtrList) {NULL}, 0);
							$$.nodeptr = make_node("UNARY_POST", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);} |
	UnaryPreExpression {$$=$1;};

UnaryPreExpression: UNARYPLUS ExpressionBase {sprintf($$.value, "%d", atoi($2.value)+1); 
							$1.nodeptr = make_node("++", (data) 0, (NodePtrList) {NULL}, 0);
							$$.nodeptr = make_node("UNARY_PRE", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);} |
	UNARYMINUS ExpressionBase {sprintf($$.value, "%d", atoi($2.value)-1); 
							$2.nodeptr = make_node("--", (data) 0, (NodePtrList) {NULL}, 0);
							$$.nodeptr = make_node("UNARY_PRE", (data) 0, (NodePtrList) {$1.nodeptr, $2.nodeptr}, 2);} |
	ExpressionBase {$$=$1;} ;

ExpressionBase:'(' Expression ')' {$$=$2;} |
	IDENTIFIER {		$1.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0); $$=$1;} |
	NUM {	$1.nodeptr = make_node("NUM",(data) atoi($1.value), (NodePtrList) {NULL}, 0); $$=$1;} ;

Initialisation: AssignmentExpression {$$=$1;}| {$$.nodeptr = make_node("EMPTY", (data) 0, (NodePtrList) {NULL}, 0);};

AssignmentExpression: IDENTIFIER '=' AssignmentRHS {printf("eq_assign: %s %s, SYMBOL: %s\n", $3.type, $3.value, $1.value); 
										modifyID($1.value, $3.type, $3.value); 
					$1.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0); 
					$$.nodeptr = make_node("=", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2); } ;

AssignmentRHS: RelationalExpression {$$ = $1;} | Array {$$=$1;}| STRING {data temp_;
    			strcpy(temp_.str_const, $1.value);
			$1.nodeptr = make_node("STRING", temp_, (NodePtrList) {NULL}, 0);$$=$1;} ;

InExpression: IDENTIFIER IN Iterable{   $1.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0); 
					$$.nodeptr = make_node("IN", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);};

OfExpression: IDENTIFIER OF Iterable{   $1.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0); 
					$$.nodeptr = make_node("OF", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);};

Iterable: Array {$$=$1;}| STRING {$$=$1;}| IDENTIFIER {$$=$1;};

Array: '[' Elements ']'{ $$.nodeptr = make_node("ARRAY", (data) 0, (NodePtrList) {$2.nodeptr}, 1);};

Elements: Elements ',' Element { $$.nodeptr = make_node("ELEMENTS", (data) 0, (NodePtrList) {$1.nodeptr, $3.nodeptr}, 2);}| Element{$$=$1;};

Element: IDENTIFIER {	$1.nodeptr = make_node("ID", (data) getSymbol($1.value), (NodePtrList) {NULL}, 0); 
			$$=$1;}| 
	NUM 	{	$1.nodeptr = make_node("NUM",(data) atoi($1.value), (NodePtrList) {NULL}, 0);  
			$$=$1;}| 
	STRING  {	data temp_;
    			strcpy(temp_.str_const, $1.value);
			$1.nodeptr = make_node("STRING", temp_, (NodePtrList) {NULL}, 0);
			$$=$1;};

%%
#include <ctype.h>
int yyerror(const char *s)
{
    printf("Invalid program\n");
    valid = 0;
	extern int yylineno;
	printf("Line no: %d \n The error is: %s\n",yylineno,s);

	while(1)
	{
		int tok = yylex();
		// printf("Err: %d \n", tok);
		extern char * yytext;
		printf("Err: %s \n", yytext);
		if(tok == SEMICOLON)
			break;
	}
	yyparse();
    return 1;
}

int main()
{
    yyparse();

	if(valid)
	{
		printf("Valid program\n");
	}

	display_table(table, lastSym+1);

}
