//3.-Dado un conjunto de números enteros distintos de cero,
// informar el menor y el mayor de ellos.

program T4Ej3;
{$codepage UTF8}  {Para que tome los acentos y demás}
uses crt;

var
   Numero  : int32; { sino poner integer y listo                            }
   Menor   : int32; { sino poner integer y listo, pero ojo al inicializarlo }
   Mayor   : int32; { sino poner integer y listo, pero ojo al inicializarlo }

   Numero1 : int32; { sino poner integer y listo                            }
   Numero2 : int32; { sino poner integer y listo                            }

begin
repeat { Para generar un ciclo infinito del programa }
clrscr();

     Menor  := high(int32); { equivale a  (2^32 / 2) - 1 }
     Mayor  := low(int32);  { equivale a -(2^32 / 2)     }
     Numero := 0;

        {TITULO}

     textcolor(yellow);
     Writeln('INFORMA EL MAYOR Y EL MENOR DE UN CONJUNTO DE NUMEROS DISTINTOS DE CERO');
     Writeln('Primero de debe ingresar al menos 2 números.');
     textcolor(white);
     Writeln();

        { ENTRADA DE DATOS }

        { Entrada del Primer Número necesario para comparar }
     repeat
        Write('Ingrese un número 1: ');
        readln(numero1);
        if (numero1 = 0) then { Para generar mensaje de error }
            begin
            textcolor(red);
            Writeln(' Error de número. No puede ser 0');
            textcolor(white);
            end;
     until (numero1 <> 0);

        { Entrada del Segundo Número necesario para comparar }
     repeat
        Write('Ingrese un número 2: ');
        readln(numero2);
        if (numero2 = 0) then { Para generar mensaje de error }
            begin
            textcolor(red);
            Writeln(' Error de número. No puede ser 0');
            textcolor(white);
            end;
     until (numero2 <> 0);

        { PRIMERA ASIGNACIÓN DE MAYOR Y MENOR }
     if numero1 > numero2 then
        begin
        Mayor := Numero1;
        Menor := numero2;
        end
     else
        begin
        Mayor := Numero2;
        Menor := numero1;
        end;

        { MENSAJE }
     WriteLn();
     textcolor(yellow);
     Writeln('Para finalizar entrada de datos: "0"');
     textcolor(white);

        { INGRESO DE MAYOR CANTIDAD DE NÚMEROS PARA COMPARAR }
     WriteLn();
     Write('Ingrese OTRO número: ');
     ReadLn(Numero);

     while (Numero <> 0) do
           begin

           if Numero < Menor  then
              Menor := Numero
           else
               if Numero > Mayor then
                  Mayor := Numero;

           Write('Ingrese OTRO número: ');
           ReadLn(Numero);
           end;

        {SALIDA DE INFORMACIÓN}
      Writeln();
      If Mayor = Menor then
          Write('Mayor y Menor son iguales: ', Mayor)
      else
          begin
          Writeln('Menor: ', Menor:12);
          Writeln('Mayor: ', Mayor:12);
          end;

      Writeln();
      Textcolor(green);
      Write('ENTER para reiniciar');
      Textcolor(green);
      readln();

until FALSE;
end.