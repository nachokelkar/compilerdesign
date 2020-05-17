a.out : lex.yy.c y.tab.c 
	gcc lex.yy.c y.tab.c 
	
lex.yy.c : icg.l icg.y 
	yacc -d -v icg.y
	lex icg.l
	
clean :
	rm -f a.out lex.yy.c y.tab.c y.tab.h icg.txt y.output
