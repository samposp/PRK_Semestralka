%{
   // #define DEBUG
   #include <stdio.h> 
   #include <complex.h>
   #include "y.tab.h"
   extern complex yylval;
   extern void yyerror(const char* s);
   void debugPrint(char* msg);
%}

%%
[\+\-\*]          {debugPrint("Operator Detected\n"); return yytext[0];}
[\(\)\[\]]        {debugPrint("Bracket Detected\n"); return yytext[0];}
[\n(\r\n)]        {debugPrint("Line End Detected\n"); return LINE_END;}

real    {debugPrint("Real function Detected\n"); return FNC_REAL;}
imag    {debugPrint("Imag function Detected\n"); return FNC_IMAG;}
abs     {debugPrint("Abs function Detected\n"); return FNC_ABS;}

(0|[1-9][0-9]*)(\.[0-9]+)?  {
         debugPrint("Number Detected\n");
         yylval = atof(yytext);
         return NUMBER;
      }
[ \t]   { /* skip blanks and tabs */ } 
.       {
      yyerror("unexpected character"); 
      exit(1);
   }
%%

void debugPrint(char* msg){
    #ifdef DEBUG
        printf("%s",msg);
    #endif
}

int yywrap(){}