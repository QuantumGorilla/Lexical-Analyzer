%{
	int yyline;
	int espacio;
	int sangria;
	char *yyval;
	#include<stdio.h>
	#include <stdlib.h>
	#define IF 1;
	#define ELSE 1;
	#define FOR 1;
	#define WHILE 1;
	#define DOUBLE 1;
	#define INT 1;
	#define STRING 1;
	#define CHAR 1;
	#define NEW 1;
	#define PUBLIC 1;
	#define CLASS 1;
	#define STATIC 1;
	#define VOID 1;
	#define OP_mult 2;
	#define OP_sum 2;
	#define OP_sust 2;
	#define OP_div 2;
	#define OP_asign 2;
	#define OP_mod 2;
	#define OP_MasMas 3;
	#define OP_MenosMenos 3;
	#define OP_MasAsign 3;
	#define OP_MenosAsign  3;
	#define OP_PorAsign  3;
	#define OP_DivAsign  3;
	#define Llave_a 4;
	#define Llave_c  4;
	#define Punto_coma  5;
	#define parent_a  6;
	#define parent_c 6;
	#define corchete_a  7;
	#define corchete_c  7;
	#define Cte_entera 8;
	#define Cte_real 9;
	#define Cte_cadena 10;
	#define ID 11;
	#define Igual 12;
	#define Menor_igual 12;
	#define Mayor_igual 12;
	#define Diferente 12;
	#define Mayor 12;
	#define Menor 12;
	#define Op_y 13;
	#define Op_o 13;
	#define Op_no 13;
	#define Error 14;
	#define Comentario 15;
%}
letra	[a-zA-Z]
digito	[0-9]
id	{letra}({letra}|{digito})*
entero  ({digito})*
real    ({entero})*"."({entero}|"e-")*
comentario "//"(({id}|{digito})|" ")*
%%
(p|P)(u|U)(b|B)(l|L)(i|I)(c|C)	{yyval= "PUBLIC";return PUBLIC;}
(i|I)(f|F)						{yyval= "IF";return IF;}
(e|E)(l|L)(s|S)(e|E)			{yyval= "ELSE";return ELSE;}
(f|F)(o|O)(r|R)					{yyval= "FOR";return FOR;}
(w|W)(h|H)(i|I)(l|L)(e|E)		{yyval= "WHILE";return WHILE;}
(d|D)(o|O)(u|U)(b|B)(l|L)(e|E)	{yyval= "DOUBLE";return WHILE;}
(i|I)(n|N)(t|T)					{yyval= "INT";return WHILE;}
(s|S)(t|T)(r|R)(i|I)(n|N)(g|G)	{yyval= "STRING";return WHILE;}
(c|C)(h|H)(a|A)(r|R)			{yyval= "CHAR";return WHILE;}
(n|N)(e|E)(w|W)					{yyval= "NEW";return NEW;}
(c|C)(l|L)(a|A)(s|S)(s|S)		{yyval= "CLASS";return CLASS;}
(s|S)(t|T)(a|A)(t|T)(i|I)(c|C)	{yyval= "STATIC";return STATIC;}
(v|V)(o|O)(i|I)(d|D)			{yyval= "VOID";return VOID;}
"*"								{yyval= "OP_mult";return OP_mult;}
"+"								{yyval= "OP_sum";return OP_sum;}
"-"								{yyval= "OP_sust";return OP_sust;}
"/"								{yyval= "OP_div";return OP_div;}
"="								{yyval= "OP_asign";return OP_asign;}
"%"								{yyval= "OP_mod";return OP_mod;}
"++"							{yyval= "OP_MasMas";return OP_MasMas;}
"--"							{yyval= "OP_MenosMenos";return OP_MenosMenos;}
"+="							{yyval= "OP_MasAsign";return OP_MasAsign;}
"-="							{yyval= "OP_MenosAsign";return OP_MenosAsign;}
"*="							{yyval= "OP_PorAsign";return OP_PorAsign;}
"/="							{yyval= "OP_DivAsign";return OP_DivAsign;}
"{"								{yyval= "Llave_a";return Llave_a;}
"}"								{yyval= "Llave_c";return Llave_c;}
";"								{yyval= "Punto_coma";return Punto_coma;}
"("								{yyval= "parent_a";return parent_a;}
")"								{yyval= "parent_c";return parent_c;}
"["								{yyval= "corchete_a";return corchete_a;}
"]"								{yyval= "corchete_c";return corchete_c;}
{entero}						{yyval= "Cte_entera";return Cte_entera;}
{real}							{yyval= "Cte_real";return Cte_real;}
{id}							{yyval= "id";return ID;}
("\"")([^\n\""]*([.])*)*("\"") 	{yyval= "Cte_cadena";return Cte_cadena;}
"=="							{yyval= "Igual";return Igual;}
"<="							{yyval= "Menor_igual";return Menor_igual;}
">="							{yyval= "Mayor_igual";return Mayor_igual;}
"<>"|"!="						{yyval= "Diferente";return Diferente;}
">"								{yyval= "Mayor";return Mayor;}
"<"								{yyval= "Menor";return Menor;}
"&&"							{yyval= "Op_y";return Op_y;}
"||"							{yyval= "Op_o";return Op_o;}
"!"								{yyval= "Op_no";return Op_no;}
{comentario}					{yyval= "Comentario";return Comentario;}
\n								yyline++;
" " 							espacio++;
"	"							sangria++;
.								{yyval= "Error"; return Error;}
%%
int main(){
	FILE * outfile=fopen("salida.txt","w");// crea un archivo 
	int token;
	token=yylex();
	char arreglo[100][100];// arreglo de ids
	char errores[100][100];// arreglo de errores
	int index=0;//Controlar arreglo de ids ids
	int errs=0;//Controlar arreglo de errores
	int currentline=yyline; //asigno la primera linea del archivo
	while(token){
		if(yyline==currentline){
			if(token==1){ //si es una palabra clave
				fputs(yyval,outfile);
				fputs(" ",outfile);
			}else{
				if(strcmp(yyval,"id")==0){ //si es un id
					strcpy(arreglo[index],yytext);// ids
					index++;
				}
				if(strcmp(yyval, "Error") == 0){ //Si es un error
					strcpy(errores[errs],yytext);// errores
					errs++;
				}
				fputs(yyval,outfile);
				fputs("=",outfile);
				fputs(yytext,outfile);
				fputs(" ",outfile);
			}
			token=yylex();	
		}else{
		fputc('\n',outfile);
		currentline=yyline;
		}
	}
	int k;
	for(int i=0;i<index;i++){
		for(int j=i+1;j<index;j++){
			if(strcmp(arreglo[i],arreglo[j])==0){
				k=j;
				while(k<index){
					strcpy(arreglo[k],arreglo[k+1]);
					k++;
				}
				index--;
				j--;
			}
		}
	}
	k=0;
	for(int i=0;i<errs;i++){
		for(int j=i+1;j<errs;j++){
			if(strcmp(errores[i],errores[j])==0){
				k=j;
				while(k<errs){
					strcpy(errores[k],errores[k+1]);
					k++;
				}
				errs--;
				j--;
			}
		}
	}
	fputc('\n',outfile);
	fputc('\n',outfile);
	fputs("Tabla de Identificadores",outfile);
	fputc('\n',outfile);
	fputs("Hay",outfile);
	fprintf(outfile," %d ",index);
	fputs("Identificadores",outfile);
	fputc('\n',outfile);
	for(int i=0; i<index; i++){
		fputs("id=",outfile);
		fputs(arreglo[i],outfile);
		fputs("; ",outfile);
	}
	fputc('\n',outfile);
	fputc('\n',outfile);
	fputs("Tabla de errores",outfile);
	fputc('\n',outfile);
	fputs("Hay",outfile);
	fprintf(outfile," %d ",errs);
	fputs("Errores",outfile);
	fputc('\n',outfile);
	for(int i=0; i<errs; i++){
		fputs("Error=",outfile);
		fputs(errores[i],outfile);
		fputs("; ",outfile);
	}
	fflush(outfile);
	fclose(outfile);
	return 0;
}

