                    (*
----------------------------- EJERCICIO 1 -----------------------------

    Ingresar K números que representan montos de ventas de una empresa,
ordenados en forma ascendente.

        1 1500
        2 2500
        3 2000

    Calcular y mostrar por pantalla el promedio de los mismos y
el % de participación de cada uno respecto de la suma total en forma descendente.


    IMPORTE TOTAL DE VENTAS  : 6000
    CANTIDAD TOTAL DE VENTAS :    3
    PROMEDIO                 : 2000

    Orden |     Venta | Participación
        3 |   2000.00 |       33.33 %
        2 |   2500.00 |       41.67 %
        1 |   1500.00 |       25.00 %


Importante :
    * Cada proceso (lectura, escritura, cálculo) debe ser implementada mediante un procedimiento o
función, según corresponda, correctamente parametrizada. No utilizar variables globales.
    * Aunque no se explicite, informar siempre los resultados obtenidos.
    * Antes de comenzar a hacer el algoritmo arme un ejemplo y resuelva manualmente.

NOTAS DE LA VERSION:
    Función para la Suma.
    Función para el Promedio.
*)

program T6_Ej01;
{$codepage UTF8}
uses crt;
type
    TV_50real = array[1..50] of real;

{ INGRESAR LAS VENTAS ------------------------------------------------------------------------}
procedure LeerVentas
    (
        var Ventas : TV_50real ;
        var v      : byte
    );

begin
    v := 1;
    repeat
        ClrScr;
        gotoxy(1,1);
        Write('Fin -> 0 | Ingresar Venta N° ',v,': ');
        ReadLn(Ventas[v]);
    until (Ventas[v] >= 0);

    while Ventas[v] <> 0 do
        begin
        v := v +1;
        repeat
            ClrScr;
            gotoxy(1,1);
            Write('Fin -> 0 | Ingresar Venta N° ',v,': ');
            ReadLn(Ventas[v]);
        until (Ventas[v] >= 0);
    end;{while}
end;{procedure}


{ SUMA ---------------------------------------------------------------------------------------}
function Sum
    (
        Venta   : TV_50real;
        v       : byte
    ):real;

var
    i   : byte;
    Aux : real;

begin
    Aux:=0;
    for i:=1 to (v-1) do
        Aux := Aux + Venta[i];
    Sum := Aux;
end;{function Sum}


{ PROMEDIO -----------------------------------------------------------------------------------}
function Prom
    (
         Sum : real;
         v   : byte
    ):real;

begin
    Prom := Sum / (v-1);
end;{function Prom}



{ VENTAS Y PARTICIPACION EN EL TOTAL ---------------------------------------------------------}
procedure VentaPart
    (
        Ventas : TV_50real;
        v      : byte;
        Sum    : real
    );

var i : byte;

begin
    WriteLn('Orden |     Venta | Participación');
    for i := (v-1) downto 1 do
        begin
        WriteLn((v-1):5,' | ',Ventas[v-1]:9:2,' | ',(Ventas[v-1]*100/Sum):11:2,' %');
        v := v -1;
        end;
end;{procedure VentaPart}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
        Ventas   : TV_50real ;
        v        : byte     ;
        Suma     : real     ;

begin
    ClrScr;
    LeerVentas(Ventas,v);
    Suma := Sum(Ventas,v);

    ClrScr;
    Writeln('CANTIDAD DE VENTAS : ',(v-1)        :9);
    Writeln('SUMAS DE VENTAS    : ',Suma         :9:2);
    Writeln('PROMEDIO           : ',Prom(Suma,v) :9:2);
    WriteLn;
    VentaPart(Ventas,v,Suma);
    ReadLn;
end.