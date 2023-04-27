(*
--------------------------- EJERCICIO 16 ---------------------------
--------------------------- DESDE ARCHIVO --------------------------

En una competencia participan N deportistas que se identifican con
su n° de Documento y lanzan una JABALINA.

Una vez lanzada, se registra el documento y la Distancia del lanzamiento.

Se requiere:
    a) Conocer el Documento del Ganador y su Distancia.
    b) Conocer la Distancia Media de la prueba.

Archivo: jabalina.txt
    11111111	30
    22222222	33
    33333333	36.3
    44444444	39.93
    55555555	43.923
    66666666	48.3153
    77777777	53.14683
    88888888	58.461513
    99999999	64.3076643
    12123123	70.73843073
    22123123	77.8122738
    32123123	85.59350118
    42123123	94.1528513
    52123123	103.5681364
    62123123	113.9249501
    72123123	125.3174451
    82123123	137.8491896
    *


*)

program T4Ej16;

{$codepage UTF8}

uses crt, SysUtils;

var
    DNI      : string[8]; {DNI sin puntos}
    WinDNI   : string[8];


    Dist     : single;
    MaxDist  : single;

    AcumDist : real;
    ContDist : byte;

    arch     : text;
    aux      : char;

begin

    clrscr();
    WriteLn('------------------------------------');
    WriteLn('   TORNEO LANZAMIENTO DE JABALINA');
    WriteLn('------------------------------------');
    WriteLn();

    { INICIALIZACION DE CONTADORES Y ACUMULADORES }
    ContDist := 0;
    AcumDist := 0;
    MaxDist  := 0; { Inicia con un valor irrisorio }

    assign(arch, 'jabalina.txt');
    reset(arch);

    { Ingreso y Validación de DNI }
    repeat
        Read(arch, DNI);
    until (((length(DNI) = 8) and (StrToIntDef(DNI, 0) <> 0)) or (DNI = '*'));

    if DNI = '*' then
        begin
        WriteLn();
        TextColor(red);
        WriteLn('EMPTY FILE...');
        ReadLn();
        halt();
        end;

    While DNI <> '*' do
        begin

        { Ingreso y Validación de Distancia }
        repeat
            ReadLn(Arch, aux,Dist);
        until (Dist > 0) and (Dist < 150); { Récord del mundo de jabalina: 98.48m de Jan Železný }

        ContDist := ContDist +1;
        AcumDist := AcumDist + Dist;

        if Dist > MaxDist then
            begin
            MaxDist := Dist;
            WinDNI  := DNI;
            end;

        { Ingreso y Validación de DNI }
        repeat
            Read(arch, DNI);
        until (((length(DNI) = 8) and (StrToIntDef(DNI, 0) <> 0)) or (DNI = '*'))

        end; {while}

    Close(arch);
    
    WriteLn('LECTURA DESDE ARCHIVO: "jabalina.txt"');
    WriteLn();

    { SALIDAS DE INFORMACION }
    WriteLn('------------------------------------------------------------------');
    WriteLn();
    WriteLn('a) DNI Ganador fue ',WinDNI, ' con una distancia de ',MaxDist:0:2, ' METROS');
    WriteLn();
    WriteLn('b) Distancia media de la prueba: ',(AcumDist/ContDist):0:2,' METROS');
    WriteLn();

    if MaxDist > 98.48 then
    begin
    TextColor(green);
    WriteLn();
    WriteLn('  VAYA! Parece que estamos ante un nuevo Record Mundial!!!');
    WriteLn('  SUPERÓ al Récord del mundo de jabalina Jan Železný: 98.48m');
    WriteLn('  Felicidades ',WinDNI,' !!!');
    TextColor(white);
    end;

    ReadLn();

end.