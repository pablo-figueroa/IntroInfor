(*
-------------------------- EJERCICIO 18 --------------------------
-------------------------- DESDE ARCHIVO -------------------------

Leer un conjunto de números enteros, la presencia de ceros intermedios indican fin de un
subconjunto y comienzo del siguiente (el fin de datos está indicado con dos ceros
consecutivos). Se pide calcular e informar: total de números para cada subconjunto y orden del
conjunto más numeroso.


Ejemplo : 8, 9, 0, 7, 2, 7, 4, 0, 5, 6, 1, 0, 0

Respuesta:
    Subconjunto         Cantidad
        1                    2
        2                    4
        3                    3

    Subconjunto con más elementos 2

    8, 9, 0,         7, 2, 7, 4, 0,         5, 6, 1, 0, 0
*)
program T4Ej18;

{$codepage UTF8}

uses crt;

var
    ContSubC     : byte; { Cuenta los Subconjuntos }
    ContCant     : int8; { Cuenta Cantidad de Elementos }
                         { Tendré que asignar valor: -1 }

    MaxContSubC  : byte;
    MaxContCant  : byte;

    numAnt       : integer;
    numPost      : integer;

    arch         : text;


begin
    clrscr();
    assign(arch, 'ceros.txt'); { ASIGNO ARCHIVO }


    { NUMEROS DE ARCHIVO }
    TextColor(white);
    WriteLn('Estos son los números que CONTIENE el archivo (pero en VERTICAL):');
    WriteLn();
    WriteLn('8 9 0 7 2 7 4 0 5 4 2 1 0 6 1 9 9 0 0 999'); //CTRL+C Y CTRL+V

    { NUMEROS QUE VOY A LEER DE ARCHIVO}
    TextColor(blue);
    WriteLn('- - - - - - - - - - - - - - - - - - - - - - - - - - -');
    WriteLn();
    TextColor(green);
    WriteLn('Y estos son los números que LEO DESDE el archivo:');
    WriteLn();
    TextColor(white);


    reset(arch); { PREPARARO EL ARCHIVO }

    readln(arch, numAnt);
    readln(arch, numPost);

    while (numAnt <> 0) and (numPost <> 0) do
        begin
        Write(numAnt);
        Write(' ');
        while (numAnt <> 0) or (numPost <> 0) do
            begin
            Write(numPost);
            Write(' ');
            numAnt := numPost;
            readln(arch, numPost);
            end; { while 0 OR 0}
        end; { while 0 AND 0 }

    close(arch);

    { SALIO DEL WHILE ES PORQUE AMBOS 0 }
    TextColor(red);
    Writeln('0');
    TextColor(white);
    WriteLn();
    Write('Al leer: { 0 ');
    TextColor(red);
    Write('0');
    TextColor(white);
    Writeln(' } FINALIZA LA LECTURA');
    WriteLn();

    { MOSTRANDO RESULTADOS }
    RESET(ARCH);
    WriteLn();
    TextColor(blue);
    WriteLn('- - -  M O S T R A N D O   R E S U L T A D O S  - - -');
    TextColor(white);
    WriteLn();

    { INICIALIZO }
    ContSubC := 0;
    MaxContCant := 0;
    MaxContSubC := 0;


    readln(arch, numAnt);
    readln(arch, numPost);

    while (numAnt <> 0) and (numPost <> 0) do
        begin
        ContCant := 0; { INICIALIZO }
        ContSubC := ContSubC + 1; { CUENTO PRIMER SUBCONJUNTO }
        Write(numAnt);
            Write(' ');

        while (numAnt <> 0) or (numPost <> 0) do
            begin
            ContCant := ContCant + 1;

            if (numPost = 0) then
                begin
                Textcolor(red);
                Write(numPost,' ');
                WriteLn();

                TextColor(red);
                WriteLn('Dado que encontré un cero:');

                TextColor(yellow);
                WriteLn('  Subconjunto ',ContSubC,'. Tiene ', ContCant, ' elementos.');
                TextColor(white);
                WriteLn();

                { Para almacenar el conjuto con el máximo de elemenos }
                if (ContCant > MaxContCant) then
                { ">" almacenará el PRIMER subconjunto con más elementos}
                { ">=" almacenará el ULTIMO subconjunto con más elementos}
                    begin
                    MaxContCant := ContCant;
                    MaxContSubC := ContSubC;
                    end;

                ContCant := -1;
                { -1 es para descontar del conteo futuro el elemento 0 }
                { Por eso está declara como como int8 }

                ContSubC := ContSubC + 1;  { ACTUALIZO EL CONTADOR DE SUBCONJUNTOS }
                end
            else
                Write(numPost,' ');

            numAnt := numPost;
            readln(arch, numPost);

            end; { while 0 OR 0}

        end; { while 0 AND 0 }

    close(arch);

    // SALIO DEL WHILE ES PORQUE AMBOS 0
    TextColor(red);
    Writeln('0 : DADO QUE ENCONTRÉ DOS CEROS = FIN');

    WriteLn();

    TextColor(white);
    Write('El ');

    TextColor(green);
    Write('Primer ');

    TextColor(white);
    Write('Subconjunto con más elementos es el ');

    TextColor(green);
    Write(MaxContSubC);

    TextColor(white);
    Write(' y tiene ');

    TextColor(green);
    Write(MaxContCant);

    TextColor(white);
    Write(' elementos.');

     readln();
end.