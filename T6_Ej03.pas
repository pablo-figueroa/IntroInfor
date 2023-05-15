(*
----------------------------------------- EJERCICIO 3 -----------------------------------------

Ingresar en un arreglo N números enteros.

Generar dos arreglos VPos y VNeg que contendrán los números positivos y
negativos respectivamente.

Mostrar el más numeroso, ambos si la cantidad de elementos coinciden.

Ejemplo:
    VEntrada :  2  4  5  6 -1 -3

    VPos     :  2  4  5  6
    VNeg     : -1 -3

    Vector más numeroso: 2 4 5 6

Importante :
    * Cada proceso (lectura, escritura, cálculo) debe ser implementada mediante un procedimiento o
función, según corresponda, correctamente parametrizada. No utilizar variables globales.
    * Aunque no se explicite, informar siempre los resultados obtenidos.
    * Antes de comenzar a hacer el algoritmo arme un ejemplo y resuelva manualmente.

*)

program T6_Ej03;

//{$codepage UTF8}

uses crt;

type
    TV_50_Int16 = array[1..50] of Int16;

{ ENTRADA DEL VECTOR -------------------------------------------------------------------------}
procedure LeerVectorEntero
    (
        var VEnt : TV_50_Int16;
        var N    : byte
    );

var
    i : byte;

begin
    repeat
        ClrScr;
        gotoxy(1,1); //REVISAR SI HACE FALTA!!!
        Write('Ingresar cantidad de posiciones del array {1..50}: ');
        ReadLn(N)
    until (N >= 1) and (N <= 50);

    for i:=1 to N do
        begin
        ClrScr;
        gotoxy(1,1); //REVISAR SI HACE FALTA!!!
        Write('Ingresar Entero N° ',i,': ');
        ReadLn(VEnt[i]);
        end;{for}

end;{procedure}


{ MOSTRAR VECTOR ENTERO ----------------------------------------------------------------------}
procedure MostrarVectorEntero
    (
        VEnt : TV_50_Int16;
        N    : byte
    );

var
    i : byte;

begin
    ClrScr;
    Write('Vector de Enteros Ingresado: ');
    for i:=1 to N do
        begin
        Write(VEnt[i]:5);
        end;{for}
    WriteLn;
end;{procedure}


{ GENERAR VECTOR POSITIVO --------------------------------------------------------------------}
procedure GeneraVectorPosNeg
    (
        VEnt     : TV_50_Int16;
        N        : byte;
        var VPos : TV_50_Int16;
        var P    : byte;
        var VNeg : TV_50_Int16;
        var E    : byte
    );

var
    i : byte;
    j : byte;
    k : byte;

begin
    j := 1;
    k := 1;
    P := 0;
    E := 0;
    for i:=1 to N do
        begin
        if VEnt[i] > 0 then
            begin
            VPos[j] := VEnt[i];
            j := j + 1;
            P := P + 1;
            end
        else
            if VEnt[i] < 0 then
                begin
                VNeg[k] := VEnt[i];
                k := k + 1;
                E :=E + 1;
                end;{if}
        end{for}
end;{procedure}


{ MOSTRAR VECTOR MÁS NUMEROSO ----------------------------------------------------------------}
procedure MostrarMasNumeroso
    (
        VPos : TV_50_Int16;
        P    : byte;
        VNeg : TV_50_Int16;
        E    : byte
    );

var
    i : byte;

begin
    WriteLn('VECTOR MÁS NUMEROSO');
    if P > E then
        begin
        Write('  Vector de los Positivos: ');
        for i:=1 to P do
            begin
            Write(VPos[i]:5);
            end;{for}
        WriteLn;
        end {if P > E}
    else
        if E > P then
            begin
            Write('  Vector de los Negativos: ');
            for i:=1 to E do
                begin
                Write(VNeg[i]:5);
                end;{for}
            WriteLn;
            end {if E > P}
        else
            begin
            WriteLn('  Ambos Igual de Numerosos: ');
            Write('    Vector de los Positivos: ');
            for i:=1 to P do
                begin
                Write(VPos[i]:5);
                end;{for}
            WriteLn;
            Write('    Vector de los Negativos: ');
            for i:=1 to E do
                begin
                Write(VNeg[i]:5);
                end;{for}
            WriteLn;
            end; {if P = N}
end;{procedure}


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
    VEnt : TV_50_Int16;
    N    : byte;
    VPos : TV_50_Int16;
    P    : byte;
    VNeg : TV_50_Int16;
    E    : byte;

begin
    LeerVectorEntero(VEnt,N);

    MostrarVectorEntero(VEnt,N);
    Separador;
    GeneraVectorPosNeg(VEnt,N,VPos,P,VNeg,E);
    MostrarMasNumeroso(VPos,P,VNeg,E);

    ReadLn;
end.