lang: lang.l lang.y
	lex lang.l
	yacc -d lang.y
	gcc lex.yy.c y.tab.c -o lang -ll

clean:
	rm lex.yy.c y.tab.c y.tab.h lang
