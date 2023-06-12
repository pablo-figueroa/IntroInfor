(*
TEMA 7 - ADICIONAL 02

    * Se pide desarrollar un programa Pascal correctamente modularizado que lea N vectores
de 5 elementos reales y 
    * Para cada uno que cumpla que el 5to elemento es mayor al
promedio de los 4 anteriores lo copie en la fila de una matriz. 
    * Mostrar la matriz resultante.

Ejemplo: N=4
        2 8 3 2 1
        5 9 4 1 9             => Matriz = 5 9 4 1 9
        4 7 1 9 2                         7 1 3 6 8
        7 1 3 6 8

Nota: conviene almacenar los N vectores en un archivo de texto, un vector por línea y
procesar uno a uno sobre una misma variable de tipo vector. Una vez procesado (copiado
o no a la fila de la matriz) el siguiente se almacena sobre esa única variable.

*)

program T7_Ex_Ad02;

//{$codepage UTF8}

uses crt;

const
    M : byte = 5; { GLOBAL SCOOPE }

type
    TM = array[1..20,1..5] of real;
    TV = array[1..5]       of real;

{---------------------------------------------}
procedure Separador();

var
    i : byte;

begin
    WriteLn;
    for i:=1 to 40 do
        write('-');
    WriteLn;
    WriteLn;
end;


{---------------------------------------------}
procedure LeeArchGenMat(
    var Mat : TM;
    var i   : byte;
    nombre  : string
);

var
    j : byte;
    arch : text;

begin
    i := 0;
    Assign(arch, nombre);
    Reset(arch);
    while not eof(arch) do
            begin
            i := i + 1;
            for j:=1 to M do
                read(arch, Mat[i,j]);
            readln(arch);
            end;
    Close(arch);
end;


{---------------------------------------------}
procedure MostrarMatriz(
    Mat : TM;
    N   : byte
);

var
    i,j : byte;

begin
    for i:=1 to N do
        begin
        write(' |');
        for j:=1 to M do
            begin
            if j = M then
                TextColor(cyan);
            write(Mat[i,j]:6:1);
            end;
        TextColor(white);    
        write('|':4);
        WriteLn;
        end; {for i}
end; {procedure}


{---------------------------------------------}
function Promedio(
    Mat : TM;
    row : byte
):real;

var
    j   : byte;
    Aux : real;

begin
    Aux := 0;
    for j:=1 to M-1 do
        Aux := Aux + Mat[row,j];
    Promedio := Aux / (M-1);
end;


{---------------------------------------------}
function Verifica(
    Mat : TM;
    row   : byte
):boolean;

begin
    Verifica := FALSE;
    if Mat[row,M] > Promedio(Mat, row) then { 5to elemento mayor al promedio }
        Verifica := TRUE;
end;


{---------------------------------------------}
procedure GenerarArchivo(
    Mat : TM;
    N   : byte;
    V   : byte
);

var
    i,j : byte;
    arch : text;

begin
    V := 0;
    Assign(arch, 'T7_Ex_Ad02_V.txt');
    ReWrite(arch);
    for i:=1 to N do
        if Verifica(Mat, i) = TRUE then
            begin
            V := V + 1;
            for j:=1 to M do
                write(arch, Mat[i,j]:5:1);
            WriteLn(arch);
            end; {if}
    Close(arch);
end;


{---------------------------------------------}
var
    Mat  : TM;
    N    : byte;
    MatR : TM;   { Matriz Resultante }
    V    : byte;

begin
    ClrScr;
    WriteLn('Matriz: ');
    WriteLn;
    LeeArchGenMat(Mat, N, 'T7_Ex_Ad02_M.txt');
    MostrarMatriz(Mat, N);

    Separador;

    { Generar Archivo con los Vector que cumplen la condición }
    GenerarArchivo(Mat, N, V);
    
    LeeArchGenMat(MatR, V, 'T7_Ex_Ad02_V.txt');
    WriteLn('Matriz Resultante: ');
    WriteLn;
    MostrarMatriz(MatR, V);

    Separador;

    Write('FIN ');
    ReadLn;

end.