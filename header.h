
#pragma once
#define TABLE_SIZE 100

typedef struct 
{
    char type[20];
    char value[20];

    struct Node *nodeptr;
} yylval_t;

#define YYSTYPE yylval_t

enum type {NUMBER, STR};

typedef struct Symbol
{
    char sym[20];
    // enum type type;
    char dtype[100];
    char value[100];
    int lineno;
} Symbol;

extern Symbol table[TABLE_SIZE];
extern int lastSym;

int exists(char *sym);
void display_table(Symbol *_table, int n);
void installID(char *sym_name, int lineno);
void modifyID(char *symbol, char *dtype, char *value);
Symbol *getSymbol(char *sym);
