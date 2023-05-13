(*
Ejemplo 3

En un archivo se han grabado, en cada línea, el nombre (10 caracteres) y la edad de un
conjunto de personas. 
Se pide ingresar dichos datos en dos vectores para luego:
Listar los nombres de las personas cuya edad este por debajo del promedio
*)

program Ej3;
//{codepage UTF8}
uses crt;
Type
    St25   = string[25];        
    TVNom  = array[1..50] of St25;
    TVEdad = array[1..50] of byte;

{ LEER PARALELO ------------------------------------------------------------------------------}
procedure LeeParalelo (
    VAR VNom  : TVNom;
    VAR VEdad : TVEdad;
    VAR N     : Byte);

Var
    Arch : text;

Begin
    Assign(Arch, 'T6_03_Ejemplo.txt');
    Reset (Arch);
    N:=0;
    while not eof(Arch) do
        Begin
        N:= N + 1;
        Readln(Arch, VNom[N], VEdad[N]);
        End;{while}
    Close(Arch);
End;{procedure}

{ CALCULAR PROMEDIO --------------------------------------------------------------------------}
function Promedio (
    V : TVEdad;
    N: byte): word;

Var
    Sum : word;
    i: byte;

Begin
    Sum:=0;
    for i:=1 to N do
        Sum:=Sum+ V[i];
    Promedio := Sum DIV N;
End;{function}

{ LISTAR -------------------------------------------------------------------------------------}
procedure Listado (
            VNom  : TVNom; 
            VEdad : TVEdad;
            N     : Byte;
            Prom  : word);
Var
    i: Byte;
Begin
    For i:= 1 to N do
        { Listar los nombres de las personas cuya edad este por DEBAJO del promedio }
        if VEdad[i] < Prom then                  { Cambié > por <}
            WriteLn(VNom[i],' ',VEdad[i]);
End;{procedure}

{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
VAR
    VNom    : TVNom;
    VEdad   : TVEdad;
    Prom, N : byte;
begin
    ClrScr;
    LeeParalelo(Vnom, VEdad, N);
        
    WriteLn('LISTADO DE LOS QUE NO SUPERAN EL PROMEDIO DE EDAD: ');
    Prom:= Promedio(VEdad, N);
    Listado(Vnom, VEdad, N, Prom);
    
    WriteLn;
    WriteLn('PROMEDIO DE EDADES: ',Promedio(VEdad, N));
    ReadLn;
end.