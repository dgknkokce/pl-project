lang: lang.l lang.y
    lex lang.l
    yacc -d lang.y
    gcc lex.yy.c y.tab.c myscanner.c -o test -ll

clean:
    rm lex.yy.c y.tab.c y.tab.h test
