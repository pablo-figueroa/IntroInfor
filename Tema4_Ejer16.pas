                             (*
--------------------------- EJERCICIO 16 ---------------------------

En una competencia participan N deportistas que se identifican con
su n° de Documento y lanzan una JABALINA.

Una vez lanzada, se registra el documento y la Distancia del lanzamiento.

Se requiere:
    a) Conocer el Documento del Ganador y su Distancia.
    b) Conocer la Distancia Media de la prueba.

*)

program T4Ej16;

//{$codepage UTF8}

uses crt, SysUtils;

var
    DNI      : string[8]; {DNI sin puntos}
    WinDNI   : string[8];


    Dist     : single;
    MaxDist  : single;

    AcumDist : real;
    ContDist : byte;

begin
repeat
    clrscr();
    WriteLn('------------------------------------');
    WriteLn('   TORNEO LANZAMIENTO DE JABALINA');
    WriteLn('------------------------------------');
    WriteLn();

    { INICIALIZACION DE CONTADORES Y ACUMULADORES }
    ContDist := 0;
    AcumDist := 0;
    MaxDist  := 0; { Inicia con un valor irrisorio }

    { Ingreso y Validación de DNI }
    repeat
        gotoxy(1,5);
        clreol();
        Write('Ingresar DNI (sin puntos)');
        TextColor(red);
        Write('[ fin : * ]: ');
        TextColor(white);
        ReadLn(DNI);
    until (((length(DNI) = 8) and (StrToIntDef(DNI, 0) <> 0)) or (DNI = '*'));

    if DNI = '*' then
        begin
        WriteLn();
        TextColor(red);
        WriteLn('Ha salido sin ingresar participantes...');
        ReadLn();
        halt();
        end;

    While DNI <> '*' do
        begin

        { Ingreso y Validación de Distancia }
        repeat
            gotoxy(1,5);
            clreol();
            Write('Ingresar Distancia del lanzamiento: ');
            ReadLn(Dist);
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
            gotoxy(1,5);
            clreol();
            Write('Ingresar DNI (sin puntos)');
            TextColor(red);
            Write('[ fin : * ]: ');
            TextColor(white);
            ReadLn(DNI);
        until (((length(DNI) = 8) and (StrToIntDef(DNI, 0) <> 0)) or (DNI = '*'));

        end; {while}


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
until FALSE;
end.