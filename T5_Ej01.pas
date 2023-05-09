(*
Leer pares de números enteros desde un archivo de texto y para cada uno de ellos
verificar mediante función booleana si el mayor de ellos es múltiplo del menor, además
calcular e imprimir el porcentaje de los pares que cumplen.

Archivo: T5_Ej01.txt
*)

program T5_Ej01;

uses crt;

function bool (a,b:integer):boolean;
    begin
    bool:=false;

        if (a > b) and (b <> 0) and (a mod b = 0) then
            bool := true
        else if (b > a) and (a <> 0) and (b mod a = 0) then
            bool := true;

    end; {function}

var
    n1, n2              : integer;
    arch                : text;
    ContTrue, ContFalse : byte;

begin
    clrscr;
    ContTrue  := 0;
    ContFalse := 0;

    WriteLn('LECTURA DE PARES DE NUMERO');
    WriteLn('  Verificar mediante funcion booleana si el MAYOR de ellos es MULTIPLO del MENOR');
    WriteLn('  Calcular e imprimir el porcentaje de los pares que cumplen');
    WriteLn;

    Assign(arch, 'T5_Ej01.txt');
    Reset(arch);

    WriteLn('Para los pares: ');
    WriteLn;
    while not eof(arch) do
        begin
        ReadLn(arch, n1,n2);

        TextColor(yellow);
        Write('   ',n1:3,'  | ',n2:3,' : ');
        if (bool(n1,n2) = TRUE) then
            begin
            ContTrue := ContTrue + 1;
            TextColor(cyan);
            Writeln('TRUE');
            TextColor(White);
            end
        else
            begin
            ContFalse := ContFalse + 1;
            TextColor(red);
            Writeln('FALSE');
            TextColor(White);
            end;
        WriteLn('------------------------');
        end; {while}

    WriteLn;
    WriteLn('Porcentaje de los PARES que cumplen TRUE: ',(ContTrue/(ContTrue + ContFalse)*100):6:2,'%');
    
    readln;
end.