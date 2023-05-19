(*
----------------------------------------- EJERCICIO 13 -----------------------------------------

Dado un arreglo de enteros, eliminar el máximo elemento, suponer único.

*)

program T6_Ej13;

//{$codepage UTF8}

uses crt;

type
  TV_10_Int8 = array[1..5] of Int8; { desde -128 hasta 127 }


{---------------------------------------------------------------------------------------------}
procedure Titulo();

begin
    ClrScr;
    WriteLn('-------------------------------------------------');
    WriteLn('ELIMINAR EL NUMERO MAXIMO DE UN VECTOR DE ENTEROS');
    WriteLn('-------------------------------------------------');
    WriteLn('               Supuesto: El valor máximo es único');
    WriteLn;
    WriteLn;
end;

{---------------------------------------------------------------------------------------------}
procedure LeerVector
    (
        var Vector: TV_10_Int8;
        N: byte
    );

var
    i   : byte;
    Num : Int16; { Para validar entrada debo ir a un conjunto mayor }

begin
    for i := 1 to N do
        begin
        repeat
            Titulo;
            write('Para el rango: [',low(Int8),' ; ',high(Int8),'] -> Ingrese Entero (',i,' de ',N,') : ');
            ReadLn(Num);
        until (Num >= low(Int8)) and (Num <= high(Int8));
        Vector[i] := Num;
        end;
end;


{---------------------------------------------------------------------------------------------}
procedure MostrarVector
    (
        V : TV_10_Int8;
        N : byte
    );

var
    i: byte;

begin
    for i := 1 to N do
        Write(V[i],'  ');
end;


{---------------------------------------------------------------------------------------------}
function EncontrarPosMax
    (
        V : TV_10_Int8;
        N : byte
    ):Byte;

var
    i      : byte;
    NumMax : Int8; { Número Máximo }
    PosMax : Int8; { Posición que ocupa el Número Máximo }

begin
    NumMax := low(Int8); { es decir -> -128 }
    for i := 1 to N do
        begin
        if V[i] > NumMax then
            begin
            NumMax := V[i];
            PosMax := i;
            end;
        end; {for}
    EncontrarPosMax := PosMax;
end;{function}


{---------------------------------------------------------------------------------------------}
procedure EliminarNumMax
    (
        var V  : TV_10_Int8;
        var N  : byte;
        PosMax : byte
    );

var
    i : byte;

begin
    for i := PosMax to N - 1 do                  { y posmax está en N ?}
        V[i] := V[i + 1];
    N := N - 1;
end;


{ SEPARADOR ----------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('------------------------------------------------------');
    WriteLn;
end;{procedure Separador}

{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    Vector : TV_10_Int8;
    N      : byte;
    PosMax : byte;

    S      : char;

begin 
    repeat
        N := 5;  
        Titulo;

        LeerVector(Vector, N);

        Titulo;
        
        Write('Vector Ingresado: [  ');
        MostrarVector(Vector, N);
        WriteLn(']');

        Separador;

        PosMax := EncontrarPosMax(Vector, N);
        writeln('El Máximo está en el lugar: ',PosMax);

        Separador;

        EliminarNumMax(Vector, N, PosMax);
        Write('Vector después de eliminar el máximo: [  ');
        MostrarVector(Vector, N);
        WriteLn(']');

        Separador;

        TextColor(red);
        Write('Enter -> Intentar otro Vector | S -> Salir ');
        TextColor(white);
        S := ReadKey;
        S := UpCase(S);

    until (S = 'S');
end.