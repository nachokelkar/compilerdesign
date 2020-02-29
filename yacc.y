%{
	#define YYSTYPE char*
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
		char name[20];
		int line;
		int scopeid;
		int scopedepth;
		struct NODE* next;
	}NODE;

	typedef struct symbol_table
	{
		NODE* head;
		int entries;
	}TABLE;
	
	TABLE *s;
	extern int scopeid;
	extern int scopedepth;

	void print(TABLE* s);
	void tableinit(TABLE *table);
	int exists(TABLE* s, char* name, int pscopeid);
	void insert(TABLE* s, char* name, int line, int pscopeid, int pscopedepth) ;
	extern int yylineno;
%}

%token RETURN SEMICOLON NUM VAR TRUE FALSE IF FOR IN OF ELSE STRING IDENTIFIER UNARYPLUS UNARYMINUS

%%

Program: Statement {YYACCEPT;};
Statement: IF '(' Condition ')' '{' Statement '}' ELSE '{' Statement '}' Statement |
	IF '(' Condition ')' '{' Statement '}' Statement |
	FOR '(' Initialisation SEMICOLON Condition SEMICOLON Expression ')' '{' Statement '}' Statement |
	FOR '(' InExpression ')' '{' Statement '}' Statement |
	FOR '(' OfExpression ')' '{' Statement '}' Statement |
	RETURN Expression SEMICOLON Statement |
	Declaration SEMICOLON Statement |
	AssignmentExpression SEMICOLON Statement | 
	UnaryExpression SEMICOLON Statement | ;

UnaryExpression: IDENTIFIER UNARYMINUS |
	IDENTIFIER UNARYPLUS |
	UNARYMINUS IDENTIFIER |
	UNARYPLUS IDENTIFIER ;

Declaration: VAR Variables ; 

Variables: Variables ',' Variable |
	Variable ;

Variable: IDENTIFIER {insert(s, $1, yylineno, scopeid, scopedepth);} |
	IDENTIFIER '=' AssignmentRHS {insert(s, $1, yylineno, scopeid, scopedepth);} ; 

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

Initialisation: AssignmentExpression | ;

AssignmentExpression: IDENTIFIER '=' AssignmentRHS ;

AssignmentRHS: RelationalExpression | Array ;

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
	tableinit(s);
	fp = fopen("symbol_table.txt","w");
	if(!yyparse())
	{
		printf("\nValid!\n");
		print(s);
	}
	return 0;
}

void tableinit(TABLE *table){
	table->head = NULL;
	table->entries = 0;
}

void insert(TABLE* s, char* name, int line, int pscopeid, int pscopedepth)
{
	if(exists(s, name, pscopeid))
	{
		printf("\n------------------\nWarning: Variable %s of scope ID %d already declared [Line: %d]\n------------------\n",name, pscopeid, line);
		//err++;
		return;
	}
	NODE* test = (NODE*) malloc(sizeof(NODE));
    strcpy(test->name,name);
	test->next = NULL;
	test->scopeid = pscopeid;
	test->scopedepth = pscopedepth;
	test->line = line;
	
	NODE* h = s->head;

	if(h==NULL)
	{
		s->head = test;
		s->entries += 1;
		return;
	}
	while(h->next != NULL)
	{
		h = h->next;
	}
	h->next = test;
	s->entries += 1;
}

int exists(TABLE* s, char* name, int pscopeid)
{
	NODE* temp = s->head;
	if(s->head == NULL || s->head == 0x0){
		return 0;
	}
	while(temp != NULL)
	{
		if(strcmp(temp->name,name) == 0 && temp->scopeid == pscopeid){
			return 1;
		}
		temp = temp->next;
	}
	return 0;
}

void print(TABLE* s)
{
	NODE* h = s->head;
	fp = fopen("symbol_table.txt","w");
	fprintf(fp,"Symbol table:\nName\t\tLineno\t\tScope ID\tScope Depth\n");
	for(int i=0;i<s->entries; i++ )
	{
		fprintf(fp,"%s\t\t\t%d\t\t\t%d\t\t\t%d\n", h->name, h->line, h->scopeid, h->scopedepth);
		h=h->next;
	}
}
