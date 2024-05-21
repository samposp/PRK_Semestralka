
%{ 
    #define YYSTYPE complex
    #include <stdio.h> 
    #include <math.h> 
    #include <complex.h>
    void yyerror(const char *s);
    double cabs(complex);

%} 
%start Syntax
%token NUMBER 
%token FNC_IMAG FNC_REAL FNC_ABS LINE_END

%% 
Syntax:
    Expression LINE_END {
            printAns($1);
            exit(EXIT_SUCCESS);
        }
    ;

Expression:
    Term Add {$$=$1+$2;}
    | '-' Term Add {$$=-$2+$3;}
    | Term Sub {$$=$1-$2;}
    | '-' Term Sub {$$=-$2-$3;}
    ;

Add:
    '+' Term Add {$$=$2+$3;}
    | '+' Term Sub {$$=$2-$3;}
    |; {$$=0;}

Sub:
    '-' Term Add {$$=$2+$3;}
    |'-' Term Sub {$$=$2-$3;}
    ;

Term:
    Factor Mult {$$=$1*$2;}
    ; 

Mult:
    '*' Factor Mult {$$=$2*$3;}
    |; {$$=1;}

Factor:
    '(' Expression ')' {$$=$2;}
    | Function {$$=$1;}
    | ComplexNumber {$$=$1;}
    ;

Function:
    FNC_IMAG '(' Expression ')' {$$=cimag($3);}
    | FNC_ABS '(' Expression ')' {$$=cabs($3);}
    | FNC_REAL '(' Expression ')' {$$=creal($3);}
    ;

ComplexNumber:
    ImagNumber {$$=$1;}
    | NUMBER {$$=$1;}
    ;

ImagNumber:
    '[' Expression ']' {$$=$2*I;}
    ;


%% 
void yyerror(const char* s) {   
    printf("%s\n",s);
}

double cabs(complex a){
    return sqrt(creal(a)*creal(a) + cimag(a)*cimag(a));
}

void printAns(complex a){
    if (cimag(a) < 0){
        printf("%lf - [%lf]\n",creal(a), -cimag(a));
    }
    else {
        printf("%lf + [%lf]\n",creal(a), cimag(a));
    }   
}

int main(){
    return yyparse(); 
}