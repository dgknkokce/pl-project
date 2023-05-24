lang: lang.l lang.y myscanner.c
	lex lang.l
	yacc -d lang.y
	gcc myscanner.c lex.yy.c y.tab.c -o test

clean:
	rm lex.yy.c y.tab.c y.tab.h test
