program TpIterativo_FIGUEROA;

{$codepage UTF8} { Para no tener inconvenientes con acentos }

uses crt, SysUtils;

var
    arch      : text;

    Pago, Cod : char;

    PagoE     : string;

    Peso, MaxVentaE, MaxVentaT, AcumPesoPE, AcumPesoME,
    AcumPesoTE, AcumPesoPT, AcumPesoMT, AcumPesoTT : single;

    ContE, ContPE, ContME, ContTE, ContT, ContPT, ContMT, ContTT : byte;


    {Ruta       : La que ingresa el usuario }
    {Path       : Ruta + Archivo            }

    {Res        : Respuesta a la pregunta sobre ubicación del archivo }

    {Cod        : Código del producto    }
    {Peso       : Peso de la Venta en kg }
    {Pago       : Tipo de pago           }
    {PagoE      : Para poder leer el Tipo de Pago; ej lee: ' E' }
                { Con char me daba error 106                    }
                { Luego Trim() le quita el espacio: 'E'         }

    {MaxVentaE  : Almacena la Venta Maxima en Efectivo }
    {MaxVentaT  : Almacena la Venta Maxima en Tarjeta  }

    {AcumPesoPE : Acumula los Kilos vendidos en Pan    en Efectivo }
    {AcumPesoME : Acumula los Kilos vendidos en Masas  en Efectivo }
    {AcumPesoTE : Acumula los Kilos vendidos en Tortas en Efectivo }

    {AcumPesoPT : Acumula los Kilos vendidos en Pan    con Tarjeta }
    {AcumPesoMT : Acumula los Kilos vendidos en Masas  con Tarjeta }
    {AcumPesoTT : Acumula los Kilos vendidos en Tortas con Tarjeta }

    {ContE      : Cuenta las ventas en Efectivo           }
    {ContPE     : Cuenta las ventas de Pan    en Efectivo }
    {ContME     : Cuenta las ventas de Masas  en Efectivo }
    {ContTE     : Cuenta las ventas de Tortas en Efectivo }

    {ContT      : Cuenta las ventas con Tarjeta           }
    {ContPT     : Cuenta las ventas de Pan    con Tarjeta }
    {ContMT     : Cuenta las ventas de Masas  con Tarjeta }
    {ContTT     : Cuenta las ventas de Tortas con Tarjeta }


begin

  repeat

    { TITULO ADVERTENCIA }

    clrscr();
    TextColor(red);
    WriteLn(' --------------------------------------------------------------------------------------');
    WriteLn('|   IMPORTANTE! ALOJAR ARCHIVO panaderia.txt EN LA MISMA CARPETA QUE el archivo .pas   |');
    WriteLn(' --------------------------------------------------------------------------------------');
    WriteLn();
    TextColor(white);
    Write('Seguir...');
    readln();


    { TITULO }
    clrscr();
    TextColor(white);
    WriteLn('------------------------');
    WriteLn('   PANADERIA - VENTAS');
    WriteLn('------------------------');
    WriteLn();

    { ASIGNACIÓN Y PREPARACIÓN DE ARCHIVO }

    assign (arch, 'Panaderia.txt');
    ReWrite(arch);

    { COMIENZAN LAS VENTAS }
    repeat
        gotoxy(1,5);
        clreol();
        Write('Ingresar CODIGO del Producto [ P | M | T ]: ');
        ReadLn(Cod);
        Cod := UpCase(Cod);

    until (Cod = 'P') or (Cod = 'M') or (Cod = 'T');


    { INICIO DEL CICLO DE VENTAS }
    while (Cod = 'P') or (Cod = 'M') or (Cod = 'T') do
        begin

        { TITULO }
        clrscr();
        WriteLn('------------------------');
        WriteLn('   PANADERIA - VENTAS');
        WriteLn('------------------------');
        WriteLn();
        case Cod of
            'P' :
                begin
                Write(arch, Cod);      { Escritura en Archivo}
                Write(arch, ' ');      { Escritura en Archivo}

                repeat
                    gotoxy(1,5);
                    clreol();
                    Write('PAN - Peso en kgs : ');
                    ReadLn(Peso);
                until Peso > 0;
                Write(arch, Peso:0:1); { Escritura en Archivo}

                repeat
                    gotoxy(1,6);
                    clreol();
                    Write('    - Tipo de Pago [E|T]: ');
                    ReadLn(Pago);
                    Pago := UpCase(Pago);
                until (Pago = 'E') or (Pago = 'T');
                Write(arch, ' ');      { Escritura en Archivo}
                WriteLn(arch, Pago);   { Escritura en Archivo}

                end;

            'M' :
                begin
                Write(arch, Cod);      { Escritura en Archivo}
                Write(arch, ' ');      { Escritura en Archivo}

                repeat
                    gotoxy(1,5);
                    clreol();
                    Write('MASAS - Peso en kgs : ');
                    ReadLn(Peso);
                until Peso > 0;
                Write(arch, Peso:0:1); { Escritura en Archivo}

                repeat
                    gotoxy(1,6);
                    clreol();
                    Write('      - Tipo de Pago [E|T]: ');
                    ReadLn(Pago);
                    Pago := UpCase(Pago);
                until (Pago = 'E') or (Pago = 'T');
                Write(arch, ' ');      { Escritura en Archivo}
                WriteLn(arch, Pago);   { Escritura en Archivo}

                end;

            'T' :
                begin
                Write(arch, Cod);      { Escritura en Archivo}
                Write(arch, ' ');      { Escritura en Archivo}

                repeat
                    gotoxy(1,5);
                    clreol();
                    Write('TORTAS - Peso en kgs : ');
                    ReadLn(Peso);
                until Peso > 0;
                Write(arch, Peso:0:1); { Escritura en Archivo}

                repeat
                    gotoxy(1,6);
                    clreol();
                    Write('       - Tipo de Pago [E|T]: ');
                    ReadLn(Pago);
                    Pago := UpCase(Pago);
                until (Pago = 'E') or (Pago = 'T');
                Write(arch, ' ');      { Escritura en Archivo}
                WriteLn(arch, Pago);   { Escritura en Archivo}

                end;

        end; {case of}

        WriteLn();

        repeat
            clrscr();
            WriteLn('------------------------');
            WriteLn('   PANADERIA - VENTAS');
            WriteLn('------------------------');
            WriteLn();

            Write('Ingresar CODIGO del Producto [ P | M | T | * ] : ');
            ReadLn(Cod);
            Cod := UpCase(Cod);
            if cod = '*' then
                begin
                TextColor(red);
                WriteLn('  ADVERTENCIA! Si CONFIRMA esta solicitud se CERRARÁ la CAJA del día');
                repeat
                    Write('  CONFIRMA "*" ? | N: ');
                    ReadLn(Cod);
                    Cod := UpCase(Cod);
                until (Cod = '*') or (Cod = 'N');
                TextColor(white);
                WriteLn();
                end; {if}
        until (Cod = 'P') or (Cod = 'M') or (Cod = 'T') or (Cod = '*');

        end; {while}
    close(arch);


    { INICIALIZACION DE CONTADORES }

    AcumPesoPE := 0;
    AcumPesoME := 0;
    AcumPesoTE := 0;

    AcumPesoPT := 0;
    AcumPesoMT := 0;
    AcumPesoTT := 0;

    ContE      := 0;
    ContPE     := 0;
    ContME     := 0;
    ContTE     := 0;

    ContT      := 0;
    ContPT     := 0;
    ContMT     := 0;
    ContTT     := 0;

    MaxVentaE  := 0;
    MaxVentaT  := 0;

    { PREPARACIÓN DE ARCHIVO PARA LECTURA }
    //assign(arch, Path);
    reset(arch);

    { PROCESO }


    while not eof(arch) do
    begin
    ReadLn(arch, Cod,Peso,PagoE);
    PagoE := Trim(PagoE);

    case Cod of
        'P' :
            begin

            if PagoE = 'E' then
                begin
                ContPE := ContPE + 1;
                ContE  := ContE  + 1;
                AcumPesoPE := AcumPesoPE + Peso;
                if MaxVentaE < (Peso * 500) then
                    MaxVentaE := Peso * 500;
                end
            else
                begin
                ContPT := ContPT + 1;
                ContT  := ContT  + 1;
                AcumPesoPT := AcumPesoPT + Peso;
                if MaxVentaT < (Peso * 500) then
                    MaxVentaT := Peso * 500;
                end;
            end; {'P'}


        'M' :
            begin

            if PagoE = 'E' then
                begin
                ContME := ContME + 1;
                ContE  := ContE  + 1;
                AcumPesoME := AcumPesoME + Peso;
                if MaxVentaE < (Peso * 1000) then
                    MaxVentaE := Peso * 1000;
                end
            else
                begin
                ContMT := ContMT + 1;
                ContT  := ContT  + 1;
                AcumPesoMT := AcumPesoMT + Peso;
                if MaxVentaT < (Peso * 1000) then
                    MaxVentaT := Peso * 1000;
                end;
            end; {'M'}



        'T' :
            begin

            if PagoE = 'E' then
                begin
                ContTE := ContTE + 1;
                ContE  := ContE  + 1;
                AcumPesoTE := AcumPesoTE + Peso;
                if MaxVentaE < (Peso * 1500) then
                    MaxVentaE := Peso * 1500;
                end
            else
                begin
                ContTT := ContTT + 1;
                ContT  := ContT  + 1;
                AcumPesoTT := AcumPesoTT + Peso;
                if MaxVentaT < (Peso * 1500) then
                    MaxVentaT := Peso * 1500;
                end;
            end; {'T'}

    end; { case }
    end; { while }
    close(arch);



    { SALIDA DE INFORMACIÓN }

    { TITULO }
    clrscr();
    TextColor(green);
    WriteLn('-------------------------------');
    WriteLn('  PANADERIA - INFORME DEL DIA');
    WriteLn('-------------------------------');

    { a- Porcentaje de ventas en el día, efectivo y tarjeta por separado }
    TextColor(green);
    WriteLn('-------------------------------');
    TextColor(white);
    WriteLn('PORCENTAJES DE VENTAS');
    WriteLn();
    WriteLn('  TOTAL EN EFECTIVO :  ', ((ContE / (ContE + ContT)) * 100):6:2);
    WriteLn('  TOTAL CON TARJETA :  ', ((ContT / (ContE + ContT)) * 100):6:2);
    WriteLn();
    WriteLn('           EFECTIVO | TARJETA ');

    if (ContPE > 0) or (ContPT > 0) then
        WriteLn('  PAN    :   ',((ContPE / (ContPE + ContPT)) * 100):6:2,' |  ',((ContPT / (ContPE + ContPT)) * 100):6:2);

    if (ContME > 0) or (ContMT > 0) then
        WriteLn('  MASAS  :   ',((ContME / (ContME + ContMT)) * 100):6:2,' |  ',((ContMT / (ContME + ContMT)) * 100):6:2);

    if (ContTE > 0) or (ContTT > 0) then
        WriteLn('  TORTAS :   ',((ContTE / (ContTE + ContTT)) * 100):6:2,' |  ',((ContTT / (ContTE + ContTT)) * 100):6:2);

    TextColor(green);
    WriteLn('-------------------------------');
    TextColor(white);

    { b- Cantidad de kilos de pan, de masas y de tortas, por separado. }
    TextColor(green);
    WriteLn('-------------------------------');
    TextColor(white);
    WriteLn('CANTIDAD DE KILOS VENDIDOS:');
    WriteLn();
    WriteLn('           EFECTIVO | TARJETA ');

    if (AcumPesoPE > 0) or (AcumPesoPT > 0) then
        WriteLn('  PAN    :  ',AcumPesoPE:7:1,' | ',AcumPesoPT:7:1);

    if (AcumPesoME > 0) or (AcumPesoMT > 0) then
        WriteLn('  MASAS  :  ',AcumPesoME:7:1,' | ',AcumPesoMT:7:1);

    if (AcumPesoTE > 0) or (AcumPesoTT > 0) then
        WriteLn('  TORTAS :  ',AcumPesoTE:7:1,' | ',AcumPesoTT:7:1);
    TextColor(green);
    WriteLn('-------------------------------');
    TextColor(white);

    { c- Importe de la venta máxima, aclarando si fue en efectivo o con tarjeta. }
    TextColor(green);
    WriteLn('-------------------------------');
    TextColor(white);
    WriteLn('IMPORTE DE LA VENTA MÁXIMA:');
    WriteLn();
    if MaxVentaE > MaxVentaT then
        WriteLn('  IMPORTE: ',MaxVentaE:8:2,' | EFECTIVO')
    else
        WriteLn('  IMPORTE: ',MaxVentaT:8:2,' | TARJETA');
    TextColor(green);
    WriteLn('-------------------------------');
    TextColor(white);

    WriteLn();
    TextColor(green);
    Write('ENTER para reiniciar...');
    TextColor(white);
    readln();

until FALSE;
end.