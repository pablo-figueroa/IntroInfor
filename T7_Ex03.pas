(*
EJERCICIO 3

Dada una matriz A de NxM elementos reales, 
se desea generar un arreglo lineal B con los
elementos de la matriz A que cumplan:

A[fila, columna] <= 0 para fila impar y columna impar ó
A[fila, columna] > 0 para fila par y columna par

EJEMPLO 1:
  |  -1.0   0.0  |
  |   0.0   1.0  |
  Arreglo B -> (  -1.0  1.0  )

EJEMPLO 2:
    |  -1.0   0.0  -2.0   0.0  |
    |   0.0   1.0   0.0   2.0  |
    |  -3.0   0.0  -4.0   0.0  |
    Arreglo B -> (  -1.0  -2.0  1.0  2.0  -3.0  -4.0  )
       
*)

program T7_Ex02;

//{$codepage UTF8}

uses crt;

type
    TM = array[1..10,1..10] of real;
    TV = array[1..50] of real; { Largo Máximo Posible: =redondear.mas((N*M)/2;0) }


{---------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('--------------------------------------------------------');
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
            write(Mat[i,j]:6:1);
            end;
        WriteLn('  |');
        end;
end;


{---------------------------------------------------------------------------------------}
procedure MostrarMatrizColor (
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
            { fila impar y col impar -> color amarillo }
            if (i mod 2 <> 0) and (j mod 2 <> 0) then
                begin
                TextColor(yellow);
                write(Mat[i,j]:6:1);
                TextColor(white);
                end
            else
                { fila par y col par -> color amarillo }
                if (i mod 2 = 0) and (j mod 2 = 0) then
                    begin
                    TextColor(yellow);
                    write(Mat[i,j]:6:1);
                    TextColor(white);
                    end
            else
                write(Mat[i,j]:6:1);
            end;
        WriteLn('  |');
        end;
end;


{---------------------------------------------------------------------------------------}
procedure MostrarMatrizColorCumple (
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
            { fila impar y col impar y cumple -> color verde }
            if (i mod 2 <> 0) and (j mod 2 <> 0) and (Mat[i,j] <= 0) then
                begin
                TextColor(green);
                write(Mat[i,j]:6:1);
                TextColor(white);
                end
            else
                { fila par y col par y cumple -> color verde }
                if (i mod 2 = 0) and (j mod 2 = 0) and (Mat[i,j] > 0) then
                    begin
                    TextColor(green);
                    write(Mat[i,j]:6:1);
                    TextColor(white);
                    end
            else
                write(Mat[i,j]:6:1);
            end;
        WriteLn('  |');
        end;
end;


{---------------------------------------------------------------------------------------}
procedure ArregloLinealB (
    Mat  : TM;
    N, M : byte;
    
    var V : TV;
    var P : byte
);

var
    i,j,k : byte;

begin
    k := 0;
    for i:=1 to N do
        for j:=1 to M do
            if (i mod 2 <> 0) and (j mod 2 <> 0) and (Mat[i,j] <= 0) then
                begin
                k := k + 1;
                V[k] := Mat[i,j];
                end
            else
                if (i mod 2 = 0) and (j mod 2 = 0) and (Mat[i,j] > 0) then
                    begin
                    k := k + 1;
                    V[k] := Mat[i,j];
                    end;
    P := k;
end;

{---------------------------------------------------------------------------------------}
procedure MostrarVector (
    V : TV;
    P : byte
);

var
    i : byte;

begin
    write('(  ');
    for i:=1 to P do
        write(V[i]:0:1,'  ');
    writeLn(')')    ;
end;


{---------------------------------------------------------------------------------------}
{PROGRAMA PRINCIPAL}
var
    Mat  : TM;
    N    : byte;
    M    : byte;

    Vector : TV;
    P      : byte; { para longitud del Vector }

begin
    LeerMatriz(Mat, N, M);
    ClrScr;

    WriteLn('Matriz Ingresada: ');
    Writeln;
    MostrarMatriz(Mat, N, M);

    Separador;

    ArregloLinealB(Mat, N, M, Vector, P);
    TextColor(yellow);
    WriteLn('Elementos de la Matriz ha analizar:');
    TextColor(white);
    WriteLn;
    MostrarMatrizColor(Mat, N, M);
    WriteLn;

    TextColor(green);
    WriteLn('Elementos de la Matriz que cumplen:');
    TextColor(white);
    WriteLn;
    MostrarMatrizColorCumple(Mat, N, M);
    WriteLn;

    TextColor(green);
    Write('  Arreglo B -> ');
    
    MostrarVector(Vector, P);
    TextColor(white);

    Separador;

    Write('FIN  ');
    ReadLn;

end.