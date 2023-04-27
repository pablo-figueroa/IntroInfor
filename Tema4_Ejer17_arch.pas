(*
--------------------------- EJERCICIO 17 ---------------------------
--------------------------- DESDE ARCHIVO ---------------------------

En un sorteo de lotería se extraen 6 números enteros entre 1 a 40.

Se pide ingresar los datos de cada uno de los últimos N sorteos e informar:
    a) La cantidad de sorteos que han tenido al menos un número impar.
    b) El número par más alto de cada sorteo, indicar cuándo no haya habido

Ejemplo:

Si N fuera 3 y los datos de los sorteos fueran:
    2  5 1 19  3 12
    3 13 9  1  7 29
    2  8 1 14 37 16

Debería responder
    a) En 3 sorteos hubo al menos un número impar
    b) El número par más alto del sorteo 1 fue 12
       No hubo pares en el sorteo 2
       El número par más alto del sorteo 3 fue 16

*)

program T4Ej17;

//{$codepage UTF8}

uses crt;

var
    CantSort, NumSort, i, j, MaxPar, MaxParSort1, MaxParSort2, MaxParSort3, MaxParSort4, MaxParSort5 : byte;
    
    Impar : boolean;

    arch : text;

begin
repeat
    clrscr();

    Impar := false;

    WriteLn('-------------------');
    WriteLn('   S O R T E O S');
    WriteLn('-------------------');
    WriteLn();
    
    assign(arch, 'sorteo.txt');
    reset(arch);

    
    ReadLn(arch, CantSort);
    Writeln(CantSort); { PARA VER NUMERO LEIDO }
    WriteLn();   { PARA VER NUMERO LEIDO }
    
    for i:=1 to CantSort do
        begin
        MaxPar := 0;
        for j:=1 to 6 do
            begin

            Read(arch, NumSort);
            Write(NumSort, '  '); { PARA VER NUMERO LEIDO }
            
            if (NumSort mod 2 <> 0) then
                Impar := TRUE;

            if (NumSort mod 2 = 0) and (NumSort > MaxPar) then
                MaxPar := NumSort;

            end; {for 1to6}
        
        case i of
            1 : MaxParSort1 := Maxpar;
            2 : MaxParSort2 := Maxpar;
            3 : MaxParSort3 := Maxpar;
            4 : MaxParSort4 := Maxpar;
            5 : MaxParSort5 := Maxpar;
            end; {case}
        Readln(arch);
        WriteLn();   { PARA VER NUMERO LEIDO }
        WriteLn();   { PARA VER NUMERO LEIDO }

        end; {for 1toCantSort}

    close(arch);
    
    WriteLn();

    { SALIDA DE INFORMACION}
    TextColor(cyan);
    if Impar = true then
        WriteLn('En ',CantSort,' sorteos hubo al menos un número impar.')
    else
        WriteLn('Ningún Impar en el sorteo.');
    
    WriteLn();

    { Sorteo 1 }
    if MaxParSort1 > 0 then
        WriteLn('El número par más alto del Sorteo N°: 1 fue: ',MaxParSort1)
    else
        if CantSort >= 1 then
            WriteLn('No hubo pares en el Sorteo N°: 1');

    { Sorteo 2 }
    if MaxParSort2 > 0 then
        WriteLn('El número par más alto del Sorteo N°: 2 fue: ',MaxParSort2)
    else
        if CantSort >= 2 then
            WriteLn('No hubo pares en el Sorteo N°: 2');

    { Sorteo 3 }
    if MaxParSort3 > 0 then
        WriteLn('El número par más alto del Sorteo N°: 3 fue: ',MaxParSort3)
    else
        if CantSort >= 3 then
            WriteLn('No hubo pares en el Sorteo N°: 3');

    { Sorteo 4 }
    if MaxParSort4 > 0 then
        WriteLn('El número par más alto del Sorteo N°: 4 fue: ',MaxParSort4)
    else
        if CantSort >= 4 then
            WriteLn('No hubo pares en el Sorteo N°: 4');

    { Sorteo 5 }
    if MaxParSort5 > 0 then
        WriteLn('El número par más alto del Sorteo N°: 5 fue: ',MaxParSort5)
    else
        if CantSort >= 5 then
            WriteLn('No hubo pares en el Sorteo N°: 5');
    
    WriteLn();
    TextColor(green);
    Write('ENTER para reiniciar...');
    TextColor(white);
    
    ReadLn();
    
until FALSE;
end.