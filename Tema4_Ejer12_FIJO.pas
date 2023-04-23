// TEMA 4
// EJERCICIO 12.-

// Un comercio realiza el 10% de descuento por ventas mayores a $1000.

// Leer la cantidad de ventas realizadas, y luego el importe de cada una,
// calcular e informar el importe total que se otorgo en concepto de descuento y
// la cantidad de ventas que no tuvieron dicho beneficio.

// Cómo cambiaria el código si en vez de 10% y $ 1000, dichos valores fueran variables
// (igual para todas las ventas).

// INTERPRETACIÓN:
//    INFORMAR:
//              Cantidad de Ventas Totales; (sino ¿para qué las voy a leer?)
//              Importe Total de Descuentos;
//              Cantidad de Ventas sin Descuentos;



// JUEGO DE DATOS:

program T4Ej12_FIJO;

{$codepage UTF8}

uses crt;

const
    VentaMin            : single = 1000   ; { ARS 1000 }
    Desc                : single =    0.10; { 10 %     }

var
    Ruta                : string;
    Number              : char;
    Path                : string;
    arch                : text;

    Venta               : real;

    ContVenta           : byte;
    ContDevVenta        : byte;

    AcumDescSD          : real;  { Acumula los descuentos concedidos de Ventas }
    AcumDescSA          : real;  { Acumula los descuentos recuperados de devoluciones de Ventas }

    ContVentaSinDesc    : byte;
    ContDevVentaSinDesc : byte;

    Res                 : char;

    print               : byte;




begin
repeat
clrscr();
    { INICIALIZACION DE CONTADORES }
    ContVenta           := 0;
    ContDevVenta        := 0;
    AcumDescSD          := 0;
    AcumDescSA          := 0;
    ContDevVentaSinDesc := 0;
    ContVentaSinDesc    := 0;
    print               := 0;

    { TITULO }
    WriteLn('-------------------');
    WriteLn('VENTAS Y DESCUENTOS');
    WriteLn('-------------------');
    WriteLn();

    { CONDICIONES DEL DESCUENTO }
    TextColor(yellow);
    Write('Descuento del ');
    TextColor(green);
    Write('10%');
    TextColor(yellow);
    Write(' por ventas M A Y O R E S a ');
    TextColor(green);
    WriteLn('$1.000');

    TextColor(white);
    WriteLn();


    { UBICACION DE LOS ARCHIVOS }
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
        Write('  Introduzca la RUTA COMPLETA ( Ejemplo: c:\carpeta\ ) : ');
        TextColor(green);
        ReadLn(Ruta);

        TextColor(white);
        WriteLn();
        end;

    WriteLn('Archivos .txt Disponibles:');
    WriteLn('  "Tema4_Ejer12_1"');
    WriteLn('  "Tema4_Ejer12_2"');
    WriteLn('  "Tema4_Ejer12_2"');
    WriteLn('  "Tema4_Ejer12_4"');
    WriteLn();


    { VALIDACIÓN DE OPCION DE ARCHIVO }
    repeat
        TextColor(yellow);
        Write('SELECCIONE: 1, 2, 3 ó 4: ');

        TextColor(green);
        ReadLn(Number);
        TextColor(white);
    until (Number = '1') or (Number = '2') or (Number = '3') or (Number = '4');


    { DECISIÓN DEL PATH }
    if Res = 'N' then
        Path := concat(Ruta, 'Tema4_Ejer12_', Number, '.txt')
    else
        Path := concat(      'Tema4_Ejer12_', Number, '.txt');


    { ASIGNACIÓN Y PREPARACIÓN DE ARCHIVO }
    assign (arch, Path);


    { PROCESO }
    { Cantidad de Ventas Totales}
    reset(arch);
    while not eof(arch) do
        begin
        Readln(arch, Venta);
        if Venta > 0 then
            ContVenta := ContVenta + 1
        else
            ContDevVenta := ContDevVenta + 1;
        end;

    { Importe Total de Descuentos }
    close(arch);
    reset(arch);
    while not eof(arch) do
        begin
        readln(arch, Venta);

        if Venta > VentaMin then
            AcumDescSD := AcumDescSD + (Venta * Desc);

        if Venta < -VentaMin then
            AcumDescSA := AcumDescSA + (-Venta * Desc);

        end;

    { Cantidad de Ventas sin Descuentos }
    close(arch);
    reset(arch);
    while not eof(arch) do
        begin
        ReadLn(arch, Venta);

        if (Venta > 0) and (Venta <= VentaMin) then
            ContVentaSinDesc := ContVentaSinDesc + 1;

        if (Venta < 0) and (Venta >= -VentaMin) then
            ContDevVentaSinDesc := ContDevVentaSinDesc + 1;

        end;

    { SALIDA DE INFORMACIÓN }

    { CONDICIONES DEL DESCUENTO }
    clrscr();
    TextColor(yellow);
    Write('Descuento del ');
    TextColor(green);
    Write('10%');
    TextColor(yellow);
    Write(' por ventas M A Y O R E S a ');
    TextColor(green);
    WriteLn('$1.000');

    TextColor(white);

    { Cantidad de Ventas Totales}
    WriteLn();
    //WriteLn();
    WriteLn('---------------------------------------------------------------------');
    WriteLn('Cantidad de Ventas                 : ', ContVenta:2);
    WriteLn('Cantidad de Devoluciones de Ventas : ', ContDevVenta:2);

    WriteLn('---------------------------------------------------------------------');

    { Importe Total de Descuentos }

    WriteLn('---------------------------------------------------------------------');
    WriteLn('Descuentos Otorgados                    : ', AcumDescSD:8:2);
    WriteLn('Descuentos Recuperados (x Devoluciones) : ', AcumDescSA:8:2);
    TextColor(Yellow);
    WriteLn();
    WriteLn('Descuentos Netos Otorgados              : ', (AcumDescSD - AcumDescSA):8:2);
    TextColor(White);
    WriteLn('---------------------------------------------------------------------');

    { Cantidad de Ventas sin Descuentos }

    WriteLn('---------------------------------------------------------------------');
    WriteLn('Cantidad de Ventas sin Descuentos                  : ', ContVentaSinDesc:2);
    WriteLn('Cantidad de Devoluciones de Ventas sin Descuentos  : ', ContDevVentaSinDesc:2);

    WriteLn('---------------------------------------------------------------------');

    { Datos del Arhivo }
    WriteLn();
    TextColor(cyan);
    WriteLn('Datos del Archivo: ', Path);
    WriteLn();
    if ContVenta = 0 then
        begin
        TextColor(red);
        WriteLn('EMPTY FILE');
        TextColor(white);
        end
    else
        begin
        close(arch);
        reset(arch);
        while not eof(arch) do
            begin
            ReadLn(arch, Venta);
            print := print + 1;
            if Venta > 0 then
                Write(Venta:12:2)
            else
                begin
                TextColor(red);
                Write(Venta:12:2);
                TextColor(cyan);
                end;

            if print = 5 then
                begin
                WriteLn();
                print := 0;
                end;

            end;
        WriteLn();
        end;

    close(arch);

    WriteLn();
    TextColor(green);
    Write('ENTER para reiniciar...');
    TextColor(white);
readln();
until FALSE;
end.