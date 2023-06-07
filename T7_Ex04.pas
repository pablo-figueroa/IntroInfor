(*
EJERCICIO 4
Version KISS

Se han registrado las ventas mensuales de cada uno de M empleados en el último semestre. 
Cada mes se ha establecido un objetivo de importe de ventas a cumplir. 

Se pide leer la información desde un archivo el cual consta:
    * en la primer línea un número que indica la cantidad de EMPLEADOS
    * desde la segunda línea: una matriz de 6xM real, en la cual el último vector, de 6 elementos reales, es referente a los objetivos.

Calcular e informar:
    a. Cuantos fueron los meses en los cuales todos los empleados superaron el objetivo
    b. Dado un número de empleado (1..N) cuantos meses no cumplió el objetivo

*)

program T7_Ex04;

//{$codepage UTF8}

uses crt;

type
    TM = array[1..50,1..50] of real;

const
    N : byte = 6; { es dato que el tamaño de filas de la Matriz es 6 }
    

{---------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('-------------------------------------------------------------');
    WriteLn;
end;{procedure}


{---------------------------------------------------------------------------------------}
{ Leer Archivo y Generar Matriz }
procedure LeeArchGenMat (
    var Mat : TM;
    var M   : byte
);

var
    i : byte;
    j : byte;
    arch : text;

begin
    Assign(arch, 'T7_Ex04_KISS.txt');
    Reset(arch);
    ReadLn(arch, M);
    
    for i:=1 to N do
        begin
        for j:=1 to M+1 do          { M col de Emplados + 1 col de Objetivos}
            read(arch, Mat[i,j]);
        ReadLn(arch);
        end;
    Close(arch);
end;


{---------------------------------------------------------------------------------------}
procedure MostrarMatriz (
    Mat : TM;
    M   : byte
);

var
    i : byte;
    j : byte;

begin
    for i:=1 to N do
        begin
        write('Mes: ',i,'  | ');
        for j:=1 to M+1 do
            if j <= M then
                write(Mat[i,j]:9:2)
            else    
                begin
                TextColor(yellow);
                write(Mat[i,j]:9:2);
                TextColor(white);
                end;
        WriteLn('  |');
        end;
end;


{---------------------------------------------------------------------------------------}
{ a. Cuantos fueron los meses en los cuales todos los empleados SUPERARON el objetivo }

{ IMPORTANTE! OJO CON LA UBICACIÓN DE LA FUNCIÓN SECUNDARIA!!! }
{ a.2 - Función Secundaria }
function SuperaObj(
    Mat :TM; 
    Mes :byte;
    M   :byte 
):boolean;

var j : byte;

begin
    SuperaObj := False;
    j := 1;
    while (j <= M) and (Mat[Mes,j] > Mat[Mes,M+1]) do { M-1 pq la última col es de los Objetivos de Vtas. }
        j := j + 1;
    if j > M then
        SuperaObj := True;
end;

{---------------------------------------------------}
{ a.1 - Función Primaria }
function CantMeses (
    Mat : TM; 
    M   : byte
):byte;

var 
    i, Cont : byte;

begin
    Cont := 0;
    for i:=1 to 6 do
        if SuperaObj(Mat, i, M) then 
            Cont := Cont +1;

    CantMeses := Cont;
end;


{---------------------------------------------------------------------------------------}
{ b. Dado un número de empleado (1..N) cuantos meses no CUMPLIÓ el objetivo }
{ Dice "cumplió", no dice "superó" }
function CantNoCumple (
    Mat  : TM;
    M    : byte;
    NumE : byte
):byte;

var
    i           : byte;
    NoCumpleObj : byte; { NO Cumple el Objetivo }

begin
    NoCumpleObj := 0;
    for i:=1 to N do
        begin
        if Mat[i,NumE] < Mat[i,M+1] then { CUMPLE si Vtas >= Objetivo | NO CUMPLE si Ventas < Objetivo }
            NoCumpleObj := NoCumpleObj + 1;    
        end;
    CantNoCumple := NoCumpleObj;
end;


{---------------------------------------------------------------------------------------}
{ b. Dado un número de empleado (1..N) cuantos meses no CUMPLIÓ el objetivo }
{ MOSTRAR LA COMPARACIÓN }
procedure MostrarComparacion (
    Mat  : TM;
    M    : byte;
    NumE : byte
);

var
    i           : byte;

begin
    for i:=1 to N do
        begin
        if Mat[i,NumE] < Mat[i,M+1] then { CUMPLE si Vtas >= Objetivo | NO CUMPLE si Ventas < Objetivo }
            begin
            TextColor(red);
            Write('  ',Mat[i,NumE]:8:2,' vs ');
            end
        else
            begin
            TextColor(green);
            Write('  ',Mat[i,NumE]:8:2,' vs ');
            end;
        TextColor(yellow);
        Writeln(Mat[i,M+1]:8:2);
        end;
    TextColor(white);
end;

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
{PROGRAMA PRINCIPAL}
var
    Mat  : TM;
    M    : byte;
    NumE : byte;

    Y1 : byte; { Ubicación y en la pantalla }
    Y2 : byte; { Ubicación y en la pantalla }
    S : char; { para salir }

begin
    ClrScr;
    LeeArchGenMat(Mat, M);

    WriteLn('Registro de Ventas: ');
    Writeln;
    Write('        | Ventas y ');
    TextColor(yellow);
    Writeln('Objetivos Mensuales');
    TextColor(white);
    Writeln;
    MostrarMatriz(Mat, M);

    Separador;

    WriteLn('Meses que todos alcanzaron el objetivo: ',CantMeses(Mat, M));

    Separador;

    Y1 := WhereY;
    
    repeat
        repeat
            Write('Ingrese un número de empleado (1..',M,'): ');
            ReadLn(NumE);
        until (NumE >= 1) and (NumE <= M);
    
        WriteLn;
        WriteLn('  Cantidad de meses que NO CUMPLIÓ el objetivo: ',CantNoCumple(Mat, M, NumE));
        WriteLn;
        MostrarComparacion(Mat, M, NumE);
        
        Separador;
        TextColor(red);
        Write('ENTER -> Repite | S -> Sale : ');
        TextColor(white);
        Read(S);
        S := UpCase(S);
        
        Y2 := WhereY;
        if S <> 'S' then
            ClrYY(Y1,Y2);

    until S = 'S';

    Separador;

    Write('FIN ');
    ReadLn;

end.