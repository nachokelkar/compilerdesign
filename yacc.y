%{
#include <stdio.h>
#include <stdlib.h>
int yyerror();
int yylex();
%}

%token RETURN SEMICOLON NUM VAR TRUE FALSE IF FOR IN OF ELSE STRING IDENTIFIER UNARYPLUS UNARYMINUS

%%

Program: Statement {YYACCEPT;};
Statement: IF '(' Condition ')' '{' Statement '}' ELSE '{' Statement '}' Statement |
	IF '(' Condition ')' '{' Statement '}' Statement |
	FOR '(' Initialisation SEMICOLON Condition SEMICOLON Expression ')' '{' Statement '}' Statement |
	FOR '(' InExpression ')' '{' Statement '}' |
	FOR '(' OfExpression ')' '{' Statement '}' |
	RETURN Expression SEMICOLON Statement |
	Declaration SEMICOLON Statement |
	AssignmentExpression SEMICOLON Statement |
	UnaryStatement SEMICOLON Statement | ;

Declaration: VAR Variables ; 

Variables: Variables ',' Variable |
	Variable ;

Variable: IDENTIFIER |
	AssignmentExpression ;

Condition: '!' OrExpression |
	OrExpression ;

OrExpression: OrExpression '|''|' AndExpression |
	AndExpression ;

AndExpression: AndExpression '&''&' ConditionalBase |
	ConditionalBase ;

ConditionalBase: '(' Condition ')' |
	RelationalExpression |
	TRUE |
	FALSE ;

RelationalExpression: RelationalExpression RelationalOperator Expression |
	Expression ;

RelationalOperator: '<' | '>' | '<''=' | '>''=' | '=''=' | '!''=' ;

Expression: Expression '+' MultDiv |
	Expression '-' MultDiv |
	MultDiv ;

MultDiv: MultDiv '*' ExponentialExpression |
	MultDiv '/' ExponentialExpression |
	ExponentialExpression ;

ExponentialExpression: UnaryPostExpression '^' ExponentialExpression |
	UnaryPostExpression ;

UnaryPostExpression: UnaryPreExpression UNARYPLUS |
	UnaryPreExpression UNARYMINUS |
	UnaryPreExpression ;

UnaryPreExpression: UNARYPLUS ExpressionBase |
	UNARYMINUS ExpressionBase |
	ExpressionBase ;

ExpressionBase:'(' Expression ')' |
	IDENTIFIER |
	NUM ;

UnaryStatement: IDENTIFIER UNARYPLUS |
	IDENTIFIER UNARYMINUS |
	UNARYPLUS IDENTIFIER |
	UNARYMINUS IDENTIFIER ;

Initialisation: AssignmentExpression | ;

AssignmentExpression: IDENTIFIER '=' AssignmentRHS ;

AssignmentRHS: RelationalExpression |
	Array |
	STRING;

InExpression: IDENTIFIER IN Iterable |
	IDENTIFIER IN IDENTIFIER ;

OfExpression: IDENTIFIER OF Iterable;

Iterable: Array | STRING | IDENTIFIER ;

Array: '[' Elements ']';

Elements: Elements ',' Element | Element;

Element: IDENTIFIER | NUM | STRING;

%%



int yyerror()
{
	printf("\nInvalid!\n");
	return 0;
}

int main()
{
	printf("Enter\n");
  if(!yyparse())
  {
      printf("\nValid!\n");
  }
  return 0;

}
