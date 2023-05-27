program TP_Arreglos; { EJEMPLOS Y ENUNCIADO AL FINAL, en ese orden. }

type
    TV_50_Int = array[1..50] of integer;

{-----------------------------------------------------------------------------}
procedure LeerVector (var V: TV_50_Int; var N: byte);
var 
    i    : byte;
    Arch : text;
begin
    Assign(Arch, 'Datos.txt');
    Reset(Arch);
    i := 0;
    while not eof(Arch) do
        begin
        i := i + 1;
        Readln(arch, V[i]);
        end;{while}
    N := i;
    Close(Arch);
end;{procedure}
{-----------------------------------------------------------------------------}
procedure MostrarVector(V: TV_50_Int; N: byte);
var i : byte;
begin
    for i:=1 to N do
        write(V[i],'  ');
end;{procedure}
{-----------------------------------------------------------------------------}
function CalcularMaximo(V: TV_50_Int; N: byte):integer;
var 
    i   : byte;
    Max : integer;
begin
    Max := -9999;
    for i:=1 to N do
        if V[i] > Max then
            Max := V[i];
    CalcularMaximo := Max;
end;{function}
{-----------------------------------------------------------------------------}
procedure GenerarArreglo_B(VA: TV_50_Int; Max: integer; var VB: TV_50_Int; var N: byte);
var
    i,j : byte;
begin
    j := 0;
    for i:=1 to N do
        if (VA[i] <> 0) and (Max mod VA[i] = 0) then { La div. por 0 es una indeterminación }
            begin
            j := j + 1;
            VB[j] := VA[i];
            end;
    N := j;
end; {procedure}
{-----------------------------------------------------------------------------}
function CalcularPromedio(VB: TV_50_Int; N: byte):real;
var 
    i    : byte;
    Acum : integer;
begin
    Acum := 0;
    for i:=1 to N do
        Acum := Acum + VB[i];
    CalcularPromedio := Acum / N;
end; {function}
{-----------------------------------------------------------------------------}
{ PROGRAMA PRINCIPAL }
var
    V_Arreglo_A, V_Arreglo_B : TV_50_Int;
    N   : byte;
    Max : integer;

begin
    WriteLn('-------------');
    WriteLn('TP - ARREGLOS');
    WriteLn('-------------');
    Writeln;

    { Lectura del archivo y generación del Arreglo A}
    LeerVector(V_Arreglo_A, N);

    { Mostrar el Arreglo A }
    Write('A = (  ');
    MostrarVector(V_Arreglo_A, N);
    WriteLn(')');
    WriteLn;

    { Calcular y Mostrar el Máximo del Arreglo A }
    Max := CalcularMaximo(V_Arreglo_A, N);
    WriteLn('Maximo: ',Max);
    WriteLn;

    { Generar y Mostrar el Arreglo B }
    GenerarArreglo_B(V_Arreglo_A, Max, V_Arreglo_B, N);
    Write('B = (  ');
    MostrarVector(V_Arreglo_B, N);
    WriteLn(')');
    WriteLn;

    { Calcular y Mostrar el promedio del Arreglo B }
    WriteLn('Promedio: ',CalcularPromedio(V_Arreglo_B, N):0:2);

    ReadLn;
end.

(*

EJEMPLO 1:
    A = (  17  1  2  3  4  5  6  7  8  9  ) 
    Maximo: 17
    B = (  17  1  )
    Promedio: 9.00

EJEMPLO 2: un cero en el archivo:
    A = (  0  25  -5  -1  2  1  5  )
    Maximo: 25
    B = (  25  -5  -1  1  5  )
    Promedio: 5.00

EJEMPLO 3: el cero como máximo:
    A = (  0  -1  -2  -3  -4  -5  )
    Maximo: 0
    B = (  -1  -2  -3  -4  -5  )
    Promedio: -3.00
*)

(*

TP (Trabajo Practico) : Arreglos

Se debe entregar:
    ➢ Programa en Pascal (.PAS)

Ejercicio:
    Dado un archivo de enteros, 
    leerlos en un arreglo A, 
    obtener el promedio de todos los números divisores del máximo y 
    con ellos armar otro arreglo B.

    Mostrar ambos arreglos (A y B), el máximo y el promedio.

    Ejemplo:
    A = (5, 7, 1, 12, 15, -8, 10, 2, 25, 26, 50, 13)
    Máximo = 50                 { Máximo de los elementos de A }
    B = ( 5, 1, 10, 2, 25, 50 ) { B = Elementos de A que son divisores del máximo elemento de A}
    Promedio = 15.5             { Promedio de los elementos de B }

    NOTA: Resolver el enunciado haciendo un programa eficaz, eficiente y
          correctamente indentado, modularizado y parametrizado.

*)