(*
4.- Reescribir el Ejercicio 17 del capítulo 3 para un conjunto de pagos, calculando el importe a
abonar mediante una función real.

TEMA 3
Ejercicio 17
Un pago puede realizarse con:

{Tarjeta de crédito,de débito o en efectivo,
obteniéndose incremento del 7%, 5% o descuento del 10% respectivamente
sobre el monto original.
Se pide leer el tipo de pago (C, D, E) y el monto
para calcular e informar el importe a abonar.}

{Ingresar Monto}
{Seleccionar y Aplicar:}
   { C   :=  7% incremento }
   { D   :=  5% incremento }
   { E   := 10% descuento  }
{Mostar resultado}

*)

program T5_Ej04;
uses crt;
function importe(Monto:real; TipoPago:char):real;
begin
    case TipoPago of
        'C': importe := Monto*(1.07);
        'D': importe := Monto*(1.05);
        'E': importe := Monto*(0.90);
    end; {case}
end; {function}

var
    Monto    : real;
    TipoPago : char;
    q        : char;

begin {main}
    repeat
    ClrScr;
    WriteLn('-------------------------------');
    WriteLn('DETERMINACION DEL IMPORTE FINAL');
    WriteLn('-------------------------------');
    WriteLn;

    { Ingreso y Validación de Monto }
    TextColor(yellow);
    repeat
        gotoxy(1,5);
        clreol;
        Write('Ingrese Monto: ');
        ReadLn(Monto);
    until Monto > 0;
    TextColor(white);
    WriteLn;
    
    WriteLn('Seleccione Tipo de Pago');
    Writeln(' • Tarjeta de Crédito: "C"');
    Writeln(' • Tarjeta de Débito : "D"');
    Writeln(' • Pago en Efectivo  : "E"');
    
    { Ingreso y Validación de Tipo de Pago }
    TextColor(yellow);
    repeat
        gotoxy(1,11);
        clreol;
        Write('Tipo de Pago: ');
        ReadLn(TipoPago);
        TipoPago := UpCase(TipoPago);
    until (TipoPago = 'C') or (TipoPago = 'D') or (TipoPago = 'E');

    WriteLn;
    TextColor(cyan);
    WriteLn('-------------------------------------------');
    WriteLn('    El Importe a Abonar es de: ',importe(Monto,TipoPago):0:2);
    WriteLn('-------------------------------------------');

    { SALIDA }
    WriteLn;
    TextColor(red);
    WriteLn('q -> sale');
    TextColor(white);
    q := readkey;
    q := UpCase(q);
    if q = 'Q' then
        halt;
    until false;
end. {main}