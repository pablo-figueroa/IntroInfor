(*
----------------------------------------- EJERCICIO 12 -----------------------------------------

A partir de los dos arreglos del ejercicio 5 que almacenan Patente y Precio de un conjunto de
autos.

Se pide desarrollar un procedimiento que los ordene por patente.     { L I N E A    2 8 5 }
Luego en otro procedimiento mostrar ambos arreglos.                  { L I N E A    3 2 5 }

*)

program T6_Ej05;
//{$codepage UTF8}
uses crt;

type
    TV_100_Str6   = array[1..100] of string[6];
    TV_100_UInt16 = array[1..100] of UInt16; { word }
    TV_100_Real   = array[1..100] of Real;


{ GENERAR VECTORES ---------------------------------------------------------------------------}
procedure GenerarVectores
    (
        var VectorPaten  : TV_100_Str6;
        var VectorAnio   : TV_100_UInt16;
        var VectorPrecio : TV_100_Real;
        var N            : byte
    );

var
    pa : string[6]; { Para leer la patente }
    an : word;      { Para leer el año     }
    pr : real;      { Para leer el precio  }

    arch : text;

begin
    N := 0;
    Assign(arch, 'T6_Ej05.txt');
    Reset(arch);
    while not eof(arch) do
        begin
        N := N + 1;
        ReadLn(arch, pa,an,pr);
        VectorPaten[N]  := pa;
        VectorAnio[N]   := an;
        VectorPrecio[N] := pr;
        end; {while}
    Close(arch);
end; {procedure}


{ PRECIO MAXIMO}
procedure GenerarPreMaxLong
    (
        vPre           : TV_100_Real;
        N              : byte;
        var PreMaxLong : Byte
    );

var
    i : byte;
    PreMax     : Real;

begin
    PreMax := 0;
    for i:=1 to N do
        if vPre[i] > PreMax then
            PreMax := vPre[i];
    PreMaxLong := Trunc((ln(PreMax)/ln(10))) + 1;
end;


{ MENU ---------------------------------------------------------------------------------------}
procedure menu
    (
        var Op : char
    );

begin
    repeat
        ClrScr;
        WriteLn('----------------');
        WriteLn('MENU DE OPCIONES');
        WriteLn('----------------');
        WriteLn;
        WriteLn(' a | Precio Mínimo del Año Ingresado.');
        WriteLn(' b | Cantidad de Vehículos por debajo de un Precio Ingresado.');
        WriteLn(' c | Precio Promedio dentro de un Rango de Años Ingresado.');
        WriteLn(' d | Datos de Patente.');
        WriteLn(' e | Ordenar Patentes en forma ascendente');
        TextColor(red);
        WriteLn(' * | Fin del Programa.');
        TextColor(white);
        WriteLn;
        Write('---> Ingrese Opción: ');
        Op := ReadKey;
        if Op = '*' then
            halt;
        Op := UpCase(Op);
    until (Op = 'A') or (Op = 'B') or (Op = 'C') or (Op = 'D') or (Op = 'E');

end; {procedure}


{ MOSTRAR VECTOR REAL ------------------------------------------------------------------------}
procedure MostrarVectorReal
    (
        Vector  : TV_100_Real;
        N       : byte
    );

var i : byte;

begin
    for i:=1 to N do
        if Vector[i] = Trunc(Vector[i]) then
            Write(Vector[i]:0:0,'  ')
        else
            Write(Vector[i]:0:1,'  ');
end; {procedure}


{ MOSTRAR VECTOR STR ------------------------------------------------------------------------}
procedure MostrarVectorStr
    (
        Vector  : TV_100_Str6;
        N       : byte
    );

var i : byte;

begin
    for i:=1 to N do
        WriteLn(Vector[i],'  ');
end; {procedure}


{ OBTENER AÑO MINIMO Y MÁXIMO ----------------------------------------------------------------}
procedure AnioMinMax
    (
        VectorAnio  : TV_100_UInt16;
        N           : byte;
        var AnioMin : word;
        var AnioMax : word
    );

var
    i : byte;

begin
    AnioMin := 9999;
    AnioMax := 0;
    for i:=1 to N do
        begin
        if AnioMin > VectorAnio[i] then
            AnioMin := VectorAnio[i];

        if AnioMax < VectorAnio[i] then
            AnioMax := VectorAnio[i];
        end;{for}
end;

{ SEPARADOR ----------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    TextColor(yellow);
    WriteLn('------------------------------------------------------');
    WriteLn;
    TextColor(white);
end;{procedure Separador}


{ a. PARA UN AÑO DADO, PRECIO MINIMO (puede no existir) --------------------------------------}
function PrecioMinimo
    (
        VectorAnio   : TV_100_UInt16;
        VectorPrecio : TV_100_Real;
        N            : UInt8;  {byte}
        Anio         : UInt16  {word}
    ):Real;

var
    i         : UInt8;  {byte}
    PrecioMin : Real;

begin
    PrecioMin := 1e10;
    for i:=1 to N do
        if (anio = VectorAnio[i]) and (PrecioMin > VectorPrecio[i]) then
            PrecioMin := VectorPrecio[i];

    PrecioMinimo := PrecioMin;
end; {procedure}


{ b. PARA UN PRECIO DADO CANTIDAD DE VEHICULOS POR DEBAJO DE DICHO VALOR ---------------------}
function CantidadVehiculos
    (
        VectorPrecio : TV_100_Real;
        N            : UInt8; {byte}
        Precio       : Real
    ):Byte;

var
    i       : UInt8; {byte}
    ContVeh : UInt8; {byte} {Dado que el array es de 100}

begin
    ContVeh := 0;
    for i:=1 to N do
        if VectorPrecio[i] < Precio then
            ContVeh := ContVeh + 1;

    CantidadVehiculos := ContVeh;
end; {procedure}


{ c. Para un rango de años dado [Año1, Año2] precio promedio de los autos en dicho rango -----}
function PrecioPromedio
    (
        VectorAnio   : TV_100_UInt16;
        VectorPrecio : TV_100_Real;
        N            : byte;
        AnioI        : UInt16; {word}
        AnioF        : UInt16  {word}
    ):Real;

var
    i          : UInt8;  {byte}
    ContVeh    : UInt8;  {byte}
    AcumPrecio : Real;

begin
    ContVeh    := 0;
    AcumPrecio := 0;
    for i:=1 to N do
        if (VectorAnio[i] >= AnioI) and (VectorAnio[i] <= AnioF) then
            begin
            AcumPrecio := AcumPrecio + VectorPrecio[i];
            ContVeh := ContVeh + 1;
            end;{if}

    if ContVeh > 0 then
        PrecioPromedio := AcumPrecio/ContVeh
    else
        PrecioPromedio := 0; { en ProgPpal esto significará "No hay datos"}

end; {procedure}


{ d - PATENTE DATOS ------------------------------------------------------------------------------}
procedure PatenteDatos
    (
        VectorPaten   : TV_100_Str6;
        VectorAnio    : TV_100_UInt16;
        VectorPrecio  : TV_100_Real;
        N             : byte;
        Patente       : string;
        var VecPAnio  : TV_100_UInt16;
        var VecPPre   : TV_100_Real;
        var J         : byte;
        var ContFail  : byte
    );

var
    i : byte;
begin
    ContFail := 0;
    j := 0;
    for i:=1 to N do
        if Patente = VectorPaten[i] then
            begin
            j := j + 1;
            VecPAnio[j] := VectorAnio[i];
            VecPPre[j]  := VectorPrecio[i];
            end
        else
            ContFail := ContFail + 1;
end; {procedure}


{ ALGOTIRMO DE BURBUJEO (BUBBLE SORT) --------------------------------------------------------}
Procedure OrdenarBurbuja
    (
        var VPat : TV_100_Str6;
        var VPre : TV_100_Real;
        N     : byte
    );

var
    Aux  : string;
    Aux2 : real;
    i    : byte;
    K    : byte;
    Tope : byte;

begin
    Tope:= N;
    repeat
        K := 0;
        for i:=1 to Tope-1 do
            If VPat[i] > VPat[i+1] then
                begin
                Aux       := VPat[i];
                VPat[i]   := VPat[i+1];
                VPat[i+1] := Aux;

                { Ordena los precios de acuerdo al orden de las patentes}
                Aux2      := VPre[i];
                VPre[i]   := VPre[i+1];
                VPre[i+1] := Aux2;

                K := i;
                end;

        Tope := K;

    until K =0;
end;


{ MOSTRAR PATENTE Y PRECIO -------------------------------------------------------------------}
procedure MostrarPatPre
    (
        vPat       : TV_100_Str6;
        vPre       : TV_100_Real;
        N          : byte;
        PreMaxLong : byte
    );

var
    i : byte;

begin
    for i:=1 to N do
        begin
        if vPat[i] = vPat[i+1] then
            TextColor(cyan)
        else
            TextColor(white);

        WriteLn(vPat[i],'  ->  ',vPre[i]:PreMaxLong+3:2); {Sumo 3 por el punto y los 2 decimales}
        end;
    WriteLn;
    TextColor(cyan);
    WriteLn('PATENTES que se repiten.-');
end;


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}

var
    VectorPaten  : TV_100_Str6;
    VectorAnio   : TV_100_UInt16;
    VectorPrecio : TV_100_Real;
    N            : UInt8;  {byte}

    AnioMin      : UInt16; {word}
    AnioMax      : UInt16; {word}

    Anio         : UInt16; {word}
    PrecioMin    : Real;

    Precio       : Real;
    CantVeh      : UInt8;  {byte}

    AnioI        : UInt16; {word} {Año Inicial}
    AnioF        : UInt16; {word} {Año Final  }
    PrecioProm   : Real;

    Op           : char;
    S            : char;

    Patente       : string;
    VecPAnio      : TV_100_UInt16;
    VecPPre       : TV_100_Real;
    j             : byte;
    ContFail      : byte;
    i             : byte;

    VectorPatOr   : TV_100_Str6; { Ejercicio 12 }
    VectorPreOr   : TV_100_Real; { Ejercicio 12 }

    PreMaxLong    : byte;

begin
    GenerarVectores(VectorPaten,VectorAnio,VectorPrecio,N);
    AnioMinMax(VectorAnio,N,AnioMin,AnioMax);

    GenerarPreMaxLong(VectorPrecio,N,PreMaxLong);

    repeat
        Menu(Op);
        case Op of
            'A' :
                begin
                repeat
                    repeat
                        ClrScr;
                        WriteLn('Ingresar el AÑO del cual desea conocer el Precio Minimo: ');
                        Write(' Desde: ',AnioMin,' | Hasta: ',AnioMax,' ---> ');
                        ReadLn(Anio);
                    until (Anio >= AnioMin) and (Anio <= AnioMax);

                    PrecioMin := PrecioMinimo(VectorAnio,VectorPrecio,N,Anio);
                    WriteLn;
                    if PrecioMin = 1e10 then begin
                        TextColor(yellow);
                        WriteLn(' Año no encontrado en el rango -> No hay precio mínimo');
                        TextColor(white);
                        end
                    else
                        WriteLn(' El Precio Mínimo para el año ',Anio,': $',PrecioMin:0:2);

                    Separador;

                    TextColor(red);
                    Write('Enter para reiniciar | S -> Salir ');
                    TextColor(white);
                    S := ReadKey;
                    S := UpCase(S);

                until (S = 'S');
                end; {'A'}

            'B' :
                begin
                repeat
                    ClrScr;
                    Write('Ingrese Precio: ');
                    ReadLn(Precio);

                    CantVeh := CantidadVehiculos(VectorPrecio,N,Precio);
                    WriteLn;

                    if CantVeh > 0 then
                        WriteLn(' Cantidad de Vehículos es: ',CantVeh)
                    else
                        WriteLn(' No se encontraron vehículos');

                    Separador;

                    TextColor(red);
                    Write('Enter para reiniciar | S -> Salir ');
                    TextColor(white);
                    S := ReadKey;
                    S := UpCase(S);
                until (S = 'S');
                end; {'B'}

            'C' :
                begin
                repeat
                    ClrScr;
                    Writeln('RANGO DE AÑOS: { ',AnioMin,' ; ',AnioMax,' }');
                    WriteLn;
                    Writeln(' Ingrese SUBRANGO');

                    repeat
                        gotoxy(1,4);
                        ClrEol;
                        Write('  Año Inicio ---> ');
                        ReadLn(AnioI);
                    until (AnioI >= AnioMin) and (AnioI <= AnioMax);

                    repeat
                        gotoxy(1,5);
                        ClrEol;
                        Write('  Año Fin    ---> ');
                        ReadLn(AnioF);
                    until (AnioF >= AnioI) and (AnioF <= AnioMax);

                    PrecioProm := PrecioPromedio(VectorAnio,VectorPrecio,N,AnioI,AnioF);
                    WriteLn;

                    if PrecioProm > 0 then
                        WriteLn('El Precio Promedio es: $',PrecioProm:0:2)
                    else
                        WriteLn('No existen datos para calcular');

                    Separador;

                    TextColor(red);
                    Write('Enter para reiniciar | S -> Salir ');
                    TextColor(white);
                    S := ReadKey;
                    S := UpCase(S);

                until (S = 'S');
                end; {'C'}

            'D' :
                begin
                repeat
                    ClrScr;
                    Write('Ingrese Patente {Formato: ABC123} --> ');
                    ReadLn(Patente);
                    Patente := UpCase(Patente);

                    ClrScr;
                    WriteLn('PATENTE: ',Patente);
                    WriteLn;

                    PatenteDatos(VectorPaten,VectorAnio,VectorPrecio,N,Patente,VecPAnio,VecPPre,J,ContFail);

                    if ContFail < N then
                        begin
                        WriteLn('  AÑO  |   PRECIO');
                        for i:=1 to J do
                            WriteLn(VecPAnio[i]:5,'  | ',VecPPre[i]:PreMaxLong+3:2,'  ');
                        end
                    else
                        begin
                        TextColor(yellow);
                        WriteLn(' NO SE ENCONTRARON DATOS');
                        end;

                    Separador;

                    TextColor(red);
                    Write('Enter para reiniciar | S -> Salir ');
                    TextColor(white);
                    S := ReadKey;
                    S := UpCase(S);

                until (S = 'S');
                end; {'D'}

        'E' :
            begin
                ClrScr;
                WriteLn('PATENTES ORDENADAS CON SU PRECIO');

                VectorPatOr := VectorPaten;
                VectorPreOr := VectorPrecio;
                OrdenarBurbuja(VectorPatOr, VectorPreOr, N);

                Separador;

                { LLAMADO AL PROCEDIMIENTO PARA MOSTAR PATENTE Y PRECIO }
                MostrarPatPre(VectorPatOr,VectorPreOr,N,PreMaxLong);

                Separador;
                TextColor(red);
                Write('ENTER para Salir ');
                TextColor(white);
                ReadLn;

            end; {'E'}

            end; {case}

    until false; {Sale y Fin de Programa con una opción dentro del procedimiento Menu : * -> halt;}
end.