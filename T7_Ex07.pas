(*
EJERCICIO 7

Con el fin de lograr un control sobre el movimiento de personas en un edificio de oficinas,
se registra cada día del mes de marzo, cuántas personas se dirigen a cada uno
de los 25 pisos del edificio.

Los datos están desordenados y consisten en triplas:

Día, Piso y Cantidad ( pueden repetirse el Día y el Piso, juntos o separados).

Ingresar la información desde un archivo (edificio.txt), calcular e informar:
    a. Para cada piso y cada día, la cantidad de personas que ingresaron.
    b. Cantidad total de personas ingresadas al edificio durante el mes.
    c. Promedio diario de personas que ingresaron a cada piso.
    d. Para un determinado día, el porcentaje de personas que ingresaron dicho día sobre el total del mes.


Pregunta: ¿Cómo convendría construir el programa para fácilmente adaptarlo para cualquier mes del año
y edificios de cualquier cantidad de pisos (considerar un máximo de 100 pisos)?

*)

program T7_Ex04;

//{$codepage UTF8}

uses crt;

type
    TM = array[1..300,1..3] of byte;

const
    M : byte = 3;


{---------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('-------------------------------------------------------------');
    WriteLn;
end;{procedure}


{---------------------------------------------------------------------------------------}
procedure LeerMatriz (
    var Mat : TM;
    var N   : word
);

var
    i    : word;
    j    : byte;
    arch : text;

begin
    Assign(arch, 'T7_Ex07.txt');
    Reset(arch);
    i := 0;
    while not eof(arch) do
        begin
        i := i + 1;
        for j:=1 to M do
            read(arch, Mat[i,j]);
        ReadLn(arch);
        end;
    Close(arch);
    N := i;
end;


{---------------------------------------------------------------------------------------}
procedure MostrarMatriz (
    Mat : TM;
    N   : word
);

var
    i : word;
    j : byte;

begin
    for i:=1 to N do
        begin
        write('  | ');
        for j:=1 to M do
            write(Mat[i,j]:4);
        WriteLn('  |');
        end;
end;


{---------------------------------------------------------------------------------------}
function MaxDia (
    Mat : TM;
    N   : word
):byte;

var
    i   : word;
    j   : byte;
    Max : byte;

begin
    Max := 0;
    for i:=1 to N do
        for j:= 1 to 1 do
            if Mat[i,j] > Max then
                Max := Mat[i,j];
    MaxDia := Max;
end;


{---------------------------------------------------------------------------------------}
function MaxPiso (
    Mat : TM;
    N   : word
):byte;

var
    i   : word;
    j   : byte;
    Max : byte;

begin
    Max := 0;
    for i:=1 to N do
        for j:= 2 to 2 do
            if Mat[i,j] > Max then
                Max := Mat[i,j];
    MaxPiso := Max;
end;


{---------------------------------------------------------------------------------------}
{ a. Para CADA PISO Y CADA DÍA, la cantidad de personas que ingresaron. }
function PisoDiaPersonas (
    Mat     : TM;
    N       : word;
    Storey  : byte;
    Day     : byte
):byte;   
                                             {Día, Piso y Cantidad}
var
    i    : word;
    Acum : byte;

begin
    Acum := 0;
    for i:=1 to N do
        if (Mat[i,1] = Day) and (Mat[i,2] = Storey) then
            Acum := Acum + Mat[i,3];
    
    PisoDiaPersonas := Acum;        
end;



{---------------------------------------------------------------------------------------}
{ a1. Para CADA PISO, la cantidad de personas que ingresaron. }
procedure PisoPersonas (
    Mat     : TM;
    N       : word;
    PisoMax : byte
);

var
    i     : word;
    Piso  : byte;
    Acum  : byte;
    Total : word;
    

begin
    Total := 0;
    for Piso:=1 to PisoMax do
        begin
        Acum := 0;
        write('Piso: ',Piso:2);
        for i:= 1 to N do
            if (Mat[i,2] = Piso) then
                Acum := Acum + Mat[i,3];
        WriteLn(' | Personas: ',Acum);
        Total := Total + Acum;
        end;
    WriteLn('Total Personas: ',Total);
end;

{---------------------------------------------------------------------------------------}
{ a2. Para CADA DÍA, la cantidad de personas que ingresaron. }
procedure DiaPersonas (
    Mat    : TM;
    N      : word;
    DiaMax : byte
);   

var
    i     : word;
    Dia   : byte;
    Acum  : byte;
    Total : word;

begin
    Total := 0;
    for Dia:=1 to DiaMax do
        begin
        Acum := 0;
        write('Dia: ',Dia:2);
        for i:= 1 to N do
            if (Mat[i,1] = Dia) then
                Acum := Acum + Mat[i,3];
        WriteLn(' | Personas: ',Acum);
        Total := Total + Acum;
        end;
    WriteLn('Total Personas: ',Total);
end;


{---------------------------------------------------------------------------------------}
{ b. Cantidad total de personas ingresadas al edificio durante el mes. }
function TotalPersonas (
    Mat : TM; 
    N   : word
):word;

var
    i   : word;
    Aux : word;

begin
    Aux := 0;
    for i:=1 to N do
        Aux := Aux + Mat[i,3];
    
    TotalPersonas := Aux;
end;


{---------------------------------------------------------------------------------------}
{ c. Promedio diario de personas que ingresaron a cada piso. }
procedure PromedioDiario (
    Mat     : TM; 
    N       : word;
    DiaMax  : byte;
    PisoMax : byte
);

var
    i     : word;
    Piso  : byte;
    Acum  : byte;
    Total : real;

begin
    for Piso:=1 to PisoMax do
        begin
        Acum := 0;
        write('  Piso: ',Piso:2,' -> ');
        for i:= 1 to N do
            if (Mat[i,2] = Piso) then
                Acum := Acum + Mat[i,3];
        WriteLn('Promedio Diario = (',Acum,' / ',DiaMax,') = ',Acum/DiaMax:5:2);
        Total := Total + Acum;
        end;
    WriteLn;
    WriteLn('PROMEDIO DIARIO TOTAL -> ',Total/DiaMax:5:2);
end;


{---------------------------------------------------------------------------------------}
{d. Para un determinado día, el porcentaje de personas que ingresaron dicho día 
sobre el total del mes.}
function Porcentaje (
    Mat    : TM;
    N      : word;
    Day    : byte;
    TotalP : word
):real;   

var
    i    : word;
    Acum : byte;

begin
    Acum := 0;
    for i:=1 to N do
        if (Mat[i,1] = Day) then
            Acum := Acum + Mat[i,3];
    
    Porcentaje := Acum*100/TotalP;
end;


{---------------------------------------------------------------------------------------}
{PROGRAMA PRINCIPAL}
var
    Mat      : TM;
    N        : word;

    DiaMax   : byte;
    PisoMax  : byte;

    Storey   : byte;
    Day      : byte;
    Personas : byte;
    S        : char;

    TotalP   : word;
    Porc     : real;

    Y        : byte;

begin
    LeerMatriz(Mat, N);
    ClrScr;

    (* WriteLn('Matriz Ingresada: ');
    Writeln;
    MostrarMatriz(Mat, N); *)

    DiaMax := MaxDia(Mat, N);
    PisoMax := MaxPiso(Mat, N);
    
    (* Separador;
    WriteLn('Máximo de días  : ',diaMax:3);
    WriteLn('Máximo de Pisos : ',PisoMax:3); *)

    repeat
        ClrScr;
        WriteLn('Cantidad de Personas que ingresaron por piso y por día');
        
        repeat
        Write(' Ingrese Piso (1-',PisoMax,'): ');
        ReadLn(Storey);
        until (Storey >= 1) and (Storey <= PisoMax);

        repeat
            Write(' Ingrese Día  (1-',DiaMax,'): ');
            ReadLn(Day);
        until (Day >= 1) and (Day <= DiaMax);
        
        Personas := PisoDiaPersonas(Mat, N, Storey, Day);

        writeLn;
        WriteLn(' Ingresaron ',Personas,' personas.-');
        WriteLn;
        Write('ENTER -> Seguir | Salir -> "S" : ');
        Read(S);
        S := UpCase(S);
    until S = 'S';

    (* Separador;
    PisoPersonas(Mat, N, PisoMax);
    Separador;
    DiaPersonas(Mat, N, DiaMax); *)
    
    Separador;

    TotalP := TotalPersonas(Mat, N);
    WriteLn('Total de personas: ',TotalP);
    
    Separador;

    WriteLn('Promedio Diario de personas que ingresaron a cada piso:');
    WriteLn;
    PromedioDiario(Mat, N, DiaMax, PisoMax);

    Separador;

    WriteLn('Para un determinado día el porcentaje de personas.');
    WriteLn;
    repeat
        repeat
            Write(' Ingrese Día (1-',DiaMax,') : ');
            ReadLn(Day);
        until (Day >= 1) and (Day <= DiaMax);
        
        Porc := Porcentaje(Mat, N, Day, TotalP);
        
        WriteLn(' Porcentaje         : ',Porc:0:2,' %');
        WriteLn;
        Write('ENTER -> Seguir | Salir -> "S" : ');
        Read(S);
        WriteLn;
        S := UpCase(S);
    until S = 'S';

    Separador;

    WriteLn('FIN');

end.