(*
    Un conjunto de corredores entrenan para una carrera, 
corriendo una hora cada uno de los 7 días de la semana y 
teniendo como meta alcanzar en dicha hora, una mínima de X kms.
    
    En un archivo de texto se graba la meta X en la primera línea y 
en las restantes el nombre (10 caracteres como máximo) y 
los 7 días de cada corredor, uno por línea.

        19
        Ivo       5  10 15 15 10  5  0
        Pia       10 20  5 10 10 30  5
        Juan       5  5 10  1 10 15 25
        Omar       5 10 25 20 40 25 15

    Se pide desarrollar un programa Pascal, 
correctamente modularizado que lea y 
almacene los nombres en un vector y 
los tramos en una matriz.
    
    a.-Generar un arreglo con los nombres de los corredores 
que superaron la meta establecida algún día de la semana. Imprimirlo
    
    b.- Calcule e imprima, cuantos días no alcanzo la meta 
el corredor con promedio diario máximo.

Ejemplo: N=4 Meta Semanal=20
             
             Nombres:          Kms:                          Promedios:
             |Ivo       |      |  5 10 15 15 10  5  0 |      |  8.57 |
             |Pia       |      | 10 20  5 10 10 30  5 |      | 12.85 |
             |Juan      |      |  5  5 10  1 10 15 25 |      | 10.14 |
             |Omar      |      |  5 10 25 20 40 25 15 |      | 20.00 |

Respuestas:
    a) ( Pia, Juan, Omar)
    b) 3 días (4to corredor) 

*)

program Corredores;

//{$codepage UTF8}

uses crt;

type
    string10 = string[10];
    
    TV = array[1..10] of string10;
    TM = array[1..15,1..7] of real;    { porque son kms }


{-----------------------------------------------------------------------------}
{ Línea separador }
procedure Separador();
var i : byte;
begin
    WriteLn;
    for i:=1 to 50 do
        write('-');
    WriteLn;
    WriteLn;
end;


{-----------------------------------------------------------------------------}
{ Leer Matriz y Generar Vec de Nombres y Mat de tramos }
procedure LeeArchGenVecMat(
    var Mat  : TM;
    var Vec  : TV;
    var N    : byte; { Tanto para longitud filas de Mat como longitud del Vec }
    var Meta : real
);

var
    j    : byte;
    arch : text;

begin
    N := 0;
    Assign(arch, 'corredores.txt');
    Reset(arch);
    ReadLn(arch, Meta);
    while not eof(arch) do
        begin
        N := N + 1;
        Read(arch, Vec[N]);
        for j:=1 to 7 do
            Read(arch, Mat[N,j]);
        ReadLn(arch);
        end; {while}
    Close(arch);

end;


{-----------------------------------------------------------------------------}
{ Mostrar Vector }
procedure MostrarVec(
    Vec : TV;
    N   : byte
);

var
    i : byte;

begin
    for i:=1 to N do
        write(Vec[i]);
    WriteLn;
end;


{-----------------------------------------------------------------------------}
{ Mostrar Matriz }
procedure MostrarMat(
    Mat : TM;
    N   : byte
);

var
    i,j : byte;

begin
    for i:=1 to N do
        begin
        for j:=1 to 7 do
            write(Mat[i,j]:6:1);
        WriteLn;
        end;
end;


{-----------------------------------------------------------------------------}
{
a. Generar un arreglo con los NOMBRES de los corredores 
que SUPERARON la META establecida algún día de la semana. 
Imprimirlo.
}
{-------------------------}
function VerificaMeta(
    Mat  : TM;
    row  : byte;
    Meta : real
):boolean;

var
    j : byte;

begin
    j := 1;
    VerificaMeta := FALSE;
    
    while (j <= 7) and (Mat[row,j] <= Meta) do { <= pq : Superan > Meta }
        j := j + 1;
    if j <= 7 then
        VerificaMeta := TRUE;
end;

{-------------------------}
procedure NomSupMeta(
    Mat  : TM;
    Vec  : TV;
    N    : byte;
    Meta : real;
    var VecNomSup : TV;  { Vector de Nombres que Superan Meta }
    var K         : byte { longitud de VecNomSup}
);

var
    i : byte;

begin
    k := 0;
    for i:= 1 to N do
        begin
        if VerificaMeta(Mat, i, Meta) = TRUE then
            begin
            k := k + 1;
            VecNomSup[k] := Vec[i]
            end;
        end;
end;
{ FIN DEL a. }


{-----------------------------------------------------------------------------}
{ 
b.- Calcule e imprima, 
cuantos días no alcanzo la meta
el corredor con promedio diario máximo.
}
{-------------------------}
function Promedio(
    Mat : TM;
    row : byte
):real;

var
    j    : byte;
    suma : real;

begin
    suma := 0;
    for j:=1 to 7 do
       suma := suma + Mat[row,j];
    Promedio := suma / 7;
end;
{-------------------------}
function CorrPromMax(
    Mat : TM;
    N   : byte
):byte;

var
    i    : byte;
    Prom : real;
    Aux  : byte;

begin
    Prom := 0;
    for i:= 1 to N do
        if Promedio(Mat, i) > Prom then
            begin
            Prom := Promedio(Mat, i);
            Aux := i;
            end;
    CorrPromMax := Aux;
end;

{-------------------------}
function DiazNoMeta(
    Mat  : TM;
    N    : byte;
    Meta : real
):byte;

var
    i,j : byte;
    Aux : byte;

begin
    Aux := 0; 
    i := CorrPromMax(Mat,N);
    for j:=1 to 7 do
        if Mat[i,j] < Meta then
            Aux := Aux + 1;
    DiazNoMeta := Aux;
end;
{ FIN DEL b. }


{-----------------------------------------------------------------------------}
{ PROGARMA PRINCIPAL }
var
    MatKms    : TM;
    VecNom    : TV;
    N         : byte;
    Meta      : real;

    VecNomSup : TV;
    K         : byte;

begin
    ClrScr;

    Separador;
    WriteLn('                C O R R E D O R E S');
    Separador;
    
    LeeArchGenVecMat(MatKms, VecNom, N, Meta);
    
    TextColor(yellow);
    WriteLn('Vector de Nombres: ');
    TextColor(white);
    MostrarVec(VecNom, N);
    WriteLn;

    TextColor(yellow);
    WriteLn('Matriz de Kms:');
    TextColor(white);
    MostrarMat(MatKms, N);

    Separador;

    WriteLn('Nombres de los que Superaron la Meta (',Meta:0:1,' km): ');
    NomSupMeta(MatKms, VecNom, N, Meta, VecNomSup, K);
    TextColor(yellow);
    MostrarVec(VecNomSup, K);
    TextColor(white);

    Separador;

    WriteLn('Cantidad de días que no alcanzo la meta');
    Write('el corredor con promedio diario máximo : ');
    TextColor(yellow);
    WriteLn(DiazNoMeta(MatKms, N, Meta));
    TextColor(white);

    Separador;
    Write('FIN ');
    ReadLn;    
end.