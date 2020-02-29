%{
	#include <stdlib.h>
	#include <string.h>
	#include <stdio.h>
	FILE *yyin;
	int yyerror();
	int yylex();
	char* type;
	int err = 0;
	FILE* fp;
	typedef struct NODE
	{
	char name[10];
	int value;
	char type[10];
	int scope;
	struct NODE* next;
	}NODE;

	typedef struct symbol_table
	{
		NODE* head;
		int entries;
	}TABLE;
	TABLE* s;
	int scope = 0;

	void print();
	int exists(char* name);
	void scopered(int scope);
	void update(char* name, int val);
	void insert(char* name, int value, char* type) ;
	extern int yylineno;
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

Variable: IDENTIFIER {printf("Variable -> Identifier\n"); insert($1, 0)} |
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
	s = (TABLE *)malloc(sizeof(TABLE));
	s->head=NULL;
	s->entries=0;
	fp = fopen("symbol_table.txt","w");
	yyin = fopen(argv[1], "r");
	if(!yyparse())
	{
		print();
		printf("\nValid!\n");
	}
	return 0;
}


void insert(char* name, int value, char* type)
{
	if(exists(name))
	{
		printf("Variable %s already declared\n",name);
		err++;
		return;
	}
    	NODE* test = (NODE*) malloc(sizeof(NODE));
    	strcpy(test->name,name);
	test->value=value;
	test->next=NULL ;
	test->scope=scope;
	strcpy(test->type, type);

	NODE* h = s->head;

	if(h==NULL)
	{

		s->head=test;
		s->entries+=1;
		return;
	}
	while(h->next!=NULL)
	{
		h=h->next;
	}
	h->next=test;
	s->entries+=1;
}

int exists(char* name)
{
	NODE* temp = s->head;
	if(s->head == NULL)
		return 0;
	while(temp != NULL)
	{
		if(strcmp(temp->name,name) == 0 && temp->scope <= scope)
			return 1;
		temp = temp->next;
	}
	return 0;
}

void update(char* name, int val)
{
	NODE* temp = s->head;
	while(temp->next != NULL)
	{
		printf("%s %d %d\n",temp->name,temp->value,temp->scope);
		if(strcmp(temp->name,name) == 0){
		printf("%d\n",temp->value);
			temp->value = val;
			temp->scope=scope;
			return;
		}
		temp = temp->next;
	}
	
}

void print()
{
	NODE* h = s->head;
	fp = fopen("symbol_table.txt","w");
	fprintf(fp,"\nSymbol table \nName  Value  Type  Scope\n");
	for(int i=0;i<s->entries; i++ )
	{
		fprintf(fp,"%s     %d      %s   %d\n", h->name, h->value, h->type, h->scope);
		h=h->next;
	}
}
