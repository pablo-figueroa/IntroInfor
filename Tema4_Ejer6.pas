// TEMA 4
// EJERCICIO 6

// Dado un conjunto de figuras geométricas y sus respectivas áreas:
//   - Figura ( ‘T’=triángulo, ‘C’=cuadrado, ‘R’=rectángulo, ‘F’=Fin de datos
//   - Area

// Informar:
// a) Porcentaje de cada tipo de figura.
// b) Figura con mayor área (suponer única).

// INTERPRETACIÓN
// Introducir tipo de figura y área.
// Actualizar área a la de mayor volumen
// Informar porcentaje
// Informar figura con mayor área

{ JUEGO DE DATOS }

{ JUEGO 1: ENTRADAS: T 4, R 5, C 2, R 1 }
{          SALIDAS: PORCENTAJES: T 25.00% | C 25.00% | R 50.00% }
{                   AREA MAYOR: R: 5.00 }

{ JUEGO 2: ENTRADAS: T 4.1, T 4.2, C 2, T 4.3 }
{          SALIDAS: PORCENTAJES: T 75.00% | C 25.00% | R 0.00% }
{                   AREA MAYOR: T: 4.30 }

Program T4Ej6;

{$codepage UTF8} {Habilitar para ver acentos.}

uses crt;

var
    Tipo       : char;   { Para ingresar: T or C or R or F }

    AreaT      : single; { Para capturar el ingreso del el área del triángulo   }
    AreaMayorT : single; { Para almacenar la mayor área de triángulo ingresado  }

    AreaC      : single; { Para capturar el ingreso del el área del cuadrado    }
    AreaMayorC : single; { Para almacenar la mayor área de cuadrado ingresado   }

    AreaR      : single; { Para capturar el ingreso del el área del rectángulo  }
    AreaMayorR : single; { Para almacenar la mayor área de rectángulo ingresado }

//  AreaMayor  :single;  { Alternativa para ir acumulando Area Mayor de Todas   }

    ContT      : byte;   { Contador de Triángulos  }
    ContC      : byte;   { Contador de Cuadrados   }
    ContR      : byte;   { Contador de Rectángulos }
    Cont       : byte;   { Contador General        }


begin
repeat { Ciclo infinito del programa }
clrscr();

    { INICIALIZACIÓN DE CONTADORES }
    ContT := 0;
    ContC := 0;
    ContR := 0;
    Cont  := 0;

    { INICIALIZACIÓN DE ACUMULADORES }
    AreaMayorT := 0;
    AreaMayorC := 0;
    AreaMayorR := 0;
//  AreaMayor  := 0;  { Alternativa para ir acumulando Area Mayor de Todas }

    {TITULO}
    WriteLn('FIGURAS GEOMÉTRICAS Y AREAS');
    WriteLn();
    WriteLn('Tener en cuenta que:');
    WriteLn('  ‘T’ = Triángulo');
    WriteLn('  ‘C’ = Cuadrado');
    WriteLn('  ‘R’ = Rectángulo');
    WriteLn('  ‘F’ = Fin de datos');



    repeat

        { Validación: entrada de letra: T, C, R, F }
        WriteLn();
        Write('Ingrese Tipo de Figura: ');
        ReadLn(Tipo);
        Tipo := UpCase(Tipo);

        while not((Tipo = 'T') or (Tipo = 'C') or (Tipo = 'R') or (Tipo = 'F')) do
            begin
            TextColor(red);
            WriteLn('  Se esperaba: T - C - R - F');
            TextColor(white);
            WriteLn();
            Write('  Reingrese Tipo de Figura: ');
            ReadLn(Tipo);
            Tipo := UpCase(Tipo);
            end;

        //repeat
        //    WriteLn();
        //    Write('Ingrese Tipo de Figura: ');
        //    ReadLn(Tipo);
        //    Tipo := UpCase(Tipo);
        //    if (Tipo <> 'T') or (Tipo <> 'C') or (Tipo = 'R') or (Tipo = 'F') then
        //        begin
        //        TextColor(red);
        //        Write('  Se esperaba: T - C - R - F');
        //        TextColor(white);
        //        WriteLn();
        //        end;
        //until (Tipo = 'T') or (Tipo = 'C') or (Tipo = 'R') or (Tipo = 'F');

        case Tipo of
            'T' :
                begin
                ContT := ContT + 1;

                Write('Ingrese área del triángulo: ');
                readln(AreaT);

                { Validación: mayor a cero }
                while AreaT <= 0 do
                    begin
                    TextColor(red);
                    WriteLn('  Dato No Esperado: Reintente');
                    TextColor(White);
                    Writeln();
                    Write('  Reingrese área del triángulo: ');
                    readln(AreaT);
                    end;

                { Almacenar si el Area es Mayor a la anterior }
                if AreaT > AreaMayorT then
                    AreaMayorT := AreaT;

                { Alternativa para ir acumulando Area Mayor de Todas }
(*                 if AreaMayorT > AreaMayor then
                    AreaMayor := AreaMayorT;   *)

                end; { 'T' }

            'C' :
                begin
                ContC := ContC + 1;

                Write('Ingrese área del cuadrado: ');
                readln(AreaC);

                { Validación: mayor a cero }
                while AreaC <= 0 do
                    begin
                    TextColor(red);
                    WriteLn('  Dato No Esperado: Reintente');
                    TextColor(White);
                    Writeln();
                    Write('  Reingrese área del triángulo: ');
                    readln(AreaC);
                    end;

                { Almacenar si el Area es Mayor a la anterior }
                if AreaC > AreaMayorC then
                    AreaMayorC := AreaC;

                { Alternativa para ir acumulando Area Mayor de Todas }
(*                 if AreaMayorC > AreaMayor then
                    AreaMayor := AreaMayorC; *)

                end; { 'C' }

            'R' :
                begin
                ContR := ContR + 1;

                Write('Ingrese área del cuadrado: ');
                readln(AreaR);

                { Validación: mayor a cero }
                while AreaR <= 0 do
                    begin
                    TextColor(red);
                    WriteLn('  Dato No Esperado: Reintente');
                    TextColor(White);
                    Writeln();
                    Write('  Reingrese área del triángulo: ');
                    readln(AreaR);
                    end;

                { Almacenar si el Area es Mayor a la anterior }
                if AreaR > AreaMayorR then
                    AreaMayorR := AreaR;

                { Alternativa para ir acumulando Area Mayor de Todas }
(*                 if AreaMayorR > AreaMayor then
                    AreaMayor := AreaMayorR; *)

                end; { 'R' }

        end; { case Tipo of }

        Cont := Cont + 1;

    until (Tipo = 'F'); { FIN: Ingresar Figura }

    Cont := Cont - 1; { Resto 1 porque el contador sumó 1 por la F }

    WriteLn();


    if Cont = 0 then
        begin
        TextColor(red);
        WriteLn('Ha salido sin ingresar Datos.');
        TextColor(white);
        end
    else
        begin
            WriteLn('MUESTRA DE PORCENTAJES:');
            WriteLn('  Triángulos:  ' , (ContT * 100 / Cont):6:2);
            WriteLn('  Cuadrados:   ' , (ContC * 100 / Cont):6:2);
            WriteLn('  Rectángulos: ' , (ContR * 100 / Cont):6:2);
            WriteLn();

            WriteLn('AREA MAYOR:');

            if (AreaMayorT > AreaMayorC) and (AreaMayorT > AreaMayorR) then
                WriteLn('  Triángulo: ', AreaMayorT:0:2)
            else
                if (AreaMayorC > AreaMayorR) then
                    WriteLn('  Caudrado: ', AreaMayorC:0:2)
                else
                    WriteLn('  Rectángulo: ', AreaMayorR:0:2);
        end;

    WriteLn();
    Write('ENTER para reiniciar...');
    readln();

until FALSE; { Ciclo infinito del programa }
end.