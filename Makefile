
all: snazzle

snazzle: lex.yy.c
	g++ lex.yy.c -o snazzle

lex.yy.c: snazzle.l
	flex snazzle.l
