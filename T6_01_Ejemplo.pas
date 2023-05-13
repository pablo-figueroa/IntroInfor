(*
Ejemplo 1

A continuación se desarrolla un programa que utilizando funciones y procedimientos para
cada ítem:
    a. Lee un arreglo de enteros
    
    b. Calcula la suma de sus elementos
    c. Cuenta la cantidad de componentes pares
    d. Imprime las componentes que se encuentran en ubicaciones pares
    e. Imprime el mínimo
    
    f. Permite elegir por medio de un menú el/los proceso/s descriptos
*)

program Ej1;
//{$codepage UTF8}
uses crt;

TYPE
    TV=array[1..100] of integer;

{ INGRESAR VECTOR ----------------------------------------------------------------------------}
procedure LeeVector ( Var A : TV; Var N : byte);
Var
    i : byte;
Begin
    ClrScr;
    Write('Ingrese la cantidad de elementos del vector <= 100: ');
    Readln(N);
    For i:=1 to N do
        Begin
        Write('Ingrese el elemento ',i,' : ');
        Readln(A[i]);
        End;
    WriteLn;    
End;

{ ESCRIBIR VECTOR ----------------------------------------------------------------------------}
procedure EscVector ( V : TV; L : byte);
Var i : byte;
Begin
    TextColor(cyan);
    Write('VECTOR: ');
    For i := 1 to L do
        begin
        Write(V[i] : 5);
        end;
    WriteLn;
    TextColor(white);
End;

{ SUMAR --------------------------------------------------------------------------------------}
function Suma (A : TV; N: byte) : integer;
Var
    Sum : integer;
    i: byte;
Begin
    Sum:=0;
    for i:=1 to N do
        Sum:=Sum+ A[i];
    Suma := Sum;
End;

{ CONTAR PARES -------------------------------------------------------------------------------}
function CuentaPares (A : TV; N: byte) : byte;
Var
    i, Cont : byte;
Begin
    Cont:=0;
    for i:=1 to N do
    If Not Odd (A[i] ) then
        Cont:=Cont+ 1;
    CuentaPares := Cont;
End;

{ ESCRIBIR POSICION PAR ----------------------------------------------------------------------}
procedure EscPosPares ( A : TV; N : byte);
Var
    i : byte;
Begin
    i := 2;
    While i<= N do
        Begin
        Write(A[i] : 3);
        i := i +2;
        End;
End;

{ ENCONTRAR MINIMO ---------------------------------------------------------------------------}
function Minimo (A : TV; N: byte) : integer;
Var
    Min : integer;
    i:byte;
Begin
    Min:=A[1];
    for i:=2 to N do
    If A[i] < Min then
        Min:=A[i];
    Minimo := Min;
End;

{ MENU ---------------------------------------------------------------------------------------}
procedure Menu ( Var Op : Char);
Begin
    TextColor(white);
    Writeln('Menú de opciones');
    Writeln(' 1 - Suma los elementos del arreglo');
    Writeln(' 2 - Cuenta los elementos pares');
    Writeln(' 3 - Imprime los elementos de las posiciones pares');
    Writeln(' 4 - Calcula el mínimo');
    Writeln(' 5 - Fin');
    Repeat
        Write(' Ingrese su opción: ');
        Readln(Op);
        if Op = '5' then
            halt;
    Until ( '1' <= Op) and ( Op <= '4');
End;


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
VAR
    N : byte;
    A :TV;
    Op : char;

begin
    LeeVector(A, N);
    ClrScr;
    repeat
        EscVector(A, N);
        WriteLn;
        Menu(Op);
        TextColor(yellow);
        Case Op of
            '1': writeln('  La suma de los elementos del arreglo es: ', Suma(A, N));
            '2': writeln('  La cantidad de elementos pares del arreglo es: ', CuentaPares(A, N));
            '3': begin
                write('  Elementos en las posiciones pares del arreglo: '); 
                EscPosPares ( A , N );
                WriteLn;
                end;
            '4': writeln('  El mínimo del arreglo es: ', Minimo(A, N))
        End; {case}
        ReadLn;
        ClrScr;
    until Op = '5';
end.