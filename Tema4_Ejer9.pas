// TEMA 4
// EJERCICIO 9.-

// Rehacer el ejercicio 4 (leyendo desde archivo)

// Ingresar un valor entero X por teclado y luego:
//   a) Informar el mayor múltiplo de X, poniendo un cartel aclaratorio si no existiera.
//   b) Generar un Archivo ‘Multiplo.TXT’ con todos los múltiplos de X que hubiera.

// EJERCICIO 4: Dado un conjunto de números enteros distintos de cero,
// informar el mayor múltiplo de 3.

program T4Ej9;
{$codepage UTF8}
uses crt;
var
    Numero : int32; { Será leído de archivo                     }
    MayorX : int32; { Almacena Multiplo Mayor de X seleccionado }

    X      : byte;  { Averiguar el mayor multiplo de X          }

    Cont   : byte;  { Si cuenta cero: archivo vacío             }

    Ruta   : string;
    Nombre : char;

    PathE  : string; { Ruta de Entrada }
    PathS  : string; { Ruta de Salida  }

    Res    : char;  { Respuesta de ubicación de archivos        }

    archE  : text;
    archS  : text;

begin
repeat
clrscr();
    { INICIALIZACIÓN }
    Cont   := 0;
    MayorX := low(int32);

    { TITULO }
    Textcolor(yellow);
    WriteLn('-----------------------------------');
    Writeln('DEVUELVE NUMERO MAYOR MULTIPLO DE X DESDE UN ARCHIVO');
    WriteLn('-----------------------------------');
    Textcolor(white);

    WriteLn();

    { VALIDAR X }
    repeat
        Write('Ingresar X: ');
        Textcolor(green);
        ReadLn(X);
        Textcolor(white);
    until X >= 2;
    Textcolor(white);
    WriteLn();

    { DONDE ESTÁN LOS ARHIVOS }
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

    { LISTA ARCHIVOS CON LOS QUE TRABAJAREMOS}
    WriteLn('Archivos .txt Disponibles:');
    WriteLn('  "Ejer9_a"');
    WriteLn('  "Ejer9_b"');
    WriteLn('  "Ejer9_c"');
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
        begin
        PathE := concat(Ruta, '\', 'Ejer9_', Nombre, '.txt');
        PathS := concat(Ruta, '\', 'MULTIPLO.txt');
        end
    else
        begin
        PathE   := concat('Ejer9_', Nombre, '.txt');
        PathS   := 'MULTIPLO.txt';
        end;

    { ASIGNACIÓN Y PREPARACIÓN DE ARCHIVO }
    Assign (archE, PathE);
    Reset  (archE);

    Assign(archS, PathS);
    ReWrite(archS);

    { PROCESO }
    WriteLn();
    TextColor(8);
    Write('  Datos del Archivo:');
    while not eof(archE) do
        begin
        Cont := Cont + 1;
        Read(archE, Numero);
        Write('||',Numero);
        if Numero mod X = 0 then
            begin
            Write(archS, Numero, ' ');
            if Numero > MayorX then
                begin
                MayorX := Numero;

                end;
            end;
        end;

    if Cont > 0 then
        WriteLn('||');

    WriteLn();
    Textcolor(yellow);
    if Cont = 0 then
        begin
        TextColor(red);
        Writeln('  EMPTY FILE');
        end
    else
        if MayorX = low(int32) then
            begin
            TextColor(red);
            WriteLn('No se encontró Múltiplo de ',X);
            end
        else
            begin
            Writeln('El Número Mayor Multiplo de ',X, ' es: ', MayorX);
            WriteLn('TODOS los Multiplos de : ', X, ' se han guardado en el archivo MULTIPLO.txt');

            end;


    close(archE);
    close(archS);


    Writeln();
    Textcolor(green);
    Write('ENTER para reiniciar');
    Textcolor(white);
    readln();

until FALSE;
end.