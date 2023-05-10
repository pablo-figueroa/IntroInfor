(*
7- Se tiene un conjunto de datos de N clientes de una compañía de electricidad, estos son:
    * Número de cliente
    * Estado actual del medidor (en kw)
    * Estado anterior del medidor

Leer de un archivo los datos de los clientes,
calcular e informar el consumo,
el importe junto al número de cliente.

El importe se calcula con un básico fijo de $50,
más un monto variable que depende del consumo,
se establece una escala de valores para el precio por kw según rangos de consumo:

    $5.0   consumo(000, 100]  |        consumo <= 100
    $3.7   consumo(100, 250]  |  100 < consumo <= 250
    $2.5   consumo(250, ...)  |  250 < consumo

*)

program T5_Ej07.pas;

{$codepage UTF8}

uses crt;


{ ----------------------------------- PROCEDURE ----------------------------------- }
procedure facturacion(estAct,estAnt:longWord; var C : word; var I : real);
begin
    C := estAct - estAnt;

    if C <= 100 then
        I := 50 + (C * 5)
    else
        if C <= 250 then
            I := 50 + (C * 3.7)
        else
            I := 50 + (C * 2.5);
end; {procedure}


{ ----------------------------------- VAR ----------------------------------- }
var
    cliente        : string[3];
    EstAnt, EstAct : word;
    
    arch     : text;
    consumo  : word;
    importe  : real;
    N, i     : byte;
    altColor : byte;


{ ----------------------------------- MAIN ----------------------------------- }
begin
    Assign(arch, 'consumo.txt');
    altColor := 0;
    TextColor(cyan);
    WriteLn('------------------');
    WriteLn('COMPAÑIA ELECTRICA');
    WriteLn('------------------');
    TextColor(white);

    Reset(arch);
    WriteLn('----------------------------------------------');
    TextColor(cyan);
    WriteLn('| Cliente | Consumo en kw | Importe a Abonar |');
    TextColor(white);
    ReadLn(arch, N);
    for i := 1 to N do
        begin
        ReadLn(arch, cliente,EstAct,EstAnt);
        facturacion(EstAct,EstAnt,Consumo,Importe);
        WriteLn('| ',cliente:7,' | ',Consumo:13,' | ',Importe:16:2,' |');

        if altColor = 0 then
            begin
            textcolor(green);
            altColor := 1;
            end
        else if altColor = 1 then
            begin
            TextColor(white);
            altColor := 0;
            end;

        end; {for}
    Close(arch);
    ReadLn;
end. {main}