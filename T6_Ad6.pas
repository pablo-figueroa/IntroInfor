(*
------------------------------ ADICIONAL 6 ------------------------------

    Dado un arreglo V de N elementos ordenados en forma ascendente con componentes repetidas: 

    • Generar X con los elementos distintos de V, y 
    • Generar W con la frecuencia de los elementos de V.

Ejemplo 1: 
    N=10; 
    V=(2,2,3,3,3,3,7,9,9,9)
    X=(2,3,7,9) 
    W=(2,4,1,3)

Ejemplo 2: ( Termina con 0 )
    N=11;  
    V=(-4,-3,-3,-2,-2,-2,-1,-1,-1,-1,0,0,0,0,0)
    X=(-4,-3,-2,-1,0)
    W=(1,2,3,4,5)

Ejemplo 3: ( Inicia con 0 )
    N=10
    V=(0,1,1,2,2,2,3,3,3,3)
    X=(0,1,2,3)
    W=(1,2,3,4)

*)

program T6_Ad5;
//{$codepage UTF8}

uses crt;

type
    TV_50_Int = array[1..50] of integer;


{-----------------------------------------------------------------------------}
procedure Titulo();
begin
    ClrScr;
    WriteLn('--------------------------------------');
    WriteLn('           FRECUENCIA');
    WriteLn('--------------------------------------');
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
procedure LeerVector (
    var V : TV_50_Int;
    var N : byte
);

var 
    i    : byte;
    arch : text;

begin
    Assign(arch, 'T6_Ad6.txt');
    Reset(arch);
    i := 0;   
    while not eof(arch) do
        begin
        i := i + 1;
        ReadLn(arch, V[i]);
        end;
    Close(Arch);
    N := i;
end;{procedure}


{ ALGOTIRMO DE BURBUJEO ----------------------------------------------------------------------}
procedure BubbleSort
    (
        var V : TV_50_Int;
        N     : byte
    );

var
    Aux  : integer;
    i    : byte;
    K    : byte;
    Tope : byte;

begin
    Tope := N;

    repeat
        K := 0;
        for i:=1 to Tope-1 do
            begin
            if V[i] > V[i+1] then
                begin
                Aux    := V[i];
                V[i]   := V[i+1];
                V[i+1] := Aux;
                K := i;
                end;
            end;{for}
        Tope := K;
    until K = 0;
end;


{-----------------------------------------------------------------------------}
procedure MostrarVector (
    V : TV_50_Int;
    N : byte
);

var 
    i : byte;

begin
    for i:=1 to N do
        Write(V[i],'  ');
end;{procedure}


{-----------------------------------------------------------------------------}
procedure GenerarVX (
    VV : TV_50_Int;
    N  : byte;
    var VX : TV_50_Int;
    var M  : byte
);

var 
    i : byte;
    j : byte;

begin
    j := 0;
    
    VV[n+1] := VV[n] + 1; { Así me aseguro de guardar el último elemento si 0 con el if <> then }
    
    for i:=1 to N do
        begin
        if VV[i] <> VV[i+1] then
            begin
            j := j + 1;
            VX[j] := VV[i];
            end;
        end;
    M := j;

end;{procedure}


{-----------------------------------------------------------------------------}
procedure GenerarVW (
    VV     : TV_50_Int;
    N      : byte;
    var VW : TV_50_Int;
    var M  : byte
);

var 
    i    : byte;
    j    : byte;
    Cont : byte;

begin
    j := 0;
    i := 1;
    VV[n+1] := VV[n] + 1;
    while (i >= 1) and (i <= N) do
        begin
        Cont := 1;
        (* while (VV[i] = VV[i+1]) and (i < N) do { Problema del 0 final | Poner la "pared"} *)
        while (VV[i] = VV[i+1]) do { Si uso: VV[n+1] := VV[n] + 1; de arriba } { 1 evaluación }
            begin
            i := i + 1;
            Cont := Cont + 1;
            end;
        j := j + 1;
        VW[j] := Cont;
        i := i + 1;
        end;
    M := j;
end;{procedure}


{ PROGRAMA PRINCIPAL ---------------------------------------------------------}
var
    VV : TV_50_Int;
    N  : byte;
    
    VX : TV_50_Int;
    VW : TV_50_Int;
    M  : byte;

begin
    Titulo;

    { Lectura y muestra del Vector desde archivo }
    LeerVector(VV, N);
    WriteLn('Vector V desde archivo:');
    WriteLn;
    Write('  (  ');
    MostrarVector(VV, N);
    WriteLn(')');

    Separador;

    { Ordenando ascendentemente y mostrando el vector }
    BubbleSort(VV, N);
    WriteLn('Vector V en orden:');
    WriteLn;
    Write('  (  ');
    MostrarVector(VV, N);
    WriteLn(')');
    
    Separador;
    { Generando y mostrando Vector de elementos distintos}
    GenerarVX(VV, N, VX, M);
    WriteLn('Vector X:');
    WriteLn;
    Write('  (  ');
    MostrarVector(VX, M);
    WriteLn(')');

    Separador;

    { Generando y mostrando Vector con las frecuencias V }
    GenerarVW(VV, N, VW, M);
    WriteLn('Vector W:');
    WriteLn;
    Write('  (  ');
    MostrarVector(VW, M);
    WriteLn(')');

    Separador;

    { the End }
    WriteLn('FIN.-');
    ReadLn;
end.