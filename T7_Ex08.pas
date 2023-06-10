(*
EJERCICIO 8.

Sean T1 y T2 dos matrices de NxN que representan las fichas (rojas, azules) de un tablero.
La primera, T1, almacena el carácter ´R´ o ´A´
La segunda, T2, enteros (cantidad de fichas -> NATURALES). 

Se pide calcular e informar:
    a. Color predominante (presente en mas casillas)
    b. Color con más fichas
    c. Cantidad de columnas de un solo color

EJEMPLO:

    R	A	A	A		2	1	2	2
    R	R	R	R		1	2	3	2
    R	A	R	A		1	2	3	1
    R	A	A	R		1	1	9	2

    a. Rojas    :  9
    b. Azules   : 18
    c. Cantidad :  1

*)

program T7_Ex08;

//{$codepage UTF8}

uses crt;

type
    TM_Char = array[1..10,1..10] of char;
    TM_Byte = array[1..10,1..10] of byte;
    

procedure Separador();
begin
    WriteLn;
    WriteLn('-------------------------------------------------');
    WriteLn;
end;{procedure}


{---------------------------------------------------------------------------------------}
function DeterminarN (
    Mat : TM_Char
):byte;

var
    i    : byte;
    arch : text;

begin
    i := 0;
    Assign(arch, 'T7_Ex08_T1.txt');
    Reset(arch);
    while not Eof(arch) do
        begin
        i := i + 1;
        ReadLn(arch);
        end; {while}
    Close(arch);
    DeterminarN := i;
end;

{---------------------------------------------------------------------------------------}
procedure LeerMatrices (
    var Mat1 : TM_Char;
    var Mat2 : TM_Byte;
    N        : byte
);

var
    i, j : byte;
    
    arch1 : text;
    arch2 : text;
    
    Aux : char;

begin
    Assign(arch1, 'T7_Ex08_T1.txt');
    Assign(arch2, 'T7_Ex08_T2.txt');
    Reset(arch1);
    Reset(arch2);
    
    for i:=1 to N do
        begin
        for j:=1 to N do
            begin
            read(arch1, Mat1[i,j], Aux);
            read(arch2, Mat2[i,j]);
            end;
        ReadLn(arch1);
        ReadLn(arch2);
        end;
    Close(arch1);
    Close(arch2);
end;


{---------------------------------------------------------------------------------------}
procedure MostrarT1 (
    Mat : TM_Char;
    N   : byte
);

var
    i : byte;
    j : byte;

begin
    for i:=1 to N do
        begin
        write('  | ');
        for j:=1 to N do
            if Mat[i,j] = 'R' then
                begin
                TextColor(red);
                write(Mat[i,j],' ');
                TextColor(white);
                end
            else
                begin
                TextColor(blue);
                write(Mat[i,j],' ');
                TextColor(white);
                end;
        WriteLn('|');
        end;
end;

{---------------------------------------------------------------------------------------}
procedure MostrarT2 (
    Mat1 : TM_Char;
    Mat2 : TM_Byte;
    N    : byte
);

var
    i : byte;
    j : byte;

begin
    for i:=1 to N do
        begin
        write('  | ');
        for j:=1 to N do
            if Mat1[i,j] = 'R' then
                begin
                TextColor(red);
                write(Mat2[i,j],' ');
                end
            else
                begin
                TextColor(blue);
                write(Mat2[i,j],' ');
                end;
        TextColor(white);    
        WriteLn('|');
        end;
end;

{---------------------------------------------------------------------------------------}
{ a. Color predominante (presente en mas casillas) }
function ColorPredominante (
    Mat : TM_Char;
    N   : byte
):byte;

var
    i     : byte;
    j     : byte;
    contR : byte;
begin
    ContR := 0;
    for i:=1 to N do
        for j:=1 to N do
            if Mat[i,j] = 'R' then
                ContR := ContR + 1;
    
    { Rojo    = 1 }
    { Azul    = 2 }
    { Iguales = 0 }
    if ContR > ((N*N)/2) then
        ColorPredominante := 1
    else
        if ContR < ((N*N)/2) then
            ColorPredominante := 2
        else
            ColorPredominante := 0
end;


{---------------------------------------------------------------------------------------}
{ b. Color con más fichas }
function ColorFichas (
    Mat1 : TM_Char;
    Mat2 : TM_Byte;
    N    : byte
):byte;

var
    i     : byte;
    j     : byte;
    AcumR : byte;
    AcumA : byte;
    
begin
    AcumR := 0;
    AcumA := 0;
    for i:=1 to N do
        for j:=1 to N do
            if Mat1[i,j] = 'R' then
                AcumR := AcumR + Mat2[i,j]
            else
                AcumA := AcumA + Mat2[i,j];

    { Rojo    = 1 }
    { Azul    = 2 }
    { Iguales = 0 }
    if AcumR > AcumA then
        ColorFichas := 1
    else
        if AcumR < AcumA then
            ColorFichas := 2
        else
            ColorFichas := 0
end;


{---------------------------------------------------------------------------------------}
{ c. Cantidad de columnas de un solo color }
function ColorColumna (
    Mat : TM_Char;
    N   : byte
):byte;

var
    i     : byte;
    j     : byte;
    ContR : byte;
    Acum  : byte;

begin
    
    Acum  := 0;
    for i:=1 to N do
        begin
        ContR := 0;
        for j:=1 to N do
            if Mat[j,i] = 'R' then
                ContR := ContR + 1;
        
        if ContR = N then
            Acum := Acum + 1
        else
            if ContR = 0 then
                Acum := Acum + 1;
        end;        

    ColorColumna := Acum;
end;


{---------------------------------------------------------------------------------------}
{PROGRAMA PRINCIPAL}
var
    T1 : TM_Char;
    T2 : TM_Byte;
    N  : byte;
    
    ColourP : byte; { a. Color predominante (presente en mas casillas) }
    ColourF : byte; { b. Color con más fichas }
    ColourC : byte; { c. Cantidad de columnas de un solo color }
    

begin
    ClrScr;
    TextColor(red);
    WriteLn('SUPUESTO: No me dan la dimensión de la Matriz.');
    TextColor(white);
    WriteLn;
    WriteLn('Sabiendo que ambas son cuadradas y ');
    WriteLn('de la misma dimensión:');
    Write('  Determino la dimensión en N = ');
    N := DeterminarN(T1);
    WriteLn(N);

    WriteLn;
    TextColor(red);
    Write('ENTER para continuar... ');
    TextColor(white);
    ReadLn;
    
    ClrScr;
    
    { Lectura y Muestra de Matrices }
    LeerMatrices(T1, T2, N);

    WriteLn('MOSTRANDO LAS MATRICES:');
    WriteLn;
    
    WriteLn(' Matriz T1: ');
    MostrarT1(T1, N);
    
    Writeln;
    
    WriteLn(' Matriz T2: ');
    MostrarT2(T1, T2, N);

    Separador;

    { a. Color predominante (presente en mas casillas) }
    ColourP := ColorPredominante(T1, N);
    Write(' a. Color Predominante: ');
    if ColourP = 1 then
        begin
        TextColor(red);
        writeLn('ROJO');
        TextColor(white);
        end
    else
        if ColourP = 2 then
            begin
            TextColor(blue);
            writeLn('AZUL');
            TextColor(white);
            end
        else
            writeLn('EMPATE');
    
    Separador;

    { b. Color con más fichas }
    ColourF := ColorFichas(T1, T2, N);
    Write(' b. Color con más fichas: ');
    if ColourF = 1 then
        begin
        TextColor(red);
        writeLn('ROJO');
        TextColor(white);
        end
    else
        if ColourF = 2 then
            begin
            TextColor(blue);
            writeLn('AZUL');
            TextColor(white);
            end
        else
            writeLn('EMPATE');
    
    Separador;

    { c. Cantidad de columnas de un solo color }
    ColourC := ColorColumna(T1, N);
    WriteLn(' c. Cantidad de columnas de un solo color: ',ColourC);
    
    Separador;

    WriteLn('| FIN |');

end.