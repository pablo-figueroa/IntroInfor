(*
----------------------------------------- EJERCICIO 2 -----------------------------------------

Ingresar M números naturales y luego
    a. Contar e informar cuántos elementos son pares, impares y nulos.
    b. Multiplicar todos los componentes de posición par por un número ingresado por teclado,
validando que sea diferente de 0, mostrar por pantalla el conjunto de números resultante.
    c. Mostrar por pantalla cuál es el lugar donde aparece el máximo (en caso de que este valor
aparezca más de una vez, considerar el primero).

Ejemplo:
    
    números : 3 4 8 1 24 3 1 24 15 24
  { posición: 1 2 3 4  5 6 7  8  9 10 } 
    
    a. Pares: 5 | Impares: 5 | Nulos: 0
    
    b. Multiplicado por: -2.5                  
       Conjunto resultante: -10.00 -2.5 -7.5 -60.00 -60.00
    
    c. Lugar= 5 | Máximo = 24

Importante :
    * Cada proceso (lectura, escritura, cálculo) debe ser implementada mediante un procedimiento o
función, según corresponda, correctamente parametrizada. No utilizar variables globales.
    * Aunque no se explicite, informar siempre los resultados obtenidos.
    * Antes de comenzar a hacer el algoritmo arme un ejemplo y resuelva manualmente.

*)

program T6_Ej02;
//{$codepage UTF8}
uses crt;

type
    TV_50_UInt16 = array[1..50] of UInt16;  { Vector de Entrada         }
    TV_50_Real   = array[1..50] of Real;    { Vector Conjunto Resultate }

{ LECTURA DE VECTOR --------------------------------------------------------------------------}
procedure LeerVector
    (
        var Naturales : TV_50_UInt16;
        var M         : byte
    );
var
    i   : byte;

begin
    repeat
        ClrScr;
        WriteLn('NUMEROS NATURALES incluído el cero.');
        WriteLn;
        Write('Ingrese la cantidad de elementos del vector {1,...,50}: ');
        ReadLn(M);
        if M > 50 then
            begin
            TextColor(red);
            WriteLn('Error! -> {1,...,50} Expected');
            ReadLn;
            TextColor(white);
            end;
    until M <= 50;
    
    for i:=1 to M do
        begin
        ClrScr;
        Write('Ingresar Natural N° ',i,': ');
        ReadLn(Naturales[i]);
        end;{for}
end;{procedure LeerVector}


{ CONTEO DE PARES, IMPARES Y NULOS -----------------------------------------------------------}
procedure Paridad
    (
        Naturales     : TV_50_UInt16;
        M             : byte
    );

var
    i : byte;
    v : byte;
    ContPar   : byte;
    ContImpar : byte;
    ContNulo  : byte;
begin
    ContPar   := 0;
    ContImpar := 0;
    ContNulo  := 0;
    v := 0;
    for i := 1 to m do
        begin
        v := v + 1;
        if Naturales[v]  = 0 then
            ContNulo := ContNulo + 1
        else
            if Naturales[v] mod 2 = 0 then
                ContPar := ContPar + 1
            else
                ContImpar := ContImpar +1;
        end;{for}
    WriteLn('Pares: ',ContPar,' | Impares: ',ContImpar,' | Nulos: ',ContNulo);
end;{procedure Paridad}


{ CONJUNTO RESULTANTE DE NATURALES EN POSICION PAR MULTIPLIDO POR X --------------------------}
(* 
    Dado que no acalara el conjuto al que pertene x,
    uso el conjunto más amplio:
    x Pertenece a los Reales -{0}
*)    
procedure ConjuntoResultante
    (
        Naturales   : TV_50_UInt16;
        M           : byte
    );

var
    x       : real;       { multiplicador Naturales }
    i       : byte;       { posición Naturales      }
    j       : byte;       { posición ConjRes        }
    ConjRes : TV_50_Real; { Conjunto Resultante     }

begin
    repeat 
        Write('Ingrese un multiplicador (x): ');
        ReadLn(x);
    until x <> 0;
    
    
    Write('El Conjunto Resultante es: ');
    i := 2;
    j := 1;
    while i <= M do
        begin
        ConjRes[j] := Naturales[i] * x;
        Write(ConjRes[j]:0:2,' ');
        i := i + 2;
        j := j + 1;
        end;{while}
    WriteLn;
end;{procedure ConjuntoResultante}


{ LUGAR DEL MAXIMO Y MAXIMO ------------------------------------------------------------------}
procedure LugarMax
    (
        Naturales : TV_50_UInt16;
        M         : byte
    );

var
    i      : byte;
    LgrMax : byte;
    Max    : UInt16;

begin
    LgrMax := 1;
    Max    := 0;
    for i:=1 to M do
        begin
        if Naturales[i] > Max then  { y con >= encuentro el último }
            begin
            LgrMax := i;
            Max    := Naturales[i];
            end;
        end;{for}
    WriteLn('Lugar del Máximo: ',LgrMax);
    WriteLn('Número Máximo   : ',Max);
end;{procedure LugarMax}


{ SEPARADOR ----------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    TextColor(yellow);
    WriteLn('-----------------------------------------------------------------');
    WriteLn;
    TextColor(white);
end;{procedure Separador}


{ MOSTRAR VECTOR INGRESADO -------------------------------------------------------------------}
procedure MostrarVector
    (
        Naturales : TV_50_UInt16;
        M         : byte
    );

var
    i : byte;

begin
    Write('Vector Ingresado: ');
    for i:=1 to M do
        begin
        Write(Naturales[i],' ');
        end;{for}
    WriteLn;
end;{procedure}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    Naturales : TV_50_UInt16;
    M         : byte;

    
begin
    ClrScr;
    LeerVector(Naturales,M);
    Separador;
    
    ClrScr;
    MostrarVector(Naturales,M);
    Separador;
    Paridad(Naturales,M);
    Separador;
    ConjuntoResultante(Naturales,M);
    Separador;
    LugarMax(Naturales,M);
    
    readLn;
end.