// TEMA 4
// Ejercicio 8

// Leer números desde un archivo e
// informar la cantidad de veces en que un número es igual al que le antecede.

// SALIDA: CANTIDAD

program T4Ej8;

{$codepage UTF8}

uses crt;

var
    NumAct   : real; { Numero Actual       }
    NumAnt   : real; { Numero Anterior     }

    Cont     : byte; { Contador de iguales }

    Ruta     : string;
    Nombre   : char;
    Path     : string;

    Res      : char;

    arch     : text;

begin
repeat
clrscr();
    Cont   := 0;

    WriteLn('--------------------------------------------------------------------');
    WriteLn('Informa la CANTIDAD de veces que un número es igual a su antecedente');
    WriteLn('--------------------------------------------------------------------');

    WriteLn();

    repeat
        Write('¿Los archivos .txt están alojados en la misma carpeta que el .pas? (S | N): ');
        TextColor(green);
        ReadLn(Res);
        TextColor(white);
        Res := UpCase(Res);
    until (Res = 'S') or (Res = 'N');
    WriteLn();

    if Res = 'N' then
        begin
        Write('  Introduzca la RUTA COMPLETA de la carpeta contenedora: ');
        TextColor(green);
        ReadLn(Ruta);

        TextColor(white);
        WriteLn();
        end;

    WriteLn('Archivos .txt Disponibles:');
    WriteLn('  "Ejer8_a"');
    WriteLn('  "Ejer8_b"');
    WriteLn('  "Ejer8_c"');
    WriteLn();

    { VALIDACIÓN DE OPCION DE ARCHIVO }
    repeat
        TextColor(yellow);
        Write('SOLO Ingrese a, b ó c: ');

        TextColor(green);
        ReadLn(Nombre);
        Nombre := LowerCase(Nombre);
        TextColor(white);
    until (Nombre = 'a') or (Nombre = 'b') or (Nombre = 'c');

    { DECISIÓN DEL PATH }
    if Res = 'N' then
        Path := concat(Ruta, '\', 'ejer8_', Nombre, '.txt')
    else
        Path   := concat('ejer8_', Nombre, '.txt');

    { ASIGNACIÓN Y PREPARACIÓN DE ARCHIVO }
    assign (arch, Path);
    reset  (arch);

    { PROCESO }
    Read(arch, NumAct);
    NumAnt := NumAct;

    WriteLn();
    Write('Datos del Archivo:');      { Para hacer un checkeo nada más }

    while not eof(arch) do
        begin
        Write(' | ', NumAct:0:1);     { Para ver los Datos de Archivo* }
        Read(arch, NumAct);
        if NumAct = NumAnt then
            Cont := Cont + 1;
        NumAnt := NumAct;
        end;
    WriteLn(' | ',NumAct:0:1, ' | '); { *Para ver el último Dato }

    close(arch); { Cierra el reset()}

    { SALIDA DE INFORMACION }
    WriteLn();
    WriteLn('La CANTIDAD es: ', Cont);

    WriteLn();
    Write('ENTER para reiniciar...');
    readln();

until FALSE;
end.