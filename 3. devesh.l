%{

%}
quotes  \"([^\\\"]|\\.)*\"
comment ("//".*)
comment2 ("/*".*"*/")
%%


public|private|protected { printf("%s : is an Access specifier\n", yytext); }
class|System|out|println|void|main|static { printf("%s : is a Keyword\n", yytext); }
int|double|char|String { printf("%s : is a DataType\n", yytext); }
[A-Z][a-zA-Z0-9]* { printf("%s : is a Class-Name\n", yytext); } 
[a-z][a-zA-Z0-9]* { printf("%s : is a Variable\n", yytext); }  


"+"|"-"|"<"|">"|"!"|"%"|"&"|"^"|"*"|"?"|"=" { printf("%s : is an Operator\n", yytext); }
"["|"]"|"{"|"}"|"("|")"  { printf("%s : is a Bracket\n", yytext); }
","|"."|":"|";" { printf("%s : is a Delimiter\n", yytext); }

[0-9]+ { printf("%s : is a Number\n", yytext); }
{quotes} { printf("%s : is a Quote\n", yytext); }
{comment} { printf("%s : is a Comment\n", yytext); }
{comment2} {printf(" %s : is a Multiline Comment\n",yytext);}
%%


main(int argc, char **argv) {
    if(argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if(!file) {
            fprintf(stderr, "Could not open %s\n", argv[1]);
            exit(1);
        }
        yyin = file; 
    } else {
        yyin = stdin; 
    }
    yylex(); 
    return 0;
}

int yywrap() {
    return 1;
}