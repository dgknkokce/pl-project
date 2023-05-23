CC = gcc
LEX = flex
YACC = bison
CFLAGS = -Wall

lang: lang.tab.o lex.yy.o
	$(CC) $(CFLAGS) -o $@ $^

lang.tab.c lang.tab.h: lang.y
	$(YACC) -d $<

lex.yy.c: lang.l lang.tab.h
	$(LEX) $<

clean:
	rm -f lang .o lex.yy.c lang.tab.