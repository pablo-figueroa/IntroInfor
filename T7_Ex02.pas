(*
EJERCICIO 2

Ingresar una matriz de NxM de enteros, escribir:
    
    a. Los elementos de la fila cuya suma de componentes sea la mayor.
    b. Los elementos de la columna cuya suma de componentes sea la menor.
    c. Los elementos del “contorno”.

EJEMPLO:

    | -12  33   4   5 |
    |  10   0  45   7 |
    |  62  81  71   8 |
    |  -7  69  10   9 |

    a. ( 62 81 71 8 )

    b. ( 5 7 8 9 )

    c. por filas   -> ( -12 33  4  5 10  7 62  8 -7 69 10 9 )

*)

program T7_Ex02;

//{$codepage UTF8}

uses crt;

type
    TM = array[1..20,1..20] of integer;


{---------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('-------------------------------------------------------------------');
    WriteLn;
end;{procedure}


{---------------------------------------------------------------------------------------}
procedure LeerMatriz (
    var Mat : TM;
    var N   : byte;
    var M   : byte
);

var
    i : byte;
    j : byte;

begin
    Write('Ingrese cantidad de filas: ');
    ReadLn(N);
    
    Write('Ingrese cantidad de columnas: ');
    ReadLn(M);
    
    for i:=1 to N do
        for j:=1 to M do
            begin
            Write('Ingrese (',i,',',j,') : ');
            ReadLn(Mat[i,j]);
            end;
end;


{---------------------------------------------------------------------------------------}
procedure MostrarMatriz (
    Mat : TM;
    N   : byte;
    M   : byte
);

var
    i : byte;
    j : byte;

begin
    for i:=1 to N do
        begin
        write('  |');
        for j:=1 to M do
            begin
            write(Mat[i,j]:4);
            end;
        WriteLn('  |');
        end;

end;


{---------------------------------------------------------------------------------------}
{ a. Los elementos de la fila cuya suma de componentes sea la mayor. }
function FilaSumaMayor (
    Mat : TM;
    N   : byte;
    M   : byte
):byte;

var
    i : byte;
    j : byte;
    K : byte;
    Acum : integer;
    Suma : integer;

begin
    Suma := -9999;
    for i:=1 to N do
        begin
        Acum := 0;
        for j:=1 to M do
            Acum := Acum + Mat[i,j];
        if Acum > Suma then
            begin
            Suma := Acum;
            k := i;
            end;
        end;
    FilaSumaMayor := K;
end;


{---------------------------------------------------------------------------------------}
procedure MostrarFila (
    Mat : TM;
    Fila, M : byte
);

var
    j : byte;

begin
    write('  (  ');
    for j:=1 to M do
        write(Mat[Fila,j],'  ');
    writeLn(')');
end;


{---------------------------------------------------------------------------------------}
{ b. Los elementos de la columna cuya suma de componentes sea la menor. }
function ColSumaMenor (
    Mat : TM;
    N   : byte;
    M   : byte
):byte;

var
    i : byte;
    j : byte;
    K : byte;
    Acum : integer;
    Suma : integer;

begin
    Suma := 9999;
    for j:=1 to M do
        begin
        Acum := 0;
        for i:=1 to N do
            Acum := Acum + Mat[i,j];
        if Acum < Suma then
            begin
            Suma := Acum;
            k := j;
            end;
        end;
    ColSumaMenor := K;
end;


{---------------------------------------------------------------------------------------}
procedure MostrarCol (
    Mat    : TM;
    N, Col : byte
);

var
    i : byte;

begin
    write('  (  ');
    for i:=1 to N do
        write(Mat[i,Col],'  ');
    writeLn(')');
end;

{---------------------------------------------------------------------------------------}
{ c. Los elementos del “contorno”. }
procedure MostrarContorno (
    Mat  : TM;
    N, M : byte
);

var
    i,j : byte;

begin
    Write('  (  ');

    { Mostrar la primera fila }
    for j := 1 to M do
        Write(Mat[1, j],'  ');

    { Mostrar las filas del contorno izquierdo y derecho }
    for i := 2 to N - 1 do
        begin
        Write(Mat[i, 1],'  ');
        Write(Mat[i, M],'  ');
        end;

    { Mostrar la última fila }
    for j := 1 to M do
        Write(Mat[N, j],'  ');

    WriteLn(')');

end;


{---------------------------------------------------------------------------------------}
{PROGRAMA PRINCIPAL}
var
    Mat   : TM;
    N    : byte;
    M    : byte;

    Fila : byte;
    Col  : byte;


begin
    LeerMatriz(Mat, N, M);
    ClrScr;

    WriteLn('Matriz Ingresada: ');
    Writeln;
    MostrarMatriz(Mat, N, M);

    Separador;

    Fila := FilaSumaMayor(Mat, N, M);

    WriteLn('Elementos cuya suma de componentes es mayor -> Fila = ',Fila,':');
    MostrarFila(Mat, Fila, M);

    Separador;

    Col := ColSumaMenor(Mat, N, M);
    WriteLn('Elementos de cuya suma de componentes es menor -> Columna = ',col,':');
    MostrarCol(Mat, N, Col);

    Separador;

    WriteLn('Los elementos del contorno son:');
    MostrarContorno(Mat, N, M);

    Separador;

    ReadLn;

end.