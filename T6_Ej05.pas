(*
----------------------------------------- EJERCICIO 5 -----------------------------------------
REMAKE

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

*)

program T6_Ej05;
//{$codepage UTF8}
uses crt;

type
    TV_Str6       = array[1..100] of string[6];
    TV_100_UInt16 = array[1..100] of UInt16; { word }
    TV_100_Real   = array[1..100] of Real;


{ GENERAR VECTORES ---------------------------------------------------------------------------}
procedure GenerarVectores
    (
        var VectorPaten  : TV_Str6;
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
    PrecioMin := 9999999;
    for i:=1 to N do begin
        if (anio = VectorAnio[i]) and (PrecioMin > VectorPrecio[i]) then
            PrecioMin := VectorPrecio[i];
    end;{for}
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
    for i:=1 to N do begin
        if VectorPrecio[i] < Precio then
            ContVeh := ContVeh + 1;
    end; {for}
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
        begin
        if (VectorAnio[i] >= AnioI) and (VectorAnio[i] <= AnioF) then begin
            AcumPrecio := AcumPrecio + VectorPrecio[i];
            ContVeh := ContVeh + 1;
        end;{if}
    end;{for}
    if ContVeh > 0 then
        PrecioPromedio := AcumPrecio/ContVeh;
    
    
    
    
end; {procedure}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}

var
    VectorPaten  : TV_Str6;
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

begin
    GenerarVectores(VectorPaten,VectorAnio,VectorPrecio,N);
    AnioMinMax(VectorAnio,N,AnioMin,AnioMax);

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
        
                    if PrecioMin = 9999999 then begin
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
            end; {'A'}
            
                    
        'B' : 
            begin
                repeat
                    ClrScr;
                    Write('Ingrese Precio: ');
                    ReadLn(Precio);
                    
                    CantVeh := CantidadVehiculos(VectorPrecio,N,Precio);
        
                    if CantVeh > 0 then 
                        WriteLn('Cantidad de Vehículos es: ',CantVeh)
                    else 
                        WriteLn('No se encontraron vehículos');
                    
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
        end; {case}
    until false; {Sale y Fin de Programa con una opción dentro del procedimiento Menu : * -> halt;}
end.