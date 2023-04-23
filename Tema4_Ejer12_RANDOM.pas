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

program T4Ej12_RANDOM;

{$codepage UTF8}

uses crt, SysUtils;

var
    VentaMin            : real; { a la que se le aplicará descuento }
    Desc                : real; { Porcentaje de descuento           }

    Path                : string;
    arch                : text;

    Venta               : real;

    ContVenta           : byte;
    ContDevVenta        : byte;

    AcumDescSD          : real;  { Acumula los descuentos concedidos de Ventas }
    AcumDescSA          : real;  { Acumula los descuentos recuperados de devoluciones de Ventas }

    ContVentaSinDesc    : byte;
    ContDevVentaSinDesc : byte;



    print               : byte;  { Contador para disparar un salto de línea }

    NumAlea             : integer;
    i, j                : byte;
    positivos           : byte;
    negativos           : byte;
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

    Path   := 'Tema4_Ejer12_RANDOM.txt';
    Assign(arch, Path);

    { TITULO }
    WriteLn('-------------------');
    WriteLn('VENTAS Y DESCUENTOS');
    WriteLn('-------------------');
    WriteLn();

    { GENERAR LISTA DE VENTAS RANDOM }

    Randomize;
    Positivos := (Random(7) + 1)*5;
    Negativos := (Random(1) + 1)*5;

    TextColor(green);
    Writeln('SE GENERÓ un Archivo de manera RANDOM con el siguiente detalle:');
    WriteLn('  Ventas         : ', Positivos:2);
    WriteLn('  Devoluciones   : ', Negativos:2);
    WriteLn('  TOTAL Elementos: ', (Positivos + Negativos):2);

    ReWrite(arch);
    for i:=1 to Positivos do
        begin
        NumAlea := Random(5000) + 1;
        Writeln(arch, NumAlea);
        end;

    for j:=1 to (Negativos) do
        begin
        NumAlea := -(Random(5000) + 1);
        Writeln(arch, NumAlea);
        end;

    close(arch);

    WriteLn();

    { ENTRADA DE LAS CONDICIONES DEL DESCUENTO }
    TextColor(yellow);
    WriteLn('ESTABLECER CONDICIONES DEL DESCUENTO E IMPORTE DE VENTA');
    WriteLn();
    repeat
        Write('Descuento (%): ');
        TextColor(green);
        ReadLn(Desc);

        if Desc > 20 then
            begin
            gotoxy((32-16),10);
            clreol();
            TextColor(red);
            Write('NO TIENE PERMISO para establecer Descuento Superior al 20%');
            ReadLn(); { Establecer una pausa }
            gotoxy(1,10);
            clreol();
            end;
        TextColor(yellow);
    until (Desc >= 0) and (Desc <= 20);


    repeat
        Write('Importe de Venta ($): ');
        TextColor(green);
        ReadLn(VentaMin);

        if VentaMin < 1000 then
            begin
            gotoxy((39-16),11);
            clreol();
            TextColor(red);
            Write('NO TIENE PERMISO para establecer un Importe Inferior a $1.000');
            ReadLn(); { Establecer una pausa }
            gotoxy(1,11);
            clreol();
            end;
        TextColor(yellow);
    until (VentaMin >= 1000);



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
    close(arch);

    { Importe Total de Descuentos }
    Desc := Desc/100;
    reset(arch);
    while not eof(arch) do
        begin
        readln(arch, Venta);

        if Venta > VentaMin then
            AcumDescSD := AcumDescSD + (Venta * Desc);

        if Venta < -VentaMin then
            AcumDescSA := AcumDescSA + (-Venta * Desc);

        end;
    close(arch);
    { Cantidad de Ventas sin Descuentos }

    reset(arch);
    while not eof(arch) do
        begin
        ReadLn(arch, Venta);

        if (Venta > 0) and (Venta <= VentaMin) then
            ContVentaSinDesc := ContVentaSinDesc + 1;

        if (Venta < 0) and (Venta >= -VentaMin) then
            ContDevVentaSinDesc := ContDevVentaSinDesc + 1;

        end;
    close(arch);
    { SALIDA DE INFORMACIÓN }
    clrscr();
    { CONDICIONES DEL DESCUENTO }
    WriteLn();
    TextColor(yellow);
    Desc := Desc*100;
    Write('Se aplica un Descuento del ');
    TextColor(green);
    Write(Desc:5:2,'%');
    TextColor(yellow);
    Write(' para ventas MAYORES a ');
    TextColor(green);
    WriteLn(FormatFloat('$#,##0.00',VentaMin));

    TextColor(white);
    WriteLn();

    { Cantidad de Ventas Totales}

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
    TextColor(white);
    WriteLn('Datos del Archivo: ', Path);
    TextColor(cyan);
    WriteLn();

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
    close(arch);

    WriteLn();
    TextColor(White);

    TextColor(green);
    Write('ENTER para reiniciar...');
    TextColor(white);
readln();
until FALSE;
end.