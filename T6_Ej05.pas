(*
----------------------------------------- EJERCICIO 5 -----------------------------------------

Leer de un archivo de texto sobre tres arreglos los datos de un conjunto de autos, por cada uno:
    - Patente
    - Año
    - Precio

Se pide mediante un menú que permita la repetición de las opciones con diferentes valores,
calcular:
    a. Para un año dado, precio mínimo (puede no existir)
    b. Para un precio dado cantidad de vehículos por debajo de dicho valor
    c. Para un rango de años dado [Año1, Año2] precio promedio de los autos en dicho rango (puede
no existir)

Ejemplo:
    AAA111	2017	4000,00
    BBB222	2017	4500,00
    CCC333	2017	5000,00
    DDD444	2017	5500,00
    EEE555	2017	6000,00
    AAA111	2018	3960,00
    BBB222	2018	4455,00
    CCC333	2018	4950,00
    DDD444	2018	5445,00
    EEE555	2018	5940,00
    AAA111	2019	3920,40
    ...

    a. 2017          -> Precio Mínimo : 4000.00
       2018          -> Precio Mínimo : 3960.00

    b. 5500          -> Cantidad de Vehiculos por debajo 5500 : 19

    c. {2017 ; 2018] -> Promedio : 4975.00

*)

program T6_Ej05;
//{$codepage UTF8}
uses crt, SysUtils;

type
    TV_100_UInt16 = array[1..100] of UInt16; { word }
    TV_100_Real   = array[1..100] of Real;


{ GENERAR VECTORES ---------------------------------------------------------------------------}
procedure GenerarVectores
    (
        var VectorAnio   : TV_100_UInt16;
        var VectorPrecio : TV_100_Real;
        var N            : byte
    );

var
    pa : string[6]; { Para leer la patente }
    an : word;      { Para leer el año     }
    pr : real;      { Para leer el precio  }

    arch : text;
    i    : byte;

begin
    i := 0;
    N := 0;
    Assign(arch, 'T6_Ej05.txt');
    Reset(arch);
    repeat
        ReadLn(arch, pa,an,pr);
        (* Write(pa,' ',an,' ',pr:0:2); *)
        (* WriteLn; *)
        i := i + 1;
        VectorAnio[i]   := an;
        VectorPrecio[i] := pr;
        N := N + 1;
    until eof(arch);
end; {procedure}


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
        WriteLn(' * | Fin del Programa.');
        WriteLn;
        Write('---> Ingrese Opción: ');
        (* ReadLn(Op); *)
        Op := ReadKey;
        if Op = '*' then
            halt;
        Op := UpCase(Op);
    until (Op = 'A') or (Op = 'B') or (Op = 'C');

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
    WriteLn('-----------------------------------------------------------------');
    WriteLn;
    TextColor(white);
end;{procedure Separador}


{ a. Para un año dado, precio mínimo (puede no existir) --------------------------------------}
procedure PrecioMinimo
    (
        VectorAnio   : TV_100_UInt16;
        VectorPrecio : TV_100_Real;
        N            : byte;
        AnioMin      : word;
        AnioMax      : word
    );

var
    i         : byte;
    anio      : word;
    PrecioMin : real;
    S         : char;

begin
repeat
    PrecioMin := 9999999;
    repeat
        gotoxy(1,1);
        ClrScr;
        WriteLn('Ingresar el AÑO del cual desea conocer el Precio Minimo: ');
        ClrEol;
        Write(' Desde: ',AnioMin,' | Hasta: ',AnioMax,' ---> ');
        ReadLn(Anio);
    until (Anio >= AnioMin) and (Anio <= AnioMax);

    WriteLn;

    for i:=1 to N do
        begin
        if (anio = VectorAnio[i]) and (PrecioMin > VectorPrecio[i]) then
            PrecioMin := VectorPrecio[i];
        end;{for}

    if PrecioMin = 9999999 then
        begin
        TextColor(yellow);
        WriteLn(' Año no encontrado en el rango -> No hay precio mínimo');
        TextColor(white);
        end
    else
        WriteLn(' El Precio Mínimo para el año ',Anio,': $',PrecioMin:0:2);

    WriteLn;

    Separador;

    TextColor(red);
    Write('Enter para reiniciar | S -> Salir ');
    TextColor(white);
    S := ReadKey;
    S := UpCase(S);

until (S = 'S');
end; {procedure}


{ b. Para un precio dado cantidad de vehículos por debajo de dicho valor ---------------------}
procedure CantidadVehiculos
    (
        VectorPrecio : TV_100_Real;
        N            : byte
    );

var
    i         : byte;
    ContVeh   : byte;
    Precio    : real;
    S         : char;

begin
repeat
    ContVeh := 0;
    ClrScr;
    Write('Ingrese Precio: ');
    ReadLn(Precio);

    for i:=1 to N do
        begin
        if VectorPrecio[i] < Precio then
            ContVeh := ContVeh + 1;
        end; {for}
    WriteLn;
    WriteLn('Cantidad de Vehículos es: ',ContVeh);

    Separador;

    TextColor(red);
    Write('Enter para reiniciar | S -> Salir ');
    TextColor(white);
    S := ReadKey;
    S := UpCase(S);

until (S = 'S');
end; {procedure}


{ c. Para un rango de años dado [Año1, Año2] precio promedio de los autos en dicho rango -----}
procedure PrecioPromedio
    (
        VectorAnio   : TV_100_UInt16;
        VectorPrecio : TV_100_Real;
        N            : byte;
        AnioMin      : word;
        AnioMax      : word
    );

var
    i          : byte;
    AcumPrecio : real;
    ContVeh    : byte;
    AnioI      : word;
    AnioF      : word;
    S          : char;

begin
repeat
    AcumPrecio := 0;
    ContVeh    := 0;
    ClrScr;
    Writeln('RANGO DE AÑOS: { ',AnioMin,' ; ',AnioMax,' }');
    Writeln(' Ingrese SUBRANGO');

    repeat
        gotoxy(1,3);
        ClrEol;
        Write('  Año Inicio ---> ');
        ReadLn(AnioI);
    until (AnioI >= AnioMin) and (AnioI <= AnioMax);

    repeat
        gotoxy(1,4);
        ClrEol;
        Write('  Año Fin    ---> ');
        ReadLn(AnioF);
    until (AnioF >= AnioI) and (AnioF <= AnioMax);

    for i:=1 to N do
        begin
        if (VectorAnio[i] >= AnioI) and (VectorAnio[i] <= AnioF) then
            begin
            AcumPrecio := AcumPrecio + VectorPrecio[i];
            ContVeh := ContVeh + 1;
            end;{if}
        end;{for}

    WriteLn;

    if ContVeh <> 0 then
        WriteLn('El Precio Promedio es: $',(AcumPrecio/ContVeh):0:2)
    else
        WriteLn('No existen datos para calcular');

    Separador;

    TextColor(red);
    Write('Enter para reiniciar | S -> Salir ');
    TextColor(white);
    S := ReadKey;
    S := UpCase(S);

until (S = 'S');
end; {procedure}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}

var
    VectorAnio   : TV_100_UInt16;
    VectorPrecio : TV_100_Real;
    N            : byte;
    AnioMin      : word;
    AnioMax      : word;
    Op           : char;

begin
    GenerarVectores(VectorAnio,VectorPrecio,N);
    AnioMinMax(VectorAnio,N,AnioMin,AnioMax);

repeat
    Menu(Op);
    case Op of
        'A' : PrecioMinimo(VectorAnio,VectorPrecio,N,AnioMin,AnioMax);
        'B' : CantidadVehiculos(VectorPrecio,N);
        'C' : PrecioPromedio(VectorAnio,VectorPrecio,N,AnioMin,AnioMax);
    end;
until false; {Sale y Fin de Programa con una opción dentro del procedimiento Menu : * -> halt;}
end.