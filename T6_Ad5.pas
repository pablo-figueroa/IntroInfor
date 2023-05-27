(*
---------------------------------- ADICIONAL 5 ----------------------------------

    Ingresar los elementos de un vector A y a continuación ingresar los de un vector B.

    Si la cantidad de componentes ingresadas para cada uno de los vectores no es la misma
indicar con un cartel y finalizar.

    De lo contrario calcular:
        
        a. La suma y la diferencia de los vectores.
        b. El producto escalar.
           ->  u.v = u1*v1 + u2*v2 + ... + un*vn, 
    
    EJEMPLO 1:
        Vector A = (  1.0  2.0  3.0  4.0 )
        Vector B = (  4.0  3.0  2.0  1.0 )
        ---------------------------------------------------
        SUMA es = (  5.0  5.0  5.0  5.0 )
        RESTA de A - B es = ( -3.0 -1.0  1.0  3.0 )
        RESTA de B - A es = (  3.0  1.0 -1.0 -3.0 )
        PRODUCTO ESCALAR: 20.00

*)

program T6_Ad5;
//{$codepage UTF8}

uses crt;

type
    TV_50_Real = array[1..50] of Real;


{-----------------------------------------------------------------------------}
procedure Titulo();
begin
    ClrScr;
    WriteLn('---------------------------------------------------');
    WriteLn('         SUMA, RESTA Y PRODUCTO ESCALAR');
    WriteLn('---------------------------------------------------');
    WriteLn;
end; {procedure Titulo}


{-----------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('---------------------------------------------------');
    WriteLn;
end;{procedure Separador}


{ INGRESAR VECTORES --------------------------------------------------------------------------}
procedure LeerVector
    (
        var V : TV_50_Real;
        N : byte
    );

var i : byte;

begin
    for i:=1 to N do
        begin
        gotoxy(1,7);
        ClrEol;
        Write('Ingresar elemento (',i,'): ');
        ReadLn(V[i]);
        end;{for}
end;{procedure}


{ MOSTRAR VECTORES ---------------------------------------------------------------------------}
procedure MostrarVector
    (
        V : TV_50_Real;
        N : byte
    );

var 
    i : byte;

begin
    for i:=1 to N do
        Write(V[i]:5:1);
end;{procedure}


{ SUMA DE VECTORES ---------------------------------------------------------------------------}
procedure CalcularSuma
(
        V1     : TV_50_Real;
        V2     : TV_50_Real;
        N      : byte;
        var VS : TV_50_Real
    );

var 
    i      : byte;

begin
        for i:=1 to N do
            VS[i] := V1[i] + V2[i];
end; {procedure}

{ RESTA DE VECTORES ---------------------------------------------------------------------------}
procedure CalcularResta
(
        V1     : TV_50_Real;
        V2     : TV_50_Real;
        N      : byte;
        var VR : TV_50_Real
    );

var 
    i  : byte;

begin
        for i:=1 to N do
            VR[i] := V1[i] - V2[i];
end; {procedure}
    

{ PRODUCTO ESCALAR ---------------------------------------------------------------------------}
function CalcularProductoEscalar
    (
        V1     : TV_50_Real;
        V2     : TV_50_Real;
        N      : byte
    ):real;

var 
    i   : byte;
    Aux : real;

begin
    Aux := 0;
    for i:=1 to N do
        Aux := Aux + (V1[i] * V2[i]);
    CalcularProductoEscalar := Aux;
end; {procedure}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    VectorA : TV_50_Real;
    A       : byte;
    VectorB : TV_50_Real;
    B       : byte;
    N       : byte;

    VectorSuma      : TV_50_Real;
    VectorRestaAB   : TV_50_Real;
    VectorRestaBA   : TV_50_Real;
    ProductoEscalar : real;

begin readln;
    Titulo;
    Write('Ingresar cantidad de elementos del VECTOR A [1..50] : ');
    ReadLn(A);
    LeerVector(VectorA,A);
    
    Titulo;
    Write('Ingresar cantidad de elementos del VECTOR B [1..50] : ');
    ReadLn(B);
    LeerVector(VectorB,B);
    
    Separador;

    Titulo;
    
    Write('Vector A = (');
    MostrarVector(VectorA,A);
    WriteLn(')':2);
    WriteLn;

    Write('Vector B = (');
    MostrarVector(VectorB,B);
    WriteLn(')':2);
    WriteLn;

    Separador;

    if A = B then
        begin
        N := A;
        { SUMA }
        CalcularSuma (VectorA, VectorB, N, VectorSuma);
        Write('SUMA es = (');
        MostrarVector(VectorSuma, N);
        WriteLn(')':2);
        WriteLn;

        { RESTA A - B }
        CalcularResta(VectorA, VectorB, N, VectorRestaAB);
        Write('RESTA de A - B es = (');
        MostrarVector(VectorRestaAB, N);
        WriteLn(')':2);
        WriteLn;

        { RESTA B - A }    
        CalcularResta(VectorB, VectorA, N, VectorRestaBA);
        Write('RESTA de B - A es = (');
        MostrarVector(VectorRestaBA, N);
        WriteLn(')':2);
        WriteLn;

        { PRODUCTO ESCALAR }
        ProductoEscalar := CalcularProductoEscalar(VectorA, VectorB, N);
        WriteLN('PRODUCTO ESCALAR: ',ProductoEscalar:0:2);
        end
    else
        begin
        WriteLn('No es posible calcular: Suma, Resta y Producto Escalar.-');
        WriteLn('Los vectores tienen distintas dimensiones.-');
        end;
    WriteLn;
    ReadLn;
end.