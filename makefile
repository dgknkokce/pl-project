lang:lang.l
	 lex lang.l
	gcc myscanner.c lex.yy.c -o test
clean:
	 rm lang lex.yy.c
