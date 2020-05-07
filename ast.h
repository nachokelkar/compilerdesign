
#pragma once

#include "header.h"

typedef union data
{
    Symbol *ptr;
    int num_const;
    char str_const[20];
} data;

typedef struct Node
{
    char type[20];
    union data value;
    // struct Node *left;
    // struct Node *right;

    int _numnodes;
    struct Node* ptrlist[10];
} Node;

#define NodePtrList Node * []

Node* make_node(char *type, data value, Node* *list, int len);
void display_subtree(Node *n);


    
