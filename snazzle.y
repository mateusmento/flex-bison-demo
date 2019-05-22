%{
#include<cstdio>
extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
	char* sval;
}

%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING

%%

snazzle:
	INT snazzle {
		printf("bison found an int (snazzle): %i\n", $1);
	}
	| FLOAT snazzle {
		printf("bison found an float(snazzle): %f", $1);
	}
	| STRING snazzle {
		printf("bison found an string(snazzle): %s", $1) free($1);
	}
	INT {
		printf("bison found an int: %i\n", $1);
	}
	| FLOAT {
		printf("bison found an float: %f", $1);
	}
	| STRING {
		printf("bison found an string: %s", $1) free($1);
	}
	;

%%

int main(int argc, char** argv)
{
	if (argc > 1)
	{
		char* filename = argv[1];
		FILE* file = fopen(filename, "r");
		if (!file)
		{
			printf("Could not read file %s", filename);
			return -1;
		}
		yyin = file;
	}

	yyparse();
}

void yyerror(const char* s)
{
	printf("ERROR: %s", s);
	exit(-1);
}
