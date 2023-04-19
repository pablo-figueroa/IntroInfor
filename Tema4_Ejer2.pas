// 2.-Leer dos valores reales A y B (A < B), luego N números reales,
// calcular e informar el promedio de los que pertenecen al intervalo [A, B]

//   Ejemplos: A= - 2.5 y B=30.8
//     Los números son:
//       a) -1.3, 0, 50, -3.7, 5.5, 30.9  promedio = 1.4
//       b) -13, 80.3, 50, -3.7, 55, 30.9  no hay números en el intervalo


program Tema4_Ej2;
{$codepage UTF8}   { Para que me tome los acentos y caracteres }
uses crt;

var
    A, B   : real; { Intervalo [A, B]                                       }
    Numero : real; { Numero ingresado por el usario                         }
    Acum   : real; { Autosuma de los Numeros que pertenecen al Intevalo     }

    Cont   : byte; { Cont: para los del intervalo. | ContTot: para el total }
    Res    : char; { Respuesta de Ingresar Dato?                            }

begin
repeat
    clrscr();

    Cont := 0;
    Acum := 0;

        { TITULO }
    WriteLn('INTERVALO [x, y] Y PROMEDIO DE LOS NUMEROS INCLUIDOS.');
    WriteLn();

        { ENTRADA DE DATOS }
    WriteLn('Ingresar dos valores para determinar el intervalo [A, B]');
    Write('  • Ingresar el valor A: ');
    ReadLn(A);

    Write('  • Ingresar el valor B: ');
    ReadLn(B);

    while B <= A do { Validar que B sea mayor que A }
        begin
        write('  Error. B debe ser mayor que A. INGRESE B: ');
        ReadLn(B);
        end;
    WriteLn();

    WriteLn('Intervalo Seleccionado: [',A:0:2,', ',B:0:2,']');
    WriteLn();

    Write('¿Ingresar Datos? (S ó N): ');
    ReadLn(Res);
    Res := UpCase(Res); { minuscula a MAYUSCULA }

    while Res = 'S' do
      begin
      Write(' • Ingrese un Numero Real: ');
      ReadLn(Numero);

      if ((Numero >= A) and (Numero <= B)) then
          begin
          Cont := Cont + 1;
          Acum := Acum + Numero;
          end;

      WriteLn();
      Write('¿Ingresar Datos? (S ó N): ');
      ReadLn(Res);
      Res := UpCase(Res);
      end;

    WriteLn();

        { CALCULOS Y SALIDA DE INFORMACIÓN }

    if (Cont <> 0) then
        WriteLn('El promedio es: ', (Acum / Cont):7:4)
    else
        Write('No hay numeros en el intervalo.');

    readln();

until FALSE;
end.