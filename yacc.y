%{
    #define YYSTYPE char*
    #include <stdlib.h>
    #include <string.h>
    #include <stdio.h>
    FILE* fp;
    int yylex();
    void yyerror(const char *);

    typedef struct Qnode{
        struct Qnode *next, *prev;
        int regIndex;
    } node;

    typedef struct regQ{
        node *front, *rear;
        int count;
    } Q;

    typedef struct hash{
        char* value; 
    } hashNode;

    node* newQNode(int regIndex){
        node* temp = (node*)malloc(sizeof(node));
        temp->next = temp->prev = NULL;
        temp->regIndex = regIndex;
        return temp;
    }

    Q* createQueue(){
        Q* q = (Q*)malloc(sizeof(Q));
        q->count = 0;
        q->front = q->rear = NULL;
        return q;
    }

    int deQueue(Q* q){
        node *temp = q->front;
        int regIndex = temp->regIndex;
        q->front = temp->next;
        q->count--;
        free(temp);
        return regIndex-1;
    }

    void hit(Q* q, int index){
        node* p = q->front;
        int pos = 0;
        while(pos!=index){
            p = p->next;
            pos++;
        }
        node *prev_node = p->prev;
        node *next_node = p->next;
        if (prev_node) prev_node->next = next_node;
        next_node->prev = prev_node;
        if(index == 0) q->front = next_node;
        p->prev = q->rear;
        q->rear->next = p;
        q->rear = p;
        p->next = NULL;
    }

    void enQueue(Q* q, int regIndex){
        node *p = (node*)malloc(sizeof(node));
        p->regIndex = regIndex;
        if(q->rear == NULL && q->front == NULL){
            p->prev = NULL;
            p->next = NULL;
            q->front = p;
            q->rear = p;
        }
        else {
            q->rear->next = p;
            p->prev = q->rear;
            q->rear = p;
            p->next = NULL;
        }
        q->count++;
    }

    int returnRegIndexFromHash(hashNode** H, char* value){
        for(int i = 0; i<14; i++){
            if(H[i]) {
                if( strcmp(value, H[i]->value)==0) return i+1;
            }
        }
        return -1;
    }

    int returnFirstFreeIndex(hashNode** H){
        int pos = -1, i = 0, found = 0;
        while(i<14 && !found){
            if(H[i] == NULL){
                found = 1;
                pos = i+1;
            } 
            i++;
        }
        return pos;
    }

    void display(Q* q, hashNode** H){
        node* p = q->front;
        int pos = 0;
        fprintf(fp,"Q - ");
        while(pos < q->count){
            fprintf(fp,"R%d ", p->regIndex);
            pos++;
            p = p->next;
        }
        fprintf(fp,"\n");
        fprintf(fp,"R - ");
        for(int i = 0; i<14; i++){
            if(H[i]) fprintf(fp,"%s ", H[i]->value);
            else fprintf(fp,"boo ");
        }
        fprintf(fp,"\n\n");
    }

    int reference(Q* q, char* value, hashNode** H){
        //fprintf(fp,"%s being referenced\n", value);
        int index = returnRegIndexFromHash(H, value);
        int reg = 0;
        if(index == -1){
            int regIndex = returnFirstFreeIndex(H);
            if(regIndex == -1){
                int freeRegister = deQueue(q);
                H[freeRegister]->value = value;
                enQueue(q, freeRegister+1);
                reg = freeRegister+1;
            }
            else{
                if(!H[regIndex-1]) H[regIndex-1] = (hashNode*)malloc(sizeof(hashNode));
                H[regIndex-1]->value = value;
                enQueue(q, regIndex);
                reg = regIndex;
            }
        }
        else{
            int pos = 0;
            node* p = q->front;
            while(pos < q->count && p->regIndex!=index){
                pos+=1;
                p = p->next;
            }
            if(pos != q->count-1) hit(q, pos);
            reg = index;
        }
        //fprintf(fp,"Value stored in R%d\n", reg);
        //display(q, H);
        return reg;
    }

    int checkPage(hashNode** H, char* value){
        for(int i = 0; i<14; i++){
            if(H[i] && strcmp(H[i]->value, value)==0){
                return 1;
            }
        }
        return 0;
    }
    
    int ln = 1;
    char* newLabel()
    {
        char *s = (char*)malloc(4*sizeof(char));
        sprintf(s,"Label%d",ln);
        ln++;
        return s;
    }

    hashNode** initialize_hash(){
        hashNode **H = (hashNode**)malloc(sizeof(hashNode*)*14);
        for(int i = 0; i<14; i++){
          H[i] = NULL;
        } 
        return H;
    }

    hashNode **H;
    Q* q;

%}

%token START STOP LABEL COLON TEMP EQUALS IF TRUE FALSE GOTO VAR NUM LESSTHAN GRTRTHAN ADD SUB MUL DIV

%%

Program: START Statement STOP {YYACCEPT; };

Statement: LABEL COLON {fprintf(fp,"%s: ", $1);} Statement |
           GOTO LABEL {fprintf(fp,"B %s\n", $2);} Statement            |
           IfStatement Statement |
           Expression Statement | 
           AssignmentExpr Statement | ;

IfStatement: IF Variable LESSTHAN Variable GOTO LABEL               { if(!checkPage(H, $2)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                        if(!checkPage(H, $4)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $4, H), $4);
                                                                        }
                                                                      }
                                                                      fprintf(fp,"CMP R%d, R%d\n", reference(q, $2, H), reference(q, $4, H));
                                                                      fprintf(fp,"BLT %s\n", $6);
                                                                    } |
             IF Variable LESSTHAN NUM GOTO LABEL                    { if(!checkPage(H, $2)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                      }
                                                                      fprintf(fp,"CMP R%d, %s\n", reference(q, $2, H), $4);
                                                                      fprintf(fp,"BLT %s\n", $6);
                                                                    } |
             IF NUM LESSTHAN Variable GOTO LABEL                    { if(!checkPage(H, $4)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                      }
                                                                      fprintf(fp,"CMP %s, R%d\n", $2, reference(q, $4, H));
                                                                      fprintf(fp,"BLT %s\n", $6);
                                                                    } |

            

             IF Variable GRTRTHAN Variable GOTO LABEL               { if(!checkPage(H, $2)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                        if(!checkPage(H, $4)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $4, H), $4);
                                                                        }
                                                                      }
                                                                      fprintf(fp,"CMP R%d, R%d\n", reference(q, $2, H), reference(q, $4, H));
                                                                      fprintf(fp,"BGT %s\n", $6);
                                                                    } |
             IF Variable GRTRTHAN NUM GOTO LABEL                    { if(!checkPage(H, $2)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                      }
                                                                      fprintf(fp,"CMP R%d, %s\n", reference(q, $2, H), $4);
                                                                      fprintf(fp,"BGT %s\n", $6);
                                                                    } |
             IF NUM GRTRTHAN Variable GOTO LABEL                    { if(!checkPage(H, $4)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                      }
                                                                      fprintf(fp,"CMP %s, R%d\n", $2, reference(q, $4, H));
                                                                      fprintf(fp,"BGT %s\n", $6);
                                                                    } |

            

             IF Variable EQUALS EQUALS Variable GOTO LABEL          { if(!checkPage(H, $2)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                        if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
                                                                        }
                                                                      }
                                                                      fprintf(fp,"CMP R%d, R%d\n", reference(q, $2, H), reference(q, $5, H));
                                                                      fprintf(fp,"BLT %s\n", $6);
                                                                    } |
             IF Variable EQUALS EQUALS NUM GOTO LABEL               { if(!checkPage(H, $2)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                      }
                                                                      fprintf(fp,"CMP R%d, %s\n", reference(q, $2, H), $5);
                                                                      fprintf(fp,"BLT %s\n", $6);
                                                                    } |
             IF NUM EQUALS EQUALS Variable GOTO LABEL               { if(!checkPage(H, $5)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                      }
                                                                      fprintf(fp,"CMP %s, R%d\n", $2, reference(q, $5, H));
                                                                      fprintf(fp,"BLT %s\n", $6);
                                                                    } |

            

             IF Variable GOTO LABEL                                 { if(!checkPage(H, $2)){
                                                                        fprintf(fp,"LDR R%d, %s\n", reference(q, $2, H), $2);
                                                                      }
                                                                      fprintf(fp,"CMP R%d, 0\n", reference(q, $2, H));
                                                                      fprintf(fp,"BLT %s\n", $4);
                                                                    } |
             IF NUM GOTO LABEL                                      { fprintf(fp,"CMP %s, 0\n", $2);
                                                                      fprintf(fp,"BLT %s\n", $4);
                                                                    } |


             IF TRUE GOTO LABEL                                     {fprintf(fp,"B %s\n", $4);} |
             IF FALSE GOTO LABEL                                    ;
             

Expression:	Variable EQUALS Variable ADD Variable		            { if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
  																		if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
                                                                        }
																	  }
                                                                      fprintf(fp,"ADD R%d, R%d, R%d\n", reference(q, $1, H), reference(q, $3, H), reference(q, $5, H));
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			Variable EQUALS Variable ADD NUM			            { if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
																	  }
                                                                      fprintf(fp,"ADD R%d, R%d, %s\n", reference(q, $1, H), reference(q, $3, H), $5);
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			Variable EQUALS NUM ADD Variable			            { if(!checkPage(H, $5)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
																	  }
                                                                      fprintf(fp,"ADD R%d, R%d, %s\n", reference(q, $1, H), reference(q, $5, H), $3);
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
			Variable EQUALS NUM ADD NUM {fprintf(fp,"ADD R%d, %s, %s\n", reference(q, $1, H), $3, $5);
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);}|


  			Variable EQUALS Variable SUB Variable		            { if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
  																		if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
                                                                        }
																	  }
                                                                      fprintf(fp,"SUB R%d, R%d, R%d\n", reference(q, $1, H), reference(q, $3, H), reference(q, $5, H));
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			Variable EQUALS Variable SUB NUM			            { if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
																	  }
                                                                      fprintf(fp,"SUB R%d, R%d, %s\n", reference(q, $1, H), reference(q, $3, H), $5);
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			Variable EQUALS NUM SUB Variable			            { if(!checkPage(H, $5)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
																	  }
                                                                      fprintf(fp,"RSB R%d, R%d, %s\n", reference(q, $1, H), reference(q, $5, H), $3);
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			
            

  			Variable EQUALS Variable MUL Variable		            { if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
  																		if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
                                                                        }
																	  }
                                                                      fprintf(fp,"MUL R%d, R%d, R%d\n", reference(q, $1, H), reference(q, $3, H), reference(q, $5, H));
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			Variable EQUALS Variable MUL NUM			            { if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
																	  }
                                                                      fprintf(fp,"MUL R%d, R%d, %s\n", reference(q, $1, H), reference(q, $3, H), $5);
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			Variable EQUALS NUM MUL Variable			            { if(!checkPage(H, $5)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
																	  }
                                                                      fprintf(fp,"MUL R%d, R%d, %s\n", reference(q, $1, H), reference(q, $5, H), $3);
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|



            Variable EQUALS Variable DIV Variable		            { if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
  																		if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
                                                                        }
																	  }
                                                                      fprintf(fp,"DIV R%d, R%d, R%d\n", reference(q, $1, H), reference(q, $3, H), reference(q, $5, H));
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			Variable EQUALS Variable DIV NUM			            { if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
																	  }
                                                                      fprintf(fp,"DIV R%d, R%d, %s\n", reference(q, $1, H), reference(q, $3, H), $5);
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			Variable EQUALS NUM DIV Variable			            { if(!checkPage(H, $5)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
																	  }
                                                                      fprintf(fp,"DIV R%d, %s, R%d\n", reference(q, $1, H), $3, reference(q, $5, H));
                                                                      fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                                                    }|
  			
            

  			Variable EQUALS Variable GRTRTHAN Variable				{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
  																		if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
                                                                        }
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, R%d\n", reference(q, $3, H), reference(q, $5, H));
                                                                      fprintf(fp,"BGT %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS Variable GRTRTHAN NUM   				{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, %s\n", reference(q, $3, H), $5);
                                                                      fprintf(fp,"BGT %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS NUM GRTRTHAN Variable			    	{ if(!checkPage(H, $5)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP %s, R%d\n", $3, reference(q, $5, H));
                                                                      fprintf(fp,"BGT %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            


            Variable EQUALS Variable LESSTHAN Variable				{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
  																		if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
                                                                        }
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, R%d\n", reference(q, $3, H), reference(q, $5, H));
                                                                      fprintf(fp,"BLT %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS Variable LESSTHAN NUM   				{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, %s\n", reference(q, $3, H), $5);
                                                                      fprintf(fp,"BLT %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS NUM LESSTHAN Variable			    	{ if(!checkPage(H, $5)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $5, H), $5);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP %s, R%d\n", $3, reference(q, $5, H));
                                                                      fprintf(fp,"BLT %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            


            Variable EQUALS Variable EQUALS EQUALS Variable			{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
  																		if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $6, H), $6);
                                                                        }
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, R%d\n", reference(q, $3, H), reference(q, $6, H));
                                                                      fprintf(fp,"BE %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS Variable EQUALS EQUALS NUM       		{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, %s\n", reference(q, $3, H), $6);
                                                                      fprintf(fp,"BE %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS NUM EQUALS EQUALS Variable 			    { if(!checkPage(H, $6)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $6, H), $6);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP %s, R%d\n", $3, reference(q, $6, H));
                                                                      fprintf(fp,"BE %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            


            Variable EQUALS Variable GRTRTHAN EQUALS Variable		{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
  																		if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $6, H), $6);
                                                                        }
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, R%d\n", reference(q, $3, H), reference(q, $6, H));
                                                                      fprintf(fp,"BGE %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS Variable GRTRTHAN EQUALS NUM       		{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, %s\n", reference(q, $3, H), $6);
                                                                      fprintf(fp,"BGE %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS NUM GRTRTHAN EQUALS Variable 			    { if(!checkPage(H, $6)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $6, H), $6);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP %s, R%d\n", $3, reference(q, $6, H));
                                                                      fprintf(fp,"BGE %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            


            Variable EQUALS Variable LESSTHAN EQUALS Variable		{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
  																		if(!checkPage(H, $5)){
                                                                        	fprintf(fp,"LDR R%d, %s\n", reference(q, $6, H), $6);
                                                                        }
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, R%d\n", reference(q, $3, H), reference(q, $6, H));
                                                                      fprintf(fp,"BLE %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS Variable LESSTHAN EQUALS NUM       		{ if(!checkPage(H, $3)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP R%d, %s\n", reference(q, $3, H), $6);
                                                                      fprintf(fp,"BLE %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	}|
            Variable EQUALS NUM LESSTHAN EQUALS Variable 			{ if(!checkPage(H, $6)){ 
  																	  	fprintf(fp,"LDR R%d, %s\n", reference(q, $6, H), $6);
																	  }
                                                                      char* label1 = newLabel();
                                                                      char* label2 = newLabel();
                                                                      fprintf(fp,"CMP %s, R%d\n", $3, reference(q, $6, H));
                                                                      fprintf(fp,"BLE %s\n", label1);
                                                                      fprintf(fp,"MOV R%d, 0\n", reference(q, $1, H));
                                                                      fprintf(fp,"B %s\n", label2);
                                                                      fprintf(fp,"%s :MOV R%d, 1\n", label1, reference(q, $1, H));
                                                                      fprintf(fp,"%s :STR R%d, %s\n", label2, reference(q, $1, H), $1);
																	} ;
            

AssignmentExpr: Variable EQUALS Variable    { if(!checkPage(H, $3)){
                                                fprintf(fp,"LDR R%d, %s\n", reference(q, $3, H), $3);
                                              }
                                              fprintf(fp,"MOV R%d, R%d\n", reference(q, $1, H), reference(q, $3, H));
                                              fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                            } |

                Variable EQUALS NUM         {
                                              fprintf(fp,"MOV R%d, %s\n", reference(q, $1, H), $3);
                                              fprintf(fp,"STR R%d, %s\n", reference(q, $1, H), $1);
                                            } ;



Variable: VAR {$$ = $1;} | TEMP {$$ = $1;} ;


%%


void yyerror(const char *s)
{
	fprintf(fp,"%s\n", s);
}

int main()
{
    
    fp = fopen("tcg.txt","w");
    H = initialize_hash();
    q = createQueue();
    if(!yyparse())
    {
        printf("\nVALID\n");
    }
}
