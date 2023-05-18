(*
----------------------------------------- EJERCICIO 11 -----------------------------------------

Idem 10 pero suponer que los números están ordenados en forma ascendente.

    EJERCICIO 10
        Ingresar un número real X y a continuación N números reales,
        luego evaluar si X se encuentra entre los N números (no están ordenados).

        Informar:
        - Si lo encuentra:
            a. el mensaje "el número pertenece al conjunto"
            b. la cantidad de veces que figura
            c. los lugares que ocupa dentro del conjunto de números

        - Si no lo encuentra el mensaje "el número no pertenece al conjunto".

------------------------------------------------------------------------------------------
EJEMPLO 1:

    X = -1.1
    Longitud del Vector: 6
    Vector (R) Ingresado: [  -3.3  -2.2  -1.1  0  1.1  2.2  ]

    El número -2.0 pertenece al conjunto.-
    Cantidad de veces que figura: 1
    Lugar (N) que ocupa: [  3  ]
------------------------------------------------------------------------------------------
EJEMPLO 2:

    X = 3
    Longitud del Vector: 6
    Vector (R) Ingresado: [  1  2  3  3  4  5  ]

    El número 3.0 pertenece al conjunto.-
    Cantidad de veces que figura: 2
    Lugar (N) que ocupa: [  3  4  ]

------------------------------------------------------------------------------------------
¿debe recorrer siempre el arreglo hasta el final? RTA. -> NO

*)

program T6_Ej11;
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
    WriteLn('-------------------------------------------------------');
    WriteLn;
    TextColor(white);
end;{procedure Separador}


{ LEER VECTOR --------------------------------------------------------------------------------}
procedure LeerVector
    (
        var VectorR : TV_50_Real;
        var N       : byte
    );

var i : byte;

begin
    repeat
        Titulo;
        TextColor(yellow);
        Write('Ingrese longitud del vector: ');
        TextColor(white);
        ReadLn(N);
    until N > 0;

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
        if Vector[i] = Trunc(Vector[i]) then
            Write(Vector[i]:0:0,'  ')
        else
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
    i := 1;
    while (i <= N) and (X >= VectorR[i]) do
        begin
        i := i + 1;
        if X = VectorR[i] then
            begin
            L := L + 1;
            VectorL[L] := i;
            end;
        end;{while}
end;{procedure}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
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
        Write('Vector (R) Ingresado: [  ');
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
            Write('Lugares (N) que ocupa: [  ');
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