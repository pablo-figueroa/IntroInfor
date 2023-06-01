(*
---------------------------------- END WHILE HIDE ----------------------------------

PONGAMOSLO A PRUEBA:

    Lee un archivo y lo pasa a un vector.
    Buscar mediante una función un valor numérico

        A:    while (Num <> V_Num[i]) and (i <= N) do;
                               vs
        B:    while (i <= N) and (Num <> V_Num[i]) do;

    Mis conclusiones:
        ¿Ambos codigos funcionan? RTA: Sí.
        ¿Cuál demora menos      ? RTA: Hasta Ahora -> A.

    Estructura:
        Inicia Serie (Hacer 1.000.000)
            Tomar tiempo de la Función A (100 repeticiones -> Loop)
            Tomar tiempo de la Función B (100 repeticiones -> Loop)
        Fin de Serie
*)

program MientrasTanto;
//{$codepage UTF8}

uses crt, SysUtils;


{-----------------------------------------------------------------------------}
const { Global Scoope }
    MaxSerie : UInt64 = 1000000;
    MaxLoop  : UInt64 = 100;

type
    TV_UInt16   = array[1..10001] of UInt16;


{ TITULO ---------------------------------------------------------------------}
procedure Titulo();
begin
    ClrScr;
    WriteLn('------------------------------------------------------------');
    TextColor(red);
    WriteLn('                       E N D    W H I L E');
    TextColor(white);
    WriteLn('------------------------------------------------------------');
    TextColor(green);
    Write('        A = ');
    TextColor(yellow);
    Write('while ');
    TextColor(green);
    Write('(Num <> V_Num[i]) ');
    TextColor(yellow);
    Write('and ');
    TextColor(green);
    Write('(i <= N) ');
    TextColor(yellow);
    WriteLn('do');
    TextColor(white);
    WriteLn('------------------------------------------------------------');
    TextColor(cyan);
    Write('        B = ');
    TextColor(yellow);
    Write('while ');
    TextColor(cyan);
    Write('(i <= N) ');
    TextColor(yellow);
    Write('and ');
    TextColor(cyan);
    Write('(Num <> V_Num[i]) ');
    TextColor(yellow);
    WriteLn('do');
    TextColor(white);
    WriteLn('------------------------------------------------------------');
    WriteLn;
end; {procedure Titulo}


{ LEER VECTOR ----------------------------------------------------------------}
procedure LeerVector
    (
        var V  : TV_UInt16;
        var N  : UInt16
    );

var
    num  : UInt16; { Para leer la patente }
    i    : UInt16;
    arch : text;

begin
    i := 0;
    (* Assign(arch, 'T6_Ad3(PAP)num.txt');  { del 10000 al 1 } *)
    Assign(arch, 'numWhile.txt');        { del 1 al 100 }
    Reset(arch);
    while not eof(arch) do
        begin
        i := i + 1;
        ReadLn(arch, num);
        V[i]  := num;
        end; {while}
    Close(arch);
    N := i;

end; {procedure}


{ SEPARADOR ------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    TextColor(white);
    WriteLn('------------------------------------------------------------');
    WriteLn;
end;{procedure Separador}


{ FUNCTION A -----------------------------------------------------------------}
function BuscaNumero_A
    (
        V   : TV_UInt16;
        N   : Uint16;
        num : UInt16
    ):UInt16;

var
    i    : UInt64;
    Loop : UInt32;

begin
    for Loop:=1 to MaxLoop do
        begin
        i := 1;
        while (V[i] <> num) and (i <= N) do  { ÚNICA DIFERENCIA ENTRE A Y B }
            i := i +1;
        end;
    if i <= N then
        BuscaNumero_A := i
    else
        BuscaNumero_A := 0;
end; {BuscaNumero_A}


{ FUNCTION B -----------------------------------------------------------------}
function BuscaNumero_B
    (
        V   : TV_UInt16;
        N   : Uint16;
        num : UInt16
    ):UInt16;

var
    i    : UInt64;
    Loop : UInt32;

begin
    for Loop:=1 to MaxLoop do
        begin
        i := 1;
        while (i <= N) and (V[i] <> num) do { ÚNICA DIFERENCIA ENTRE A Y B }
            i := i +1;
        end;
    if i <= N then
        BuscaNumero_B := i
    else
        BuscaNumero_B := 0;
end; {BuscaNumero_B}


{ PROGRAMA PRINCIPAL ---------------------------------------------------------}
var { Local Scoope }
    VNum         : TV_UInt16;
    N            : UInt16;  

    Inicio       : UInt64;
    Fin          : UInt64;

    Tiempo       : UInt64;
    TiempoAcumA  : UInt64;
    TiempoAcumB  : UInt64;

    Serie        : UInt64;

    Y            : UInt8; { gotoXY }

    NumTarget    : UInt16; { Número a buscar }
    NumPos       : UInt16; { Posición de Número encontrado }

    fechaHora    : TDateTime;
    Fecha        : string;
    Hora         : string;
    Minutos      : real;

    S            :char;

begin
    repeat
        Serie       := 0;
        TiempoAcumA := 0;
        TiempoAcumB := 0;

        Titulo;

        LeerVector(VNum, N);
        WriteLn('Realizará ',FormatFloat('#,###.##',MaxSerie),' series de ',FormatFloat('#,###.##',MaxLoop),' ciclos | Num {1 - 1000}');
        TextColor(yellow);
        Write('Ingrese un Número Natural -> ');
        ReadLn(numTarget);
        Y := whereY;
        
        gotoxy(1,Y-1);
        ClrEol;
        gotoxy(1,Y-2);
        ClrEol;

        FechaHora := Now;
        
        for Serie:=1 to MaxSerie do
            begin

            { *** ALTENATIVA A ****************************** }

            gotoxy(1,Y-2);

            { A -> ACÁ OCURRE LA MAGIA }
            Inicio := GetTickCount64;
            NumPos := BuscaNumero_A(VNum, N, NumTarget);
            Fin    := GetTickCount64;
            { A -> ALGUNOS CALCULOS }
            Tiempo      := Fin - Inicio;
            TiempoAcumA := TiempoAcumA + Tiempo;
            { FIN DE A }


            { *** ALTENATIVA B ****************************** }

            { B -> ACÁ OCURRE LA MAGIA }
            Inicio := GetTickCount64;
            NumPos := BuscaNumero_B(VNum, N, NumTarget);
            Fin    := GetTickCount64;
            { B -> ALGUNOS CALCULOS }
            Tiempo      := Fin - Inicio;
            TiempoAcumB := TiempoAcumB + Tiempo;
            { FIN DE B }

            { PRINT -> CONTADOR DE SERIES }
            (* TextColor(yellow);
            writeLn('Serie -> ',FormatFloat('#,###.##',Serie)); *)

            end; {for Serie}

        WriteLn;

        { PRINT -> CONTADOR DE SERIES }
        gotoxy(1,Y-2);
        ClrEol;
        
        TextColor(yellow);
        writeLn('Serie -> ',FormatFloat('#,###.##',Serie));
        WriteLn('Loop  -> ',FormatFloat('#,###.##',MaxLoop));
        
        Separador;

        { PRINT -> POSICION DEL NÚMERO }
        if NumPos <> 0 then
            begin
            Write('Número ',numTarget,' encontrado en la posición: i -> ',NumPos);
            TextColor(green);
            WriteLn(' :-)');
            end
        else
            begin
            Write('Número ',numTarget,' no encontrado');
            TextColor(red);
            WriteLn(' :-(');
            end;

        WriteLn;

        { PRINT -> ESTRUCTURA MÁS RÁPIDA }
        if tiempoAcumA < tiempoAcumB then
            begin
            TextColor(green);
            WriteLn('Estructura A es más en rápida en un: ',-(((tiempoAcumA/tiempoAcumB)-1)*100):5:2,' %');
            end
        else
            begin
            TextColor(cyan);
            WriteLn('Estructura B es más en rápida en un: ',-(((tiempoAcumB/tiempoAcumA)-1)*100):5:2,' %');
            end;

        Separador;

        TextColor(green);
        Minutos := tiempoAcumA/1000/60;
        WriteLn('Tiempo Acumulado de A - > ',tiempoAcumA,' | ',Trunc(Minutos),' Minutos y ',Round((Minutos - Trunc(Minutos))*60),' segundos.-');
        WriteLn;
        TextColor(cyan);
        Minutos := tiempoAcumB/1000/60;
        WriteLn('Tiempo Acumulado de B - > ',tiempoAcumB,' | ',Trunc(Minutos),' Minutos y ',Round((Minutos - Trunc(Minutos))*60),' segundos.-');

        Separador;

        Hora := FormatDateTime('hh:nn:ss', FechaHora);
        WriteLn('Hora Inicio : ', Hora);
        FechaHora := Now;
        Hora := FormatDateTime('hh:nn:ss', FechaHora);
        WriteLn('Hora Fin    : ', Hora);
        WriteLn;
        Fecha := FormatDateTime('dd/mm/yyyy', FechaHora);
        WriteLn('Fecha       : ', Fecha);
        
        Separador;

        { PRINT -> MENU FINAL }
        TextColor(yellow);
        Write('Repetir -> ENTER ');
        TextColor(white);
        Write('|| ');
        TextColor(red);
        Write('Salir -> S ');
        TextColor(white);
        S := ReadKey;
        S := UpCase(S);

    until S = 'S'
end.