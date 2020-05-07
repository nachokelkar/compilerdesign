#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

Node* make_node(char *type, data value, Node* *list, int len)
{
    Node *temp = (Node *) malloc(sizeof(Node));
    strcpy(temp->type, type);
    temp->value = value;

    for (int i = 0; i < len; i++)
    {
        temp->ptrlist[i] = list[i];
    }
    

    temp->_numnodes = len;

    return temp;
}

void disp_node_details(Node *n)
{
    printf("\n----------------------------\n");
    printf("Node Type: %s\t", n->type);
    printf("Node Child Count: %d\t", n->_numnodes);
    printf("Node Data: ");
    if(strcmp(n->type, "NUM") == 0)
    {
        printf("%d\n", n->value.num_const);
    }
    else if(strcmp(n->type, "STRING") == 0)
    {
        printf("%s\n", n->value.str_const);
    }
    else if(strcmp(n->type, "ID") == 0)
    {
        printf("%p\n", n->value.ptr);
    }
    printf("\n----------------------------\n");
}

void display_subtree(Node *n)
{
    if(n != NULL)
    {
        disp_node_details(n);
        for (int i = 0; i < n->_numnodes; i++)
        {
            display_subtree(n->ptrlist[i]);
        }
        
    }
}
