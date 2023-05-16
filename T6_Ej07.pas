(*
----------------------------------------- EJERCICIO 7 -----------------------------------------

    A PARTIR DEL EJERCICIO 5 y para una patente dada:
    
        Mostrar los datos del auto (indicar si no se encontró).

    EJEMPLO: 
        Patente: AAA111
            Año: 2017 | Precio: 4000.00
            Año: 2018 | Precio: 3960.00
            Año: 2019 | Precio: 3920.40
            ...

    NOTA: Se utiliza mismo archivo .txt del Ejercicio 5.
*)

program T6_Ej05;
//{$codepage UTF8}
uses crt;

type
    TV_50_UInt16 = array[1..50] of UInt16; { word }
    TV_50_Real   = array[1..50] of Real;
    TV_50_Str    = array[1..50] of String[6];


{ GENERAR VECTORES ---------------------------------------------------------------------------}
procedure GenerarVectores
    (
        var VectorPatente : TV_50_Str;
        var VectorAnio    : TV_50_UInt16;
        var VectorPrecio  : TV_50_Real;
        var N             : byte
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
        VectorPatente[i] := pa;
        VectorAnio[i]    := an;
        VectorPrecio[i]  := pr;
        N := N + 1;
    until eof(arch);
end; {procedure}


{ SEPARADOR ----------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    TextColor(yellow);
    WriteLn('-----------------------------------------------------------------');
    WriteLn;
    TextColor(white);
end;{procedure Separador}


{ PATENTE DATOS ------------------------------------------------------------------------------}
procedure PatenteDatos
    (
        VectorPatente : TV_50_Str;
        VectorAnio    : TV_50_UInt16;
        VectorPrecio  : TV_50_Real;
        N             : byte
    );

var
    Patente   : string[6];
    ContFail  : byte;
    S         : char;
    i         : byte;
    
begin
repeat
    ContFail := 0;
    ClrScr;
    Write('Ingrese Patente {Formato: AAA111} --> ');
    ReadLn(Patente);
    Patente := UpCase(Patente);
    ClrScr;
    WriteLn('PATENTE: ',Patente);
    WriteLn;
    WriteLn('  Año |   Precio ');
    
    for i:=1 to N do begin
        if Patente = VectorPatente[i] then
            WriteLn(VectorAnio[i]:5,' | ',VectorPrecio[i]:8:2)
        else
            ContFail := ContFail + 1;
    end; {for}
    
    if ContFail = N then begin
        TextColor(yellow);
        WriteLn(' NO SE ENCONTRARON DATOS');
    end; {if}
    
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
    VectorPatente : TV_50_Str;
    VectorAnio    : TV_50_UInt16;
    VectorPrecio  : TV_50_Real;
    N             : byte;

begin
    ClrScr;
    GenerarVectores(VectorPatente,VectorAnio,VectorPrecio,N);
    PatenteDatos(VectorPatente,VectorAnio,VectorPrecio,N);
end.