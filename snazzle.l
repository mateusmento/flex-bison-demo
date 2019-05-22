%{
#include <cstdio>
#include "snazzle.tab.h"
extern int yylex();
%}
%option noyywrap
%%
[ \t\n]			;
[0-9]+\.[0-9]+	{ yylval.fval = atof(yytext); return FLOAT; }
[0-9]+			{ yylval.ival = atoi(yytext); return INT; }
[a-zA-Z0-9]+	{ yylval.sval = strdup(yytext); return STRING; }
%%
int main(int argc, char** argv)
{
	if (argc > 1)
	{
		char* filename = argv[1];
		FILE* file = fopen(filename, "r");
		if (!file)
		{
			printf("couldn't not open file '%s'", filename);
		}
		else
		{
				yyin = file;
		}
	}

	

	while(yylex());
}
