# Compiler Design
Repo contains a compiler that can be used to compile basic JavaScript code, such as for loops, if constructs, etc.

## Phase 1 - Lexer
* `lex.l` is the file used as a lexer. The lexer generates tokens from the given input and removes comments.
* To run the file, run the following commands\
    `$ lex lex.l`\
    `$ gcc lex.yy.c`

## Phase 2 - Parser
* Parsing is done by a YACC file, `yacc.y`. It takes the tokens sent by the lexer and generates a parse tree as well as a symbol table, while performing a syntax check.
* To run the file, run the follwing commands\
    `$ yacc yacc.y`
    `$ gcc y.tab.c`