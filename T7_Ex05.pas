(*
EJERCICIO 5 
Una matriz cuadrada A se dice es simétrica si A[i,j] = A [j,i] 
para todo i, j dentro de los límites de matriz. 

"Una matriz cuadrada será simétrica si es igual a su traspuesta."

Escribir una función que determine:
    a. Cuantos elementos simétricos son diferentes.
    b. Verificar si es o no simétrica.

EJEMPLO 1
        Matriz A
        1	2	3
        2	5	6
        3	6	9

        La Matriz es simétrica.
-----------------------------------------------------
EJEMPLO 2
        Matriz A
        1	2	3
        7	5	6
        8	6	9

        La Matriz NO es Simétrica.-
        Cantidad de elementos diferentes: 2


*)

program T7_Ex05;

//{$codepage UTF8}

uses crt;

type
    TM = array[1..20,1..20] of integer;


{---------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('--------------------------------------------');
    WriteLn;
end;{procedure}


{---------------------------------------------------------------------------------------}
procedure LeerMatriz (
    var Mat : TM;
    var N   : byte
);

var
    i : byte;
    j : byte;

begin
    repeat
        Write('Ingrese cantidad de filas y columnas: ');
        ReadLn(N);
    until N >= 2;
    
    for i:=1 to N do
        for j:=1 to N do
            begin
            Write('Ingrese (',i,',',j,') : ');
            ReadLn(Mat[i,j]);
            end;
end;


{---------------------------------------------------------------------------------------}
procedure MostrarMatriz (
    Mat : TM;
    N   : byte
);

var
    i : byte;
    j : byte;

begin
    for i:=1 to N do
        begin
        TextColor(white);
        write('  |');
        for j:=1 to N do
            begin

            { Para darle color y claridad... }
            if i > j then 
                TextColor(yellow)
            else 
                if i = j then 
                    TextColor(green)
                else 
                    TextColor(white);
            
            write(Mat[i,j]:4);
            end;
        TextColor(white);
        WriteLn('  |');
        end;
end;


{---------------------------------------------------------------------------------------}
function DeterminarSimetriaFOR (       { EFICAZ }
    Mat : TM;
    N   : byte
):byte;

var
    i,j : byte;
    Aux : byte; { Contador }

begin
    Aux := 0; { Porque los elementos de la diagonal principal serán siempre simétricos }
    for i:=2 to N do
        for j:=1 to N do
            begin
            writeln('i: ',i,' j: ',j);
            readln;
            while i > j do
                begin
                if Mat[i,j] <> Mat[j,i] then
                    Aux := Aux + 1;
                WriteLn(Mat[i,j],' | ',Mat[j,i],' Aux = ',Aux);
                Readln;
                break;
                end; {while}
            end; {for j}

    DeterminarSimetriaFOR := Aux;
end;


{---------------------------------------------------------------------------------------}
function DeterminarSimetriaWHILE (            { EFICIENTE }
    Mat : TM;
    N   : byte
):byte;

var
    i,j : byte;
    Aux : byte; { Contador }

begin
    Aux := 0; { Porque los elementos de la diagonal principal serán siempre simétricos }
    i := 2;
    j := 1;
    
    while (i <= N) do
        begin
        while (j < N) and (j < i) do
            begin
            
            if Mat[i,j] <> Mat[j,i] then
                Aux := Aux + 1;
            
            { Ver que sucede... }
            (* writeln('Mat[',i,',',j,'] = ',Mat[i,j],' | VS | Mat[',j,',',i,'] = ',Mat[j,i],' | Aux = ',Aux); WriteLn; *)
                
            j := j + 1;
            end;{while j}
        i := i + 1;
        j := 1;
        end; {while i}
    
    DeterminarSimetriaWHILE := Aux;
end;


{---------------------------------------------------------------------------------------}
{ PROGRAMA PRINCIPAL }
var
    Mat    : TM;
    N      : byte;
    DetSim : byte;


begin
    LeerMatriz(Mat, N);
    ClrScr;

    WriteLn('Matriz Ingresada: ');
    Writeln;
    MostrarMatriz(Mat, N);

    Separador;

    DetSim := DeterminarSimetriaWHILE(Mat, N);     { EFICIENTE }
    (* DetSim := DeterminarSimetriaFOR(Mat, N);       { EFICAZ    } *)
    
    if DetSim = 0 then
        WriteLn('La Matriz es Simétrica.-')
    else
        begin
        WriteLn('La Matriz NO es Simétrica.-');
        WriteLn('Cantidad de elementos diferentes: ',DetSim);
        end;

    Separador;
    
    Write('FIN ');
    ReadLn;

end.