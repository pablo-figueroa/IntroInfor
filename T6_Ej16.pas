(*
----------------------------------------- EJERCICIO 16 -----------------------------------------

El área de RRHH de una empresa desea conocer cuántos de sus empleados
cumplen años cada uno de los 12 meses.

Se conoce Nombre y mes (1..12) de los N empleados, 
Se pide ingresar dicha información para EMITIR el siguiente listado:

    Mes     | Cantidad
    Enero   | 100
    Febrero | 350
    Marzo   | 270
    ...       ...

Además indicar el mes con mayor cantidad de cumpleaños.
¿Cómo cambiaría la solución si se considere el nombre del mes es en vez del valor 1..12?

*)

program T6_Ej16;

//{$codepage UTF8}

uses crt, SysUtils;

type
    TV_5000_byte = array[1..5000] of Byte; { Para el Vector de Meses de Cumpleaños }
    TV_12_Word   = array[1..12]   of Word; { Para el Vector contador }


{ --------------------------------------------------------------------------------------------}
procedure Titulo();

begin
    ClrScr;
    WriteLn('-----------------------------------------------');
    WriteLn('              RRHH Y CUMPLEAÑOS');
    WriteLn('-----------------------------------------------');
    WriteLn;
    WriteLn;
end;


{ GENERAR VECTORES ---------------------------------------------------------------------------}
procedure LeerVector
    (
        var V : TV_5000_byte;
        var N : word
    );

var
    
    mes : byte;   { Para leer el mes }
    i   : word;
    aux : char;

    arch : text;

begin

    i := 0;
    Assign(arch, 'T6_Ej16.txt');
    Reset(arch);
    while not eof(arch) do
        begin
        i := i + 1;
        Read(arch, aux);
        while aux <> ' ' do
            read(arch, aux);
        ReadLn(arch, mes);
        
        V[i] := mes;
        end; {while}
    Close(arch);
    N := i;

end; {procedure}


{ LISTADO ------------------------------------------------------------------------------------}
procedure Listado
    (
        V        : TV_5000_byte;
        N        : word;
        var Vmes : TV_12_Word    
    );

var
    i : word; 

begin
    { Inicializo vector contador en cero }
    for i:=1 to 12 do
        Vmes[i] := 0;

    for i:=1 to N do
        case V[i] of
            1 :  Vmes[1]  := Vmes[1]  + 1;
            2 :  Vmes[2]  := Vmes[2]  + 1;
            3 :  Vmes[3]  := Vmes[3]  + 1;
            4 :  Vmes[4]  := Vmes[4]  + 1;
            5 :  Vmes[5]  := Vmes[5]  + 1;
            6 :  Vmes[6]  := Vmes[6]  + 1;
            7 :  Vmes[7]  := Vmes[7]  + 1;
            8 :  Vmes[8]  := Vmes[8]  + 1;
            9 :  Vmes[9]  := Vmes[9]  + 1;
            10 : Vmes[10] := Vmes[10] + 1;
            11 : Vmes[11] := Vmes[11] + 1;
            12 : Vmes[12] := Vmes[12] + 1;
        end; {case}
end; {procedure}

{ MES CON MAS CUMPLEAÑOS ---------------------------------------------------------------------}    
function MesConMasCumples
    (
        V : TV_12_word
    ):byte;

var
    i   : byte;
    Max : word;
    Aux : byte;

begin
    Max := 0;
    for i:=1 to 12 do
        if V[i] > Max then
            begin
            Max := V[i];
            Aux := i;
            end;
    
    MesConMasCumples := Aux;
end; {procedure}


{ SEPARADOR ----------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('-----------------------------------------------');
    WriteLn;
end;{procedure Separador}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    TV_Cumples     : TV_5000_byte;
    N              : word;
    S              : char;
    TV_CantCumples : TV_12_word;

begin
    repeat
    Titulo;

    LeerVector(TV_Cumples,N);
    Titulo;

    WriteLn('Mes               Cantidad');
    Listado(TV_Cumples,N,TV_CantCumples);
    WriteLn('1  Enero:         ', TV_CantCumples[1] :3);
    WriteLn('2  Febrero:       ', TV_CantCumples[2] :3);
    WriteLn('3  Marzo:         ', TV_CantCumples[3] :3);
    WriteLn('4  Abril:         ', TV_CantCumples[4] :3);
    WriteLn('5  Mayo:          ', TV_CantCumples[5] :3);
    WriteLn('6  Junio:         ', TV_CantCumples[6] :3);
    WriteLn('7  Julio:         ', TV_CantCumples[7] :3);
    WriteLn('8  Agosto:        ', TV_CantCumples[8] :3);
    WriteLn('9  Septiembre:    ', TV_CantCumples[9] :3);
    WriteLn('10 Octubre:       ', TV_CantCumples[10]:3);
    WriteLn('11 Noviembre:     ', TV_CantCumples[11]:3);
    WriteLn('12 Diciembre:     ', TV_CantCumples[12]:3);

    Separador;

    WriteLn('El mes con mayor cantidad de cumpleaños es: ',MesConMasCumples(TV_CantCumples));

    Separador;
    
    TextColor(red);
    Write('Enter -> Reiniciar | S -> Salir ');
    TextColor(white);
    S := ReadKey;
    S := UpCase(S);

until (S = 'S');
end.