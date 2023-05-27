(*

------------------------------ ADICIONAL 4 ------------------------------

    
    Escribir un programa Pascal eficiente y correctamente modularizado
que resuelva el siguiente problema:

    Leer desde archivo sobre un vector C (calcular la cantidad N de componentes). 
    Se sabe que contiene elementos negativos no consecutivos .

    Construir otro vector de la siguiente manera: 
        * Cada elemento será el número máximo ubicado entre dos negativos.
        * Escribir el vector generado

EJEMPLO: 
Archivo: 2, 3 , 4, -7, 4, 5, -5, 7, 5, 3, 7, 8, 9, -1, 2, 3, -2
N= 17 
        C = ( 2 , 3 , 4, -7, 4, 5, -5, 7, 5, 3, 7, 8, 9, -1, 2, 3, -2) 
                          *     5   *                 9    *    3    *
luego   B = ( 5, 9, 3)


    EJEMPLO:
        Vector Ingresado:
        (  26  -1  6  5  4  -1  7  6  5  -1  8  7  6  -1  26  )
        ---------------------------------------------------
        Vector Resultante:
        (  6  7  8  )

*)

program T6_Ad4;
//{$codepage UTF8}
uses crt;

type
    TV_50_Int = array[1..50] of Integer;


{-----------------------------------------------------------------------------}
procedure Titulo();
begin
    ClrScr;
    WriteLn('---------------------------------------------------');
    WriteLn('     NUMERO MAYOR UBICADO ENTRE DOS NEGATIVOS');
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


{-----------------------------------------------------------------------------}
procedure LeerVector
    (
        var V : TV_50_Int; 
        var N : Byte
    );

var
    i    : byte;
    Arch : text;
    Num  : integer;

begin
    Assign(arch, 'T6_Ad4.txt');
    Reset(arch);
    i := 0;
    while not eof(Arch) do
        begin
        i := i + 1;
        ReadLn(Arch, Num);
        V[i] := Num;
        end;{while}
    N := i;
    Close(arch);
end; {LeerVectorArch}


{-----------------------------------------------------------------------------}
procedure MostrarVector (
    V : TV_50_Int; 
    N : Byte
);
var
    i : byte;
begin
    for i:=1 to N do
        write(V[i],'  ');
end; {Mostrar Vector}


{-----------------------------------------------------------------------------}
procedure MaximosEntreNeg (
    V        : TV_50_Int; 
    var N    : Byte;
    var VMeN : TV_50_Int { Vector Máximo Entre Negativos}
);

var
    i   : byte;
    j   : byte;
    max : integer;

begin
    i := 1;
    j := 0;
    while (i >= 1) and (i <= N) do
        begin
        max := -999;
        if V[i] < 0 then
            begin
            i := i + 1;
            while V[i] > 0 do
                begin
                if V[i] > max then
                    max := V[i];
                i := i + 1;
                end;    
            j := j + 1;
            VMen[j] := max;
            i := i - 1; { Retroceder para que el negativo fin sea negativo de inicio }
            end;
        i := i + 1;
        end;
    N := j - 1;
end;


{ PROGRAMA PRINCIPAL ---------------------------------------------------------}
var

    VEntrada : TV_50_Int; { Vector de Entrada }
    VSalida  : TV_50_Int; { Vector de Salida  }
    N        : Byte;
    
begin 
    Titulo;
    LeerVector(VEntrada, N);

    WriteLn('Vector Ingresado:');
    WriteLn;
    Write('  (  ');
    MostrarVector(VEntrada, N);
    WriteLn(')');

    Separador;

    MaximosEntreNeg(VEntrada, N, VSalida);
    WriteLn('Vector Resultante:');
    WriteLn;
    Write('  (  ');
    MostrarVector(VSalida, N);
    WriteLn(')');
    WriteLn;

    ReadLn;

end.