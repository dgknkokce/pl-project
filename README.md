Group Members: Şükran Şafak Barutçu(20190808003), Doğukan Kökce(20180808009)

#Language Name: Mylang
--

## Syntax
NOTE: Sytnax definations will be available, when the yacc file created.

\<prog\> : \<stmt\> | \<stmts\>

\<stmt\> : \<expr\> ...

## Explanations about the language
- mylangcommon.h defines constants for token types in the language.
- lang.l is the lexer file written in Flex syntax. It defines rules to match and return tokens based on input text patterns.
- lang.y is the parser file written in Bison syntax. It defines the grammar rules and actions for parsing the input program.
- The main() function in lang.y invokes the parser to start parsing the input program.
- The makefile specifies the compilation steps to build the executable. It generates the lexer and parser source files and compiles them along with myscanner.c to create the final executable named lang.
- myscanner.c contains a simple example program that uses the lexer to tokenize the input program. It prints the type and value of each token.
- To compile the code, you can run make lang in the terminal. This will generate the lang executable. Running lang will execute the programming language.
