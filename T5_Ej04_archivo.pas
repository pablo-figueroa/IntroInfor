(*
4.- Reescribir el Ejercicio 17 del capítulo 3 para un conjunto de pagos, calculando el importe a
abonar mediante una función real.

// TEMA 3
// Ejercicio 17
//Un pago puede realizarse con:

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
function Importe(TP:char; Monto:real):real;
begin
    case TP of
        'C': importe := Monto*(1.07);
        'D': importe := Monto*(1.05);
        'E': importe := Monto*(0.90);
    end; {case}
end; {function}

var
    TipoPago : char;
    Monto    : real;
    arch     : text;

begin {main}
    Assign(arch, 'T5_Ej04_pagos.txt');
    Reset(arch);
    WriteLn('-------------------------------');
    WriteLn('DETERMINACION DEL IMPORTE FINAL');
    WriteLn('-------------------------------');
    WriteLn;

    while not eof(arch) do
        begin
            ReadLn(arch, TipoPago,Monto);
            case TipoPago of
                'C': 
                    begin
                    TextColor(red);
                    Write('Medio de Pago: ',TipoPago);
                    Write(' | Monto: ',Monto:7:2);
                    WriteLn(' | Importe a Abonar: ',importe(TipoPago,Monto):7:2);
                    end;
                    
                'D':
                    begin
                    TextColor(5);
                    Write('Medio de Pago: ',TipoPago);
                    Write(' | Monto: ',Monto:7:2);
                    WriteLn(' | Importe a Abonar: ',importe(TipoPago,Monto):7:2);
                    end;
                'E':
                    begin
                    TextColor(green);
                    Write('Medio de Pago: ',TipoPago);
                    Write(' | Monto: ',Monto:7:2);
                    WriteLn(' | Importe a Abonar: ',importe(TipoPago,Monto):7:2);
                    end;
    end; {case}

        end; {while}
    
    ReadLn;
end. {main}