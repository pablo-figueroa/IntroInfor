(*
----------------------------------------- EJERCICIO 4 -----------------------------------------

Almacenar en una vector K números reales, se sabe que existen elementos nulos. 

Generar un nuevo arreglo donde cada uno de sus elementos sean la suma 
de los valores previos a un cero.
    
    Ejemplos: K= 11, 
    (2, 6, 0, 1, 0, 4, 7,-2, 0, 8, 4) -> (8, 1, 9)
    (0, 2, 6, 0, 1, 0, 4, 7,-2, 3, 0) -> (0, 8, 1, 12)
    (1, 1, 0, 3, 3, 0, 0, 8,-1,-1, 0) -> (2, 6, 0, 6)
long 1  2  3  4  5  6  7  8  9  0  1  -> longitud = 11

*)

program T6_Ej04.pas;

//{codepage UTF8}

uses crt;

type
    VT_50_Real = array[1..50] of Real;
    

{ LEER VECTOR --------------------------------------------------------------------------------}
procedure LeerVector
    (
        var VecIn : VT_50_Real; { Vector Ingresado }
        var K     : byte
    );

var i : byte;

begin
    repeat
        ClrScr;
        Write('Ingrese longitud del vector: ');
        ReadLn(K);
    until K > 0;
    
    for i:=1 to K do
        begin
        ClrScr;
        Write('Ingresar real de la posición ',i,': ');
        ReadLn(VecIn[i]);
        end;{for}

end;{procedure}


{ MOSTRAR VECTOR INGRESADO -------------------------------------------------------------------}
procedure MostrarVector
    (
        Vec   : VT_50_Real;
        K     : byte
    );

var i : byte;

begin
    Write('(');
    for i:=1 to K do
        begin
        Write(Vec[i]:4:0);
        end; {for}
    WriteLn(' )');
end; {procedure}


{ GENERAR VECTOR DE SALIDA CON FOR -----------------------------------------------------------}
procedure GenerarVectorConFor
    (
        VecIn      : VT_50_Real;
        K          : byte;
        var VecOut : VT_50_Real;
        var L      : byte
    );

var 
    i   : byte;
    sum : real;

begin
    sum := 0;
    L   := 0;
    TextColor(yellow);
    WriteLn('Generando Vector con For...');
    TextColor(white);
    
    for i:=1 to K do
        begin
        if VecIn[i] <> 0 then
            sum := sum + VecIn[i]
        else if (VecIn[i] = 0) and (i <= k) then
            begin
            L := L + 1;
            VecOut[L] := sum;
            sum := 0;
            end; {if}
        end; {for}
end; {procedure}


{ GENERAR VECTOR DE SALIDA CON WHILE----------------------------------------------------------}
procedure GenerarVectorConWhile
    (
        VecIn      : VT_50_Real;
        K          : byte;
        var VecOut : VT_50_Real;
        var L      : byte
    );

var 
    i   : byte;
    sum : real;

begin
    L := 0;
    i := 0;
    TextColor(yellow);
    WriteLn('Generando Vector con While...');
    TextColor(white);
    
    while i <= K do
        begin
        sum := 0;
        i := i +1;
        while VecIn[i] <> 0 do
            begin
            sum := sum + VecIn[i];
            i := i +1;
            end; {while}
        if (VecIn[i] = 0) and (i <= k) then
            begin
            L := L + 1;
            VecOut[L] := sum;
            end;
        end; {while}
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


{ SALIR DEL PROGRAMA O CONTINUAR -------------------------------------------------------------}
procedure Salir();

var
    S : char;

begin
    
    Write('Enter para reiniciar | S -> Salir ');
    S := ReadKey;
    S := UpCase(S);
    if S = 'S' then
        halt;
        
end;{procedure}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    VecIn : VT_50_Real;  { Vector Ingresado }
    k     : byte;
    
    VecOut : VT_50_Real; { Vector de Salida }
    L      : byte;

    

begin
repeat
    LeerVector(VecIn,K);
    
    ClrScr;
    
    Write('VECTOR INGRESADO: ');
    MostrarVector(VecIn,K);
    
    Separador;
    
    GenerarVectorConFOR  (VecIn,K,VecOut,L);
    Write('VECTOR GENERADO con FOR   : ');
    MostrarVector(VecOut,L);
    
    Separador;
    
    GenerarVectorConWHILE(VecIn,K,VecOut,L);  
    Write('VECTOR GENERADO con WHILE : ');
    MostrarVector(VecOut,L);

    Separador;
    
    Salir;
until false;
end.