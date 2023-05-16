(*
----------------------------------------- EJERCICIO 6 -----------------------------------------

    Ingresar los elementos de un vector A y a continuación ingresar los de un vector B.

    Si la cantidad de componentes ingresadas para cada uno de los vectores no es la misma
indicar con un cartel y finalizar.

    De lo contrario calcular:
        
        a. La suma y la diferencia de los vectores.
        b. El producto escalar.
           ->  u.v = u1*v1 + u2*v2 + ... + un*vn, 
    
    EJEMPLO 1:
        Vector A : 1  2  3
        Vector B : 4  5  6

        SUMA     : 5  7  9
        RESTA    :-3 -3 -3

        PROD ESC : 32

    EJEMPLO 2:
        Vector A : 2.1  4.2  6.3
        Vector B : 1.5  5.5  9.5

        SUMA     : 3.6  9.7 15.8
        RESTA    : 0.6 -1.3 -3.2

        PROD ESC : 86.1
*)

program T6_Ej06;
//{$codepage UTF8}
uses crt;

type
    TV_10_Real = array[1..10] of Real;


{ INGRESAR VECTORES --------------------------------------------------------------------------}
procedure LeerVectores
    (
        var VectorA : TV_10_Real;
        var A       : byte;
        var VectorB : TV_10_Real;
        var B       : byte
    );

var i : byte;

begin
    ClrScr;
    Write('Ingresar cantidad de elementos del VECTOR A [1..10] : ');
    ReadLn(A);
    for i:=1 to A do
        begin
        gotoxy(1,2);
        ClrEol;
        Write('Ingresar elemento (',i,'): ');
        ReadLn(VectorA[i]);
        end;{for}

    Write('Ingresar cantidad de elementos del VECTOR B [1..10] : ');
    ReadLn(B);
    for i:=1 to B do
        begin
        gotoxy(1,4);
        ClrEol;
        Write('Ingresar elemento (',i,'): ');
        ReadLn(VectorB[i]);
        end;{for}
    
end;{procedure}


{ MOSTRAR VECTORES ---------------------------------------------------------------------------}
procedure MostrarVectores
    (
        VectorA : TV_10_Real;
        A       : byte;
        VectorB : TV_10_Real;
        B       : byte
    );

var i : byte;

begin
    Write('Vector A: ');
    for i:=1 to A do
        begin
        Write(VectorA[i]:5:1);
        end;{for}
    WriteLn;
    WriteLn;
    
    Write('Vector B: ');
    for i:=1 to B do
        begin
        Write(VectorB[i]:5:1);
        end;{for}
    WriteLn;
end;{procedure}


{ SUMA DE VECTORES ---------------------------------------------------------------------------}
procedure VectorSumaResta
(
        VectorA : TV_10_Real;
        A       : byte;
        VectorB : TV_10_Real;
        B       : byte
    );

var 
    i      : byte;
    VSuma  : TV_10_Real;
    VResta : TV_10_Real;

begin
    { LA SUMA }
    if A = B then
        begin
        Write('El Vector Suma es  (A+B): ');
        for i:=1 to A do
            begin
            VSuma[i] := VectorA[i] + VectorB[i];
            Write(VSuma[i]:6:1);
            end;{for}
        WriteLn;
        end
    else
        WriteLn('Dimensiones diferentes -> No es posible la Suma.');
    
    { LA RESTA }
        if A = B then
        begin
        Write('El Vector Resta es (A-B): ');
        for i:=1 to A do
            begin
            VResta[i] := VectorA[i] - VectorB[i];
            Write(VResta[i]:6:1);
            end;{for}
        WriteLn;
        end
    else
        WriteLn('Dimensiones diferentes -> No es posible la Resta.');
end;{procedure}


{ PRODUCTO ESCALAR ---------------------------------------------------------------------------}
procedure ProductoEscalar
    (
        VectorA : TV_10_Real;
        A       : byte;
        VectorB : TV_10_Real;
        B       : byte
    );

var 
    i     : byte;
    ProdE : Real;

begin
    ProdE := 0;
    if A = B then
        begin
        for i:=1 to A do
            begin
            ProdE := ProdE + (VectorA[i] * VectorB[i]);
            end;{for}
        WriteLn('El Producto Escalar (Punto o Interno) es: ',ProdE:0:1);
        end
    else
        WriteLn('Dimensiones diferentes -> No es posible el Producto Escalar.');
     
     
end; {procedure}


{ SEPARADOR ----------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    TextColor(yellow);
    WriteLn('-----------------------------------------------------------------');
    WriteLn;
    TextColor(white);
end;{procedure Separador}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    VectorA : TV_10_Real;
    A       : byte;
    VectorB : TV_10_Real;
    B       : byte;

begin
    LeerVectores(VectorA,A,VectorB,B);
    
    ClrScr;
    MostrarVectores(VectorA,A,VectorB,B);
    
    Separador;
    VectorSumaResta(VectorA,A,VectorB,B);
    
    Separador;
    ProductoEscalar(VectorA,A,VectorB,B);
    
    ReadLn;
end.