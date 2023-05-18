(*
----------------------------------------- EJERCICIO 10 -----------------------------------------

Ingresar un número real X y a continuación N números reales,
luego evaluar si X se encuentra entre los N números (no están ordenados).

Informar:
- Si lo encuentra:
    a. el mensaje "el número pertenece al conjunto"
    b. la cantidad de veces que figura
    c. los lugares que ocupa dentro del conjunto de números

- Si no lo encuentra el mensaje "el número no pertenece al conjunto".

EJEMPLO:

    X = -2
    Longitud del Vector: 4
    Vector Ingresado: [  -2  1  -2  3  ]

    El número -2.0 pertenece al conjunto.-
    Cantidad de veces que figura: 2
    Lugares que ocupa: [  1  3  ]

*)

program T6_Ej10;

{$codepage UTF8}

uses crt;

type
    TV_50_Real = array[1..50] of Real;
    TV_50_Byte = array[1..50] of Byte;


{ TITULO -------------------------------------------------------------------------------------}
procedure Titulo();
begin
    ClrScr;
    WriteLn('--------------------------------------');
    WriteLn('PERTENENCIA DE X AL CONJUNTO DE REALES');
    WriteLn('--------------------------------------');
    WriteLn;
end; {procedure Titulo}


{ SEPARADOR ----------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    TextColor(yellow);
    WriteLn('----------------------------------------------------------');
    WriteLn;
    TextColor(white);
end;{procedure Separador}


{ LEER VECTOR --------------------------------------------------------------------------------}
procedure LeerVector
    (
        var VectorR : TV_50_Real;
        var N       : byte
    );

var 
    i : byte;

begin

    repeat
        Titulo;
        TextColor(yellow);
        Write('Ingrese longitud del vector: ');
        TextColor(white);
        ReadLn(N);
    until N > 0;
    ClrScr;
    for i:=1 to N do begin
        Titulo;
        TextColor(cyan);
        Write('Ingresar Real de la posición ',i,': ');
        TextColor(white);
        ReadLn(VectorR[i]);
    end; {for}

end;{procedure LeerVector}


{ MOSTRAR VECTOR REAL ------------------------------------------------------------------------}
procedure MostrarVectorReal
    (
        Vector  : TV_50_Real;
        N       : byte
    );

var i : byte;

begin
    for i:=1 to N do
        Write(Vector[i]:0:1,'  ');
end; {procedure}


{ MOSTRAR VECTOR BYTE ------------------------------------------------------------------------}
procedure MostrarVectorByte
    (
        Vector  : TV_50_Byte;
        N       : byte
    );

var i : byte;

begin
    for i:=1 to N do
        Write(Vector[i],'  ');
end; {procedure}


{ ANALISIS E INFORME DEL VECTOR --------------------------------------------------------------}
procedure InformeX
    (
        VectorR     : TV_50_Real;
        N           : byte;
        X           : Real;
        var VectorL : TV_50_Byte; { Vector Lugares que ocupa X } {byte pero proc Mostrar es Real -> Hacer otro}
        var L       : byte        { La cantidad de veces que X es la longitud del Vector }
    );

var
    i : byte;

begin
    L := 0;
    for i:=1 to N do
        begin
        if X = VectorR[i] then
            begin
            L := L + 1;
            VectorL[L] := i;
            end; {if}
        end; {for}
end; {procedure}


{ PROGRAMA PRINCIPAL}
var
    VectorR : TV_50_Real;
    N       : byte;
    X       : Real;

    VectorL : TV_50_Byte;
    L       : byte;

    S       : char;

begin
    repeat
        Titulo;
        Write('Ingresar un Número Real "X": ');
        ReadLn(X);

        LeerVector(VectorR,N);

        gotoxy(1,5);
        ClrEol;
        Write('Vector Ingresado: [  ');
        MostrarVectorReal(VectorR,N);
        WriteLn(']');
        Separador;

        InformeX(VectorR,N,X,VectorL,L);
        if L > 0 then
            begin
            WriteLn('El número ',X:0:1,' pertenece al conjunto.-');
            WriteLn;
            WriteLn('Cantidad de veces que figura: ',L);
            WriteLn;
            Write('Lugares que ocupa: [  ');
            MostrarVectorByte(VectorL,L);
            WriteLn(']');
            end
        else
            WriteLn('El número no pertenece al conjunto.-');

        Separador;

        TextColor(red);
        Write('Enter para reiniciar | S -> Salir ');
        TextColor(white);
        S := ReadKey;
        S := UpCase(S);
    until (S = 'S');
end.