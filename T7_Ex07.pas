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

program T7_Ex07;

//{$codepage UTF8}

uses crt;

type
    TM = array[1..31,1..100] of byte;
    TV = array[1..100] of real;


{---------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('---------------------------------------------------------------------------------------');
    WriteLn;
end;{procedure}


{---------------------------------------------------------------------------------------}
{ Limpiar pantalla entre Y1 y Y2 }
procedure ClrYY (
    Y1, Y2 : byte
);

var i : byte;

begin
    for i:=Y2-Y1+1 downto 0 do
        begin
        gotoxy(1,Y1+i);
        ClrEOL;
        end;
end;


{---------------------------------------------------------------------------------------}
procedure IniciaMat(var Mat : TM);

var i,j : byte;

begin
    for i:= 1 to 31 do
        for j:= 1 to 25 do
            Mat[i,j] := 0;

end;



{---------------------------------------------------------------------------------------}
{ Averiguar el día máximo y piso máximo }
procedure MaximoDiaPiso (
    var MaxDia  : byte;
    var MaxPiso : byte
);

var
    arch    : text;
    AuxDia  : byte;
    AuxPiso : byte;

begin
    MaxDia  := 0;
    MaxPiso := 0;
    Assign(arch, 'T7_Ex07.txt');
    Reset(arch);
    
    while not eof(arch) do
        begin
        readLn(arch, AuxDia, AuxPiso);
        if AuxDia > MaxDia then
            MaxDia := AuxDia;
        
        if AuxPiso > MaxPiso then
            MaxPiso := AuxPiso;
        end;
end;


{---------------------------------------------------------------------------------------}
{ Inicializar en 0 la Matriz Acumulativa }
procedure IniciaMatriz (
    Mat     : TM;
    DiaMax  : byte;
    PisoMax : byte
);

var
    i,j : byte;

begin
    for i := 1 to DiaMax do
        for j:= 1 to PisoMax do
            Mat[i,j] := 0;
end;


{---------------------------------------------------------------------------------------}
{ Leer Archivo y Generar Matriz }
procedure LeeArchGenMat (
    var Mat : TM
);

var 
    dia,piso,pers : byte;
    arch : text;

begin
    Assign(arch, 'T7_Ex07.txt');
    Reset(arch);

    while not eof(arch) do
        begin
        ReadLn(arch, dia,piso,pers);
        Mat[dia,piso] := Mat[dia,piso] + pers;
        end;
        
    Close(arch);
end;


{---------------------------------------------------------------------------------------}
{ a. Para CADA PISO Y CADA DÍA, la cantidad de personas que ingresaron. }

procedure MostrarMatriz (
    Mat     : TM;
    DiaMax  : byte;
    PisoMax : byte
);

var
    i,j : byte;

begin
    { Escribir el piso }
    TextColor(yellow);
    Write(' Piso -> ');
    for j:=1 to PisoMax do
        write(j:3);
    Writeln;
    TextColor(white);
    { ---------------- }
    
    for i:=1 to DiaMax do
        begin
        TextColor(yellow);
        write('Día: ',i:2,' |');
        TextColor(white);
        for j:=1 to PisoMax do
            begin
            if Mat[i,j] > 0 then
                begin
                TextColor(green);
                write(Mat[i,j]:3);
                TextColor(white);
                end
            else 
                write(Mat[i,j]:3);
            end;
        TextColor(yellow);
        WriteLn('  |');
        TextColor(white);
        end;
end;


{---------------------------------------------------------------------------------------}
{ b. Cantidad total de personas ingresadas al edificio durante el mes. }
function TotalPersonas (
    Mat     : TM;
    DiaMax  : byte;
    PisoMax : byte
):word;

var
    i,j : byte;
    Aux : word;

begin
    Aux := 0;
    for i:=1 to DiaMax do
        for j:=1 to PisoMax do
            Aux := Aux + Mat[i,j];
    
    TotalPersonas := Aux;
end;

{---------------------------------------------------------------------------------------}
{ c. Promedio diario de personas que ingresaron a cada piso. }
{ c.1 -> Función que es llamada por el Procedimiento Promedio Diario}
function SumaPersonasByPiso (
    Mat    : TM;
    MaxDia : byte;
    Piso   : byte
): word;

var
    i : byte;
    Suma : word;

begin
    Suma := 0;
    for i:= 1 to MaxDia do
        Suma := Suma + Mat[i,Piso];
    
    SumaPersonasByPiso := Suma;
end;



{-------------------------------}
{ c.2 -> }
procedure PromedioDiario (
    Mat         : TM; 
    DiaMax      : byte;
    PisoMax     : byte;
    var VecProm : TV { La longitud del Vector de Promedios es igual a PisoMax }
);

var
    Piso : byte;
    

begin
    for Piso:=1 to PisoMax do
        VecProm[Piso] := SumaPersonasByPiso(Mat, DiaMax, Piso)/DiaMax;

    
end;

{-------------------------------}
{ c.3 -> }

procedure MostrarVector (
    VecProm : TV;
    PisoMax : byte
);

var
    j : byte;

begin
    for j:=1 to PisoMax do
        begin
        write('Piso ',j:2,' :',VecProm[j]:5:2,'     ');
        if j mod 4 = 0 then
            begin
            WriteLn;
            if TextAttr = 15 then
                TextColor(yellow)
            else
                TextColor(white);
            end;
        end;
end;


{---------------------------------------------------------------------------------------}
{d. Para un determinado día, el porcentaje de personas que ingresaron dicho día 
sobre el total del mes.}
{ d.1 }
function SumarPersonasByDay (
    Mat     : TM;
    MaxPiso : byte;
    Day     : byte
): word;

var
    j : byte;
    Aux : word;

begin
    Aux := 0;
    for j:= 1 to MaxPiso do
        Aux := Aux + Mat[Day,j];
    
    SumarPersonasByDay := Aux;
end;

{ d.2 --------------------------------}
function PorcentajePorDia (
    Mat     : TM;
    MaxPiso : byte;
    Day     : byte;
    TotalP  : word
):real;   

begin
    PorcentajePorDia := (SumarPersonasByDay(Mat, MaxPiso, Day) / TotalP) * 100;
end;


{---------------------------------------------------------------------------------------}
{PROGRAMA PRINCIPAL}
var
    Mat      : TM;

    DiaMax   : byte;
    PisoMax  : byte;

    TotalP   : word;
    
    VecProm : TV;

    Day      : byte;

    S        : char;
    Y1 : word; { Ubicación y en la pantalla }
    Y2 : word; { Ubicación y en la pantalla }

begin
    ClrScr;

    { Averiguar Día Máximo y Piso Máximo }
    MaximoDiaPiso(DiaMax, PisoMax);

    { Inicializar en 0 la Matriz Acumulativa }
    IniciaMatriz(Mat, DiaMax, PisoMax);

    { Leer Archivo y Generar Matriz Acumulativa }
    LeeArchGenMat(Mat);
    
    { a. Para cada piso y cada día, la cantidad de personas que ingresaron. }
    TextColor(cyan);
    WriteLn('a. Para cada piso y cada día, la cantidad de personas que ingresaron.');
    TextColor(white);
    WriteLn;
    MostrarMatriz(Mat, DiaMax, PisoMax);
    WriteLn;
    TextColor(red);
    Write('Al dar ENTER se quitará visualización de la Matriz... ');
    TextColor(white);
    ReadLn;
    ClrScr;

    
    { b. Cantidad total de personas ingresadas al edificio durante el mes. }
    TotalP := TotalPersonas(Mat, DiaMax, PisoMax);
    TextColor(cyan);
    WriteLn('b. Cantidad total de personas ingresadas al edificio durante el mes: ',TotalP);
    TextColor(white);

    Separador;
    
    { c. Promedio diario de personas que ingresaron a cada piso. }
    TextColor(cyan);
    WriteLn('c. Promedio diario de personas que ingresaron a cada piso.');
    TextColor(white);
    WriteLn;
    PromedioDiario(Mat, DiaMax, PisoMax, VecProm);
    MostrarVector(VecProm, PisoMax);

    Separador;

    { d. Para un determinado día, el porcentaje de personas que ingresaron dicho día sobre el total del mes. }
    TextColor(cyan);
    WriteLn('d. Para un determinado día el porcentaje de personas.');
    TextColor(white);
    WriteLn;
    Y1 := WhereY;
    repeat
        repeat
            gotoxy(1,y1);
            clrEOL;
            Write(' Ingrese Día (1-',DiaMax,') : ');
            ReadLn(Day);
        until (Day >= 1) and (Day <= DiaMax);
        
        WriteLn(' Porcentaje         : ',PorcentajePorDia(Mat, PisoMax, Day, TotalP):0:2,' %');
        WriteLn;
    
        TextColor(red);
        Write('ENTER -> Seguir | Salir -> "S" : ');
        TextColor(white);
        Read(S);
        Y2 := WhereY;
        
        S := UpCase(S);
        if S <> 'S' then
                ClrYY(Y1,Y2);
    
    until S = 'S';

    Separador;

    WriteLn('FIN');

end.