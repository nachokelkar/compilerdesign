%{
#include <stdio.h>
#include <stdlib.h>
int yyerror();
int yylex();
%}

%token RETURN SEMICOLON NUM VAR TRUE FALSE IF FOR IN OF ELSE STRING IDENTIFIER UNARYPLUS UNARYMINUS

%%

Program: Statement {printf("Program -> Statement\n"); YYACCEPT;};
Statement: IF '(' Condition ')' '{' Statement '}' ELSE '{' Statement '}' Statement {printf("Statement -> if else\n");} |
	IF '(' Condition ')' '{' Statement '}' Statement {printf("Statement -> if\n");} |
	FOR '(' Initialisation SEMICOLON Condition SEMICOLON Expression ')' '{' Statement '}' Statement {printf("Statement -> for\n");} |
	FOR '(' InExpression ')' '{' Statement '}' Statement {printf("Statement -> for in\n");} |
	FOR '(' OfExpression ')' '{' Statement '}' Statement {printf("Statement -> for of\n");} |
	RETURN Expression SEMICOLON Statement {printf("Statement -> return\n");} |
	Declaration SEMICOLON Statement {printf("Statement -> Declaration\n");} |
	AssignmentExpression SEMICOLON Statement {printf("Statement -> Assignment\n");} | ;

Declaration: VAR Variables {printf("Declaration -> var variables\n");}; 

Variables: Variables ',' Variable {printf("Variables -> Comma\n");} |
	Variable {printf("Variables -> Variable\n");} ;

Variable: IDENTIFIER {printf("Variable -> Identifier\n");} |
	AssignmentExpression {printf("Variable -> AssignmentExp\n");} ;

Condition: '!' OrExpression {printf("Condition -> !OrExp\n");} |
	OrExpression {printf("Condition -> OrExp\n");} ;

OrExpression: OrExpression '|''|' AndExpression {printf("OrExp -> Or || And\n");} |
	AndExpression {printf("OrExp -> AndExp\n");} ;

AndExpression: AndExpression '&''&' ConditionalBase {printf("AndExp -> AndExp && ConditionalBase\n");} |
	ConditionalBase {printf("AndExp -> ConditionalBase\n");} ;

ConditionalBase: '(' Condition ')' {printf("ConditionalBase -> ( Condition) )\n");} |
	RelationalExpression {printf("ConditionalBase -> RelationalExpression\n");} |
	TRUE {printf("ConditionalBase -> TRUE\n");} |
	FALSE {printf("ConditionalBase -> FALSE\n");} ;

RelationalExpression: RelationalExpression RelationalOperator Expression {printf("RelExp -> RelExp RelOp Exp\n");} |
	Expression {printf("RelationalExpression -> Expression\n");} ;

RelationalOperator: '<' | '>' | '<''=' | '>''=' | '=''=' | '!''=' ;

Expression: Expression '+' MultDiv {printf("Exp -> Exp + MultDiv\n");} |
	Expression '-' MultDiv {printf("Exp -> Exp - MultDiv\n");} |
	MultDiv {printf("Exp -> MultDiv\n");} ;

MultDiv: MultDiv '*' ExponentialExpression {printf("MultDiv -> Exponential\n");} |
	MultDiv '/' ExponentialExpression {printf("MultDiv -> MultDiv / Exponential\n");} |
	ExponentialExpression {printf("MultDiv -> Exponential\n");};

ExponentialExpression: UnaryPostExpression '^' ExponentialExpression {printf("Exponential -> UnaryPost ^ Exponential\n");} |
	UnaryPostExpression {printf("Exponential -> UnaryPost\n");} ;

UnaryPostExpression: UnaryPreExpression UNARYPLUS {printf("UnaryPost -> UnaryPre ++\n");} |
	UnaryPreExpression UNARYMINUS {printf("UnaryPost -> UnaryPre --\n");} |
	UnaryPreExpression {printf("UnaryPost -> Unary\n");};

UnaryPreExpression: UNARYPLUS ExpressionBase {printf("UnaryPre -> ++ ExpBase\n");} |
	UNARYMINUS ExpressionBase {printf("UnaryPre -> -- ExpBase\n");} |
	ExpressionBase {printf("UnaryPre -> ExpBase\n");} ;

ExpressionBase:'(' Expression ')' {printf("ExpBase -> ( Expression )\n");} |
	IDENTIFIER {printf("ExpBase -> IDENTIFIER\n");} |
	NUM {printf("ExpBase -> NUM\n");};

Initialisation: AssignmentExpression {printf("Initialisation -> AssignmentExpression\n");} | ;

AssignmentExpression: IDENTIFIER '=' AssignmentRHS {printf("AssignmentExp -> IDENTIFIER '=' AssignmentRHS\n");};

AssignmentRHS: RelationalExpression {printf("AssignmentRHS -> RelExp\n");} | Array {printf("AssignmentExp -> Array\n");} ;

InExpression: IDENTIFIER IN Iterable;

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
