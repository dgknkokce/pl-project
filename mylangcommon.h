#ifndef MYLANGCOMMON_H
#define MYLANGCOMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
    ADD,
    SUBTRACT,
    MULTIPLY,
    DIVIDE,
    ASSIGNMENT,
    EQUALS,
    SEMICOLON,
    PAROPEN,
    PARCLOSE,
    CBOPEN,
    CBCLOSE,
    WRITE,
    EXIT,
    IF,
    ELSEIF,
    ELSE,
    WHILE,
    FOR,
    RETURN,
    BOOLEAN,
    IDENTIFIER,
    INTEGER,
    DECIMAL
} TokenType;

typedef struct {
    TokenType type;
    union {
        int number;
        double decimal;
        char* identifier;
    } value;
    int line_number;
} Token;

typedef struct token_node_t {
    Token* token;
    struct token_node_t* next;
} TokenNode;

typedef struct {
    TokenNode* head;
    TokenNode* tail;
} TokenList;

void init_token_list(TokenList* list);
void add_token_to_list(TokenList* list, Token* token);
void free_token_list(TokenList* list);

#endif /* MYLANGCOMMON_H */
