// TEMA 4
// EJERCICIO 7

// Rehacer el ejercicio 2.

// Ahora los datos están en el archivo ‘Numeros.TXT’ donde en la primer
// línea se encuentran los valores de A y B (con A < B),
// no se sabe cuántos números reales hay,

// calcular e informar el promedio de los que pertenecen al intervalo [A, B]

program T4Ej7;

{$codepage UTF8}

uses crt;

var
    A, B   : real; { Intervalo [A, B]                                       }
    Numero : real; { Numero ingresado por el usario                         }

    Cont   : byte; { Cont: para los del intervalo. | ContTot: para el total }
    Acum   : real; { Autosuma de los Numeros que pertenecen al Intevalo     }

    FileName : string;
    Path   : string;

    arch   : text;

begin
repeat
clrscr();
    Cont := 0;
    Acum := 0;

    WriteLn('Ingrese NOMBRE del Archivo');

    TextColor(yellow);
    Write(' D:\PascalFiles\');

    TextColor(green);
    ReadLn(FileName);

    TextColor(white);
    Path := concat('D:\PascalFiles\', FileName);


    assign (arch, Path); { WARNING: path, nombre, extensión                                 }

    reset (arch);        { Prepara el archivo }

                         { OJO si tengo un reset() tengo que tener un close() }


    readln (arch, A, B); { con Read leo horizontal, con ReadLn leo vertical                 }
                         { Pascal detecta el espacio y el salto de línea                    }

                         { Opcion 2         }
                         { read(arch, A);   }
                         { readln(arch, B); }

                         { Opcion 3         }
                         { read(arch, A);   }
                         { read(arch, B);   }
                         { readln(arch);    }

        { Mientras NO Fin De Archivo del archivo hacer}
     while not eof(arch) do begin
        readln(arch, Numero);
        if ((Numero >= A) and (Numero <= B)) then begin
            Cont := Cont + 1;
            Acum := Acum + Numero;
        end; { if }
     end;    { while }

    close(arch); { Cierra el reset() }

    WriteLn();

    if (Cont <> 0) then
        WriteLn('El promedio es: ', (Acum / Cont):10:7)
    else
        Write('No hay numeros en el intervalo.');

    WriteLn();
    Write('ENTER para reiniciar...');
    readln();

until FALSE;
end.