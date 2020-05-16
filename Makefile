a.out : lex.yy.c y.tab.c 
	gcc lex.yy.c y.tab.c 
	
lex.yy.c : lex.l yacc.y 
	yacc -d -v yacc.y
	lex lex.l
	
clean :
	rm -f a.out lex.yy.c y.tab.c y.tab.h tcg.txt y.output
