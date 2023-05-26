(*
----------------------------------------- EJERCICIO 1 -----------------------------------------
VERSIÓN 2

    Ingresar K números que representan montos de ventas de una empresa, 
ordenados en forma ascendente. (Entiendo que los K deben ser ascendentes y no los montos.)

        k Monto
        1 1500
        2 2500
        3 2000
    
    Calcular y mostrar por pantalla:
        * El promedio de los mismos y 
        * El % de participación de cada uno en forma descendente.
            (Entiendo que los K deben ser descendentes y no los % de participación.)
    
    EJEMPLO 1
        Ventas Ingresadas:
        [  1100.00  2200.00  3300.00  ]
        
        El Promedio de las Ventas es: 2200.00
        
        Porcentaje de Participación:
        [  50.00  33.33  16.67  ]

    EJEMPLO 2
        Ventas Ingresadas:
        [  1100.00  2200.00  3300.00  4400.00  5500.00  ]
        
        El Promedio de las Ventas es: 3300.00
        
        Porcentaje de Participación:
        [  33.33  26.67  20.00  13.33  6.67  ]
    
*)

program T6_Ej01;
//{$codepage UTF8}

uses crt;

type
    TV_50_Real = array[1..50] of real;


{ INGRESAR LAS VENTAS ------------------------------------------------------------------------}
procedure LeerVentas
    (
        var V : TV_50_Real; { Ventas   }
        var N : byte        { Longitud }
    );

var 
    i     : byte;

begin
    
    i := 1;
    repeat
        ClrScr;
        gotoxy(1,1);
        Write('Fin -> 0 | Ingresar Venta N° ',i,': ');
        ReadLn(V[i]);
    until (V[i] >= 0);
    
    while V[i] <> 0 do
        begin
        i := i + 1;
        repeat
            ClrScr;
            gotoxy(1,1);
            Write('Fin -> 0 | Ingresar Venta N° ',i,': ');
            ReadLn(V[i]);
        until (V[i] >= 0);
        end;{while}
    
    N := i - 1;
    { Resto 1 porque no me interesa el 0 que uso para salir del while y se agrega al Vector en eNésima posición }
    
end;{procedure}

{---------------------------------------------------------------------------------------------}
procedure MostrarVector
    (
        V : TV_50_Real; { Vector   }
        N : byte        { Longitud }
    );

var
    i : byte;

begin
    for i:=1 to N do
        Write(V[i]:0:2,'  ');      { 0 -> No quiero reservar espacios | 2 -> Quiero dos decimales }

end;{ procedure}


{---------------------------------------------------------------------------------------------}
function CalcularSuma
    (
        V : TV_50_Real; { Ventas   }
        N : byte        { Longitud }
    ):real;

var 
    i   : byte;
    Aux : real;

begin
    for i:=1 to N do
        Aux := Aux + V[i];

    CalcularSuma := aux;

end; {function}


{---------------------------------------------------------------------------------------------}
function CalcularPromedio
    (
        V  : TV_50_Real;  { Ventas   }
        N  : byte;        { Longitud }
        VT : real         { Ventas Totales }
    ):real;

var
    i   : byte;
    Aux : real;

begin
    Aux := 0;
    for i:=1 to N do
        Aux := Aux + V[i];

    CalcularPromedio := Aux / N;

end; {function}


{---------------------------------------------------------------------------------------------}
procedure CalcularParticipacion { en orden descendente }
    (
        V      : TV_50_Real;  { Ventas   }
        N      : byte;        { Longitud }
        VT     : real;        { Ventas Totales }
        var VP : TV_50_Real
    );

var 
    i : byte;

begin
    for i:=1 to N do
        begin
        VP[i] := (V[N] / VT) * 100;
        N := N - 1;
        end;

end;{procedure}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
        V_Ventas      : TV_50_Real;
        V_Part        : TV_50_Real; { Participación % }
        N             : byte;
        
        VentasTotales : real;
        Promedio      : real;

begin 
    ClrScr;
    LeerVentas(V_Ventas, N);
    ClrScr;

    WriteLn;
    WriteLn('Ventas Ingresadas:');
    Write('[  ');
    MostrarVector(V_Ventas, N);
    WriteLn(']');
    WriteLn;
    
    VentasTotales := CalcularSuma(V_Ventas, N);
    Promedio := VentasTotales / N; { Como que no tendría mucho sentido hacer una función }
    WriteLn('El Promedio de las Ventas es: ',Promedio:0:2);
    WriteLn;
    
    CalcularParticipacion(V_Ventas, N, VentasTotales, V_Part);
    
    WriteLn('Porcentaje de Participación en orden descendente:');
    Write('[  ');
    MostrarVector(V_Part, N);
    WriteLn(']');

end.