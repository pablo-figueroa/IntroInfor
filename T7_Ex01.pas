(*
EJERCICIO 1

Ingresar una matriz de N x M de enteros.
Resolver mediante procedimientos o funciones los siguientes
puntos y mostrar el resultado:

    a. Dado un número, calcular cuantas veces se repite (puede no estar).
    b. Indicar cuántos elementos son nulos, positivos y negativos.
    c. Intercambiar la fila K con la fila H (K y H menor o igual que N)

EJEMPLO:

    a. num:  5 -> El número 5 no aparece en la matriz.
       num:  0 -> Aparece   : 1
       num:  0 -> Se repite : 0

    b. Positivos : 5
       Negativos : 3
       Ceros     : 1

    c. Intercambiar:
        Fila K: 2
        Fila H: 1
       |  1   0   1 |
       | -1  -1  -1 |
       |  2   2   2 |
*)

program T7_Ex01;

{$codepage UTF8}

uses crt;

type
    TM = array[1..20,1..20] of integer;

{---------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('------------------------------------------------------------');
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
 { a. Dado un número, calcular cuantas veces se repite (puede no estar). }
function Aparece (
    Mat : TM;
    N   : byte;
    M   : byte;
    Num : integer
):byte;

var
    i    : byte;
    j    : byte;
    Cont : byte; { Auxiliar }

begin
    Cont := 0;
    for i:=1 to N do
        for j:=1 to M do
            if Num = Mat[i,j] then
                Cont := Cont + 1;

    Aparece := Cont;
end;


{---------------------------------------------------------------------------------------}
{ b. Indicar cuántos elementos son nulos, positivos y negativos. }
procedure Signo (
    Mat      : TM;
    N        : byte;
    M        : byte;
    var Pos  : byte;
    var Neg  : byte;
    var Cero : byte
);

var
    i     : byte;
    j     : byte;
    ContP : byte;
    ContN : byte;

begin
    ContP := 0;
    ContN := 0;
    for i:=1 to N do
        for j:=1 to M do
            if Mat[i,j] > 0 then
                ContP := ContP + 1
            else
                if Mat[i,j] < 0 then
                    ContN := ContN + 1;

    Pos  := ContP;
    Neg  := ContN;
    Cero := (M * N) - (Pos + Neg);

end;

{---------------------------------------------------------------------------------------}
{c. Intercambiar la fila K con la fila H (K y H menor o igual que N)}
procedure IntercambiarFilas (
    var Mx  : TM;
    M, K, H : byte
);

var
    j : byte;
    Aux : TM;

begin
        for j:=1 to M do
            Aux[K,j] := Mx[K,j];

        for j:=1 to M do
            Mx[K,j] := Mx[H,j];

        for j:=1 to M do
            Mx[H,j] := Aux[k,j];
end;


{PROGRAMA PRINCIPAL --------------------------------------}
var
    Mx   : TM;
    N    : byte;
    M    : byte;
    Apar : byte;
    Num  : integer;

    Pos  : byte;
    Neg  : byte;
    Cero : byte;

    K    : byte;
    H    : byte;

begin
    LeerMatriz(Mx, N, M);
    ClrScr;

    WriteLn('Matriz Ingresada: ');
    Writeln;
    MostrarMatriz(Mx, N, M);

    Separador;

    Write('Ingrese un número para calcular cuantas veces se repite: ');
    readLn(Num);
    Apar := Aparece(Mx, N, M, Num);
    if Apar = 0 then
        WriteLn('  El número ',num,' no aparece en la matriz.')
    else
        begin
        WriteLn('  Aparece   : ',Apar);
        WriteLn('  Se repite : ',Apar-1);
        end;

    Separador;

    Signo(Mx, N, M, Pos, Neg, Cero);
    WriteLn('Cantidad de elementos: ');
    WriteLn('  Positivos : ',Pos);
    WriteLn('  Negativos : ',Neg);
    WriteLn('  Ceros     : ',Cero);

    Separador;


    WriteLn('Intercambio de Filas');
    WriteLn('  Ingrese dos filas que desee intercambiar');

    repeat
        Write('  Fila k: ');
        readln(K);
    until k <= N;

    repeat
        Write('  Fila H: ');
        readln(H);
            if H = k then
                Writeln('Ha ingresado la misma Fila K');
    until (k <= N) and (K <> H);

    IntercambiarFilas(Mx, M, K, H);

    Writeln;
    WriteLn('Matriz de Filas Intercambiadas:');
    Writeln;
    MostrarMatriz(Mx, N, M);

    Separador;

    ReadLn;

end.