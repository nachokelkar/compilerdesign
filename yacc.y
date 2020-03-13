%{
	#define YYSTYPE char*
	#include <stdlib.h>
	#include <string.h>
	#include <stdio.h>
	#include <math.h>
	FILE *yyin;
	int yyerror();
	int yylex();
	char* type;
	int err = 0;
	FILE* fp;
	
	typedef struct NODE
	{
		char name[20];
		int value;
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
	int getvalue(TABLE *s, char* name, int pscopeid);
	int exists(TABLE* s, char* name, int pscopeid);
	void update(TABLE *s, char* name, int pscopeid, int val);
	void insert(TABLE* s, char* name, int value, int line, int pscopeid, int pscopedepth) ;
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

Variable: IDENTIFIER {insert(s, $1, 0, yylineno, scopeid, scopedepth);} |
	IDENTIFIER '=' AssignmentRHS {insert(s, $1, atoi($3), yylineno, scopeid, scopedepth);} ; 

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

RelationalExpression: RelationalExpression RelationalOperator Expression {sprintf($$, "%d", 0);} |
	Expression {sprintf($$, "%s", $1);} ;

RelationalOperator: '<' | '>' | '<''=' | '>''=' | '=''=' | '!''=' ;

Expression: Expression '+' MultDiv {sprintf($$, "%d", atoi($1)+atoi($3));} |
	Expression '-' MultDiv {sprintf($$, "%d", atoi($1)-atoi($3));} |
	MultDiv {sprintf($$, "%s", $1);} ;

MultDiv: MultDiv '*' UnaryPostExpression {sprintf($$, "%d", atoi($1)*atoi($3));} |
	MultDiv '/' UnaryPostExpression {if(atoi($3)!=0){sprintf($$, "%d", atoi($1)/atoi($3));} else{printf("Divide by zero [Line %d]\n", yylineno); yyerror();}} |
	UnaryPostExpression {sprintf($$, "%s", $1);} ;

UnaryPostExpression: UnaryPreExpression UNARYPLUS {sprintf($$, "%d", atoi($1)+1);} |
	UnaryPreExpression UNARYMINUS {sprintf($$, "%d", atoi($1)-1);} |
	UnaryPreExpression {sprintf($$, "%s", $1);};

UnaryPreExpression: UNARYPLUS ExpressionBase {sprintf($$, "%d", atoi($2)+1);} |
	UNARYMINUS ExpressionBase {sprintf($$, "%d", atoi($2)-1);} |
	ExpressionBase {sprintf($$, "%s", $1);} ;

ExpressionBase:'(' Expression ')' {sprintf($$, "%s", $2);} |
	IDENTIFIER {sprintf($$,"%d", getvalue(s, $1, scopeid));} |
	NUM {sprintf($$, "%s", $1);} ;

Initialisation: AssignmentExpression | ;

AssignmentExpression: IDENTIFIER '=' AssignmentRHS {if(exists(s, $1, scopeid)){update(s, $1, scopeid, atoi($3));} else{insert(s, $1, atoi($3), yylineno, scopeid, scopedepth);}} ;

AssignmentRHS: RelationalExpression {$$ = $1;} | Array | STRING ;

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

void insert(TABLE* s, char* name, int value, int line, int pscopeid, int pscopedepth)
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
	test->value = value;
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
		if(strcmp(temp->name,name) == 0 && (temp->scopeid == pscopeid || temp->scopeid == 0)){
			return 1;
		}
		temp = temp->next;
	}
	return 0;
}

int getvalue(TABLE* s, char* name, int pscopeid)
{
	NODE* temp = s->head;
	if(s->head == NULL || s->head == 0x0){
		return 0;
	}
	while(temp != NULL)
	{
		if(strcmp(temp->name,name) == 0 && (temp->scopeid == pscopeid || temp->scopeid == 0)){
			return temp->value;
		}
		temp = temp->next;
	}
	return 0;
}

void update(TABLE* s, char* name, int pscopeid, int val)
{
	NODE* temp = s->head;
	if(s->head == NULL || s->head == 0x0){
	}
	while(temp != NULL)
	{
		if(strcmp(temp->name,name) == 0 && (temp->scopeid == pscopeid || temp->scopeid == 0)){
			temp->value = val;
		}
		temp = temp->next;
	}
}

void print(TABLE* s)
{
	NODE* h = s->head;
	fp = fopen("symbol_table.txt","w");
	fprintf(fp,"Symbol table:\nName\t\tLineno\t\tScope ID\tScope Depth\t\tValue\n");
	for(int i=0;i<s->entries; i++ )
	{
		fprintf(fp,"%s\t\t\t%d\t\t\t%d\t\t\t%d\t\t\t\t%d\n", h->name, h->line, h->scopeid, h->scopedepth, h->value);
		h=h->next;
	}
}
