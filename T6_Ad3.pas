(*

------------------------------ ADICIONAL 3 ------------------------------

    Escribir un programa Pascal eficiente y correctamente modularizado que resuelva el siguiente problema: 

    Se dice que un vector V de N números enteros es una mochila perfecta 
si cada elemento del vector es mayor que la suma de todos los anteriores.

    Dado un archivo de números enteros no nulos, leerlos almacenando en un arreglo V aquellos que sean ascendentes. 
    
    Luego, determinar si V es o no una mochila perfecta. 
    En caso de no ser indicar cuál es el primer elemento que no cumple.

Ejemplos :
• Archivo = 2 1   5 -10 3 9 18  4 60 -> V = ( 2 , 5 , 9 , 18 , 60 ) SI es una mochila perfecta
• Archivo = 1 5 -10   3 7 4 10 45    -> V = ( 1 , 5 , 7 , 10 , 45 ) NO es una mochila perfecta

*)

program T6_Ad3;
//{$codepage UTF8}
uses crt;

type
    TV_50_Int = array[1..50] of Integer;
    TStr11    = String[12];


{-----------------------------------------------------------------------------}
procedure Titulo();
begin
    ClrScr;
    WriteLn('--------------------------------------');
    WriteLn('          MOCHILA PERFECTA');
    WriteLn('--------------------------------------');
    WriteLn;
end; {procedure Titulo}


{-----------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('----------------------------------------------------');
    WriteLn;
end;{procedure Separador}


{-----------------------------------------------------------------------------}
procedure LeerVectorArch
    (
        var V   : TV_50_Int; 
        var N   : Byte;
        nomArch : TStr11
    );

var
    i    : Byte;
    arch : Text;
    num  : Integer;

begin
    Assign(arch, nomArch);
    Reset(arch);
    i := 0;
    ReadLn(arch, num);
    while num <> 0 do
        begin
        i := i + 1;
        V[i] := num;
        ReadLn(arch, num);
        end;{while}
    N := i;
end; {LeerVectorArch}


{-----------------------------------------------------------------------------}
procedure MostrarVector
    (
        V : TV_50_Int; 
        N : Byte
    );

var
    i : byte;

begin
    for i:=1 to N do
        write(V[i]:5);
end; {Mostrar Vector}


{-----------------------------------------------------------------------------}
procedure VectorAscendente
    (
        var V : TV_50_Int; 
        var N : Byte
    );

var
    i    : Byte;
    max  : integer;
    VAux : TV_50_Int;
    j    : Byte;

begin
    max := -9999;
    j := 0;
    for i:=1 to N do
        if V[i] > max then
            begin
            max := V[i];
            j := j +1;
            VAux[j] := V[i]
            end;
    V := VAux;
    N := j;
end; {VectorAscendente}


{-----------------------------------------------------------------------------}
function MochilaPerfecta
    (
        V : TV_50_Int; 
        N : Byte
    ):byte;

var
    i : byte;
    Acum : integer;

begin
    Acum := V[1] + V[2];
    i := 3;
    while (i <= N+1) and (V[i] > Acum) do
        begin
        Acum := Acum + V[3];
        i := i + 1;
        end;
    if i <= N then
        MochilaPerfecta := i
    else
        MochilaPerfecta := 0;
end; {MochilaPerfecta}


{ PROGRAMA PRINCIPAL ---------------------------------------------------------}
var

    TVector : TV_50_Int; { Vector Original   }
    N       : Byte;
    
    i       : byte;
    Y       : byte;
    nomArch : TStr11;
    Res     : byte;
    S       : char;

begin
    repeat
        Titulo;
        Y := whereY;
        repeat
            gotoxy(1,y);
            ClrEol;
            Write('Selecione Archivo 1 ó 2: ');
            ReadLn(Res);
        until (Res = 1) or (Res = 2);
        if Res = 1 then
            nomArch := 'T6_Ad3_1.txt'
        else
            nomArch := 'T6_Ad3_2.txt';

        LeerVectorArch(TVector, N, nomArch);

        Titulo;
        write('Vector Ingresado : [');
        MostrarVector(TVector, N);
        writeLn(']':5);

        Separador;

        VectorAscendente(TVector,N);
        write('Vector Ascendente: [');
        MostrarVector(TVector, N);
        writeLn(']':5);
        
        Separador;

        i := MochilaPerfecta(TVector, N);
        
        if i = 0 then
            begin
            TextColor(green);
            WriteLn('ES MOCHILA PERFECTA');
            TextColor(white);
            end
        else
            begin
            TextColor(red);
            WriteLn('NO ES MOCHILA PERFECTA:');
            TextColor(white);
            WriteLn;
            WriteLn(' Primer Caso que NO Cumple:');
            WriteLn('  Número = ',TVector[i],' | Posición = ',i);
            end;

        Separador;

        TextColor(red);
        Write('Enter para reiniciar | S -> Salir ');
        TextColor(white);
        S := ReadKey;
        S := UpCase(S);
    until (S = 'S');
end.