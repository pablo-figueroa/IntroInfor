(*
EJERCICIO 6
Dada una matriz MxN de enteros en el rango de 1 a 50.

Verificar que ningún número esté repetido, en
caso contrario indicar cuántas veces se repite cada uno.

*)

program T7_Ex06;

//{$codepage UTF8}

uses crt;

type
    TM   = array[1..10,1..10] of byte;   { 10 * 10 = 100 }
    TV_N = array[1..50] of byte;         { 100 / 2 = 50  }
    TV_R = array[1..50] of byte;

{---------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('-----------------------------------------------');
    WriteLn;
end;{procedure}


{---------------------------------------------------------------------------------------}
procedure LeerMatriz (
    var Mat : TM;
    var N   : byte;
    var M   : byte
);

var
    i : byte;
    j : byte;

begin
    Write('Ingrese cantidad de filas: ');
    ReadLn(N);
    Write('Ingrese cantidad de columnas: ');
    ReadLn(M);
    for i:=1 to N do
        for j:=1 to M do
            begin
            Write('Ingrese (',i,',',j,') : ');
            ReadLn(Mat[i,j]);
            end;
end;


{---------------------------------------------------------------------------------------}
procedure MostrarMatriz (
    Mat : TM;
    N   : byte;
    M   : byte
);

var
    i : byte;
    j : byte;

begin
    for i:=1 to N do
        begin
        write('  |');
        for j:=1 to M do
            begin
            write(Mat[i,j]:4);
            end;
        WriteLn('  |');
        end;

end;

{---------------------------------------------------------------------------------------}
procedure Repetidos (
    Mat : TM;
    N,M : byte;
    
    var VecNum  : TV_N;  { Número que se repite }
    var VecCant : TV_R;  { Cantidad de veces que se repite }
    var V       : byte   { Longitud de los vectores }
);

var
    i,j,k,l : byte;
    Cont    : byte;

begin

    k := 1;
    l := 1;
    
    while k <= N do
        begin
        
        while l <= M do
            begin
            Cont := 0;
            for i:=1 to N do
                for j:=1 to M do
    
                    if Mat[k,l] = Mat[i,j] then
                        Cont := Cont + 1;
    
            if Cont > 1 then
                begin
                v := v + 1;
                VecNum[v]  := Mat[k,l];
                VecCant[v] := Cont;
                Cont := 0;
                end; {if}
    
            l := l + 1;
            end; {while l}
        l := 1;
        k := k + 1;
        end; {while k}
end; {procedure}    


{---------------------------------------------------------------------------------------}
procedure MostrarVector (
    VecN : TV_N;  { Número que se repite }
    VecR : TV_R;  { Cantidad de veces que se repite }
    V    : byte   { Longitud de los vectores }
);

var
    i : byte;

begin
    write('Número   : (');
    for i:=1 to V do
        write(VecN[i]:4);
    writeLn('  )');

    write('Cantidad : (');
    for i:=1 to V do
        write(VecR[i]:4);
    writeLn('  )');
end;

{---------------------------------------------------------------------------------------}
procedure BubbleSort (
    var VecN : TV_N;  { Número que se repite }
    var VecR : TV_R;  { Cantidad de veces que se repite }
    V        : byte   { Longitud de los vectores }
);

var
    AuxN : byte;
    AuxR : byte;
    i    : byte;
    K    : byte;
    Tope : byte;

begin
    Tope := V;
    repeat
        K := 0;
        for i:=1 to Tope-1 do
            begin
            If VecN[i] > VecN[i+1] then
                begin
                AuxN      := VecN[i];
                AuxR      := VecR[i];
                
                VecN[i]   := VecN[i+1];
                VecR[i]   := VecR[i+1];
                
                VecN[i+1] := AuxN;
                VecR[i+1] := AuxR;
                K := i;
                end;
            end;{for}
        Tope := K;
    until K =0;
end;

{---------------------------------------------------------------------------------------}
procedure EliminarRepeticiones (
    VecN : TV_N;     { Número que se repite }
    VecR : TV_R;     { Cantidad de veces que se repite }
    
    var V  : byte;   { Longitud de los vectores }
    var VN : TV_N;
    var VR : TV_R
);

var
    i : byte;
    j : byte;

begin
    j := 0;
    for i:=1 to V do           
        if VecN[i] <> VecN[i-1] then
            begin
            j := j + 1;
            VN[j] := VecN[i];
            VR[j] := VecR[i];
            end;

    V := j;


end; {procedure}
    

{---------------------------------------------------------------------------------------}
{ PROGRAMA PRINCIPAL }
var
    Mat   : TM;
    N    : byte;
    M    : byte;

    VNum : TV_N;
    VRep : TV_R;
    V    : byte;
    VN : TV_N;
    VR : TV_R;


begin
    LeerMatriz(Mat, N, M);
    ClrScr;

    WriteLn('Matriz Ingresada: ');
    Writeln;
    MostrarMatriz(Mat, N, M);

    Separador;

            
    
    Repetidos(Mat, N, M, VNum, VRep, V);
    if V = 0 then
        writeLn('No hay repetidos')
    else
        begin
        (* WriteLn('REPETIDOS: (No ordenados y con repeticiones)'); *)
        (* MostrarVector(VNum, VRep, V); *)
    
        (* Separador; *)
    
        (* WriteLn('REPETIDOS: (Ordenados y con repeticiones)'); *)
        BubbleSort(VNum, VRep, V);
        (* MostrarVector(VNum, VRep, V); *)
    
        (* Separador; *)
    
        WriteLn('REPETIDOS:');
        EliminarRepeticiones(VNum, VRep, V, VN, VR);
        MostrarVector(VN, VR, V);
        end;

    Separador;

    Write('FIN ');
    ReadLn;
    
end.