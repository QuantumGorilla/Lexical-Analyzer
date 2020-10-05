clear #Limpiar la terminal
if [ -f LAB01_Lagares_Manotas_Zuñiga.yy.c ]; then #Revisamos que exista el archivo
    rm LAB01_Lagares_Manotas_Zuñiga.yy.c #Elimina el .yy.c creado anteriormente
    
fi
if [ -f a.out ]; then
    rm a.out #Elimina el a.out creado anterior
fi
lex LAB01_Lagares_Manotas_Zuñiga.l #Genera el .yy.c
mv lex.yy.c LAB01_Lagares_Manotas_Zuñiga.yy.c
gcc LAB01_Lagares_Manotas_Zuñiga.yy.c -ll #Genera el a.out
./a.out < *.java #Compila el archivo java
if [ -f a.out ]; then
    rm a.out #Elimina el a.out creado anterior
fi
