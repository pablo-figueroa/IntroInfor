(*
-------------- ADICIONAL 7 BIS --------------
Arreglos Paralelos e Índice con significado

Una planta de silos registra el ingreso de camiones de sus clientes con cereal.
Por cada uno se tiene:
    • Cliente
    • Patente del camión
    • Tipo de cereal
            1-trigo,
            2-girasol,
            3-soja,
            4-maiz
    • Toneladas

Se pide:
    • Lea los datos desde un archivo y
      mediante un menú de opciones iterativo
      calcule e informe:

        a) Porcentaje de toneladas de cada cereal respecto del total.

        b) Dada una patente, si es que existe, decir:
            * qué tipo de cereal transporta,
            * las toneladas y
            * a qué cliente pertenece.
        c) Generar un arreglo con los clientes que transportaron más de X peso ordenado alfabéticamente.


CLIENTE	        PATENTE	      TIPO CEREAL	TONELADAS
Pablo    	    SOD026	                1	      2.2



*)


program T6_Ad7;

//{$codepage UTF8}

uses crt;

type
    TSrt6       = string[6];
    TV_50_Str10 = array[1..50] of string[10]; { Para el Nombre                   }
    TV_50_Str6  = array[1..50] of string[6];  { Para al Patente                  }
    TV_50_Byte  = array[1..50] of Byte;       { Para el Tipo de Cereal           }
    TV_50_Real  = array[1..50] of Real;       { Para las Toneladas               }

    TV_4_Str10  = array[1..4]  of string[10]; { Para los nombres de los cereales }


{ --------------------------------------------------------------------------------------------}
procedure Titulo();

begin
    ClrScr;
    WriteLn('-------------------------------------------------');
    WriteLn('               PLANTA DE SILOS');
    WriteLn('-------------------------------------------------');
    WriteLn;
    WriteLn;
end;{procedure}


{ --------------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('-------------------------------------------------');
    WriteLn;
end;{procedure}


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
        WriteLn(' a | PORCENTAJE de Toneladas de cada cereal.');
        WriteLn(' b | Información a partir de una PATENTE.');
        WriteLn(' c | CLIENTES que transportan MÁS de X Peso.');
        WriteLn(' * | Fin del Programa.');
        WriteLn;
        Write('---> Ingrese Opción: ');
        Op := ReadKey;
        if Op = '*' then
            halt;
        Op := UpCase(Op);
    until (Op = 'A') or (Op = 'B') or (Op = 'C');

end; {procedure}

{ --------------------------------------------------------------------------------------------}
procedure LeerVectores
    (
        var TV_Nom : TV_50_Str10; { Nombre         }
        var TV_Pat : TV_50_Str6;  { Patente        }
        var TV_TdC : TV_50_Byte;  { Tipo de Cereal }
        var TV_Ton : TV_50_Real;  { Toneladas      }
        var N      : Byte         { Longitud       }
    );

var
    i    : byte;
    arch : text;

    Nom  : String[10];
    Pat  : String[6];
    TdC  : Byte;
    Ton  : Real;

begin
    assign(arch, 'T6_Ad7.txt');
    Reset(arch);
    i := 0;
    while not eof(arch)do
        begin
        i := i + 1;
        ReadLn(arch, Nom, Pat, TdC, Ton);
        TV_Nom[i] := Nom;
        TV_Pat[i] := Pat;
        TV_TdC[i] := TdC;
        TV_Ton[i] := Ton;
        end;
    Close(arch);
    N := i;
end;


{ --------------------------------------------------------------------------------------------}
procedure Porcentajes
    (
        TV_TdC : TV_50_Byte;
        TV_Ton : TV_50_Real;
        N      : byte;

        var TV_Porc : TV_50_Real { Vector Porcentajes }
    );

var
    i      : byte;
    VAcum  : TV_50_Real;
    AcumT  : Real;

begin
    { INICIALIZACION }
    AcumT := 0;
    for i:=1 to 4 do
        VAcum[i] := 0;

    { Acumulación por Tipo de Cereal }
    for i:=1 to N do
        case TV_TdC[i] of
            1 : VAcum[1] := VAcum[1] + TV_Ton[i];
            2 : VAcum[2] := VAcum[2] + TV_Ton[i];
            3 : VAcum[3] := VAcum[3] + TV_Ton[i];
            4 : VAcum[4] := VAcum[4] + TV_Ton[i];
            end; {case}

    for i:=1 to 4 do
        AcumT := AcumT + VAcum[i];

    for i:=1 to 4 do
        TV_Porc[i] := (VAcum[i] / AcumT) * 100;
end; {procedure}



{ --------------------------------------------------------------------------------------------}
function Patente (
    TV_Pat    : TV_50_Str6;  { Patente        }
    N         : Byte;        { Longitud       }
    Pat       : TSrt6
):byte;

var
    i : byte;

begin
    i := 1;
    while (i <= N) and (Pat <> TV_Pat[i]) do
        i := i + 1;

    if i <= N then
        Patente := i
    else
        Patente := 0;
    
end; {procedure}

{ --------------------------------------------------------------------------------------------}
function MaximoPeso (
    TV_Ton : TV_50_Real;
    N      : Byte
):Real;

 var
    i   : byte;
    Aux : Real;

begin
    Aux := 0;
    for i:=1 to N do
        if TV_Ton[i] > Aux then
            Aux := TV_Ton[i];
    MaximoPeso := Aux;
end;

{ --------------------------------------------------------------------------------------------}
{Generar un arreglo con los clientes que transportaron más de X peso ordenado alfabéticamente}
procedure ClientesPeso (
    TV_Nom        : TV_50_Str10;
    TV_Ton        : TV_50_Real;
    N             : byte;
    X             : Real; { Peso }
    
    var TV_CliOrd : TV_50_Str10;
    var C         : byte  { Longitud }
);

var
    i : byte;
    j : byte;

    Aux    : string;
    K      : byte;
    Tope   : byte;

    VLista  : TV_50_Str10;
    
begin
    j := 0;

    for i:=1 to N do
        vLista[i] := '';
    
    { GENERAR LISTA de los que superan el peso }
    for i:=1 to N do
        if TV_Ton[i] > X then
            begin
            j := j + 1;
            VLista[j] := TV_Nom[i];
            end;
    C := j; { Longitud }

    { ORDENAR LA LISTA -> BUBBLE SORT }
    Tope := C;
    repeat
        K := 0;
        for i:=1 to Tope-1 do
            if VLista[i] > VLista[i+1] then
                begin
                Aux         := VLista[i];
                VLista[i]   := VLista[i+1];
                VLista[i+1] := Aux;
                K := i;
                end;
        Tope := K;
    until K =0;
    
        { Vector de salida }
    TV_CliOrd := VLista;

end; {procedure}        


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
const
    TV_Cereales: TV_4_Str10 = ('Trigo', 'Girasol', 'Soja', 'Maiz');

var
    TV_Nom  : TV_50_Str10;   { Nombre         }
    TV_Pat  : TV_50_Str6;    { Patente        }
    TV_TdC  : TV_50_Byte;    { Tipo de Cereal }
    TV_Ton  : TV_50_Real;    { Toneladas      }
    N       : Byte;          { Longitud       }

    
    TV_Porc   : TV_50_Real;
    TV_PatTdC : TV_50_Str10;
    TV_PatTon : TV_50_Real;
    TV_CliOrd : TV_50_Str10; { Clientes Ordenados }
    C         : byte;        { Longitud de TV_CliOrd }
    
    Cliente : String;
    Pat     : string[6];
    X       : Real;          { Almacena el Peso X de la Op 'c' }
    MaxPeso : Real;
    
    AuxStr  : String;
    A       : byte;
    
    i  : Byte;
    Op : char;
    S  : char;

begin readln;
    repeat
        AuxStr := '';
        LeerVectores(TV_Nom, TV_Pat, TV_TdC, TV_Ton, N);
        Menu(Op);
    
        case Op of
            'A' :
                begin
                ClrScr;
                WriteLn('---------------');
                WriteLn('  PORCENTAJES');
                WriteLn('---------------');
                WriteLn;
    
                Porcentajes(TV_TdC, TV_Ton, N, TV_Porc);
                
                
                for i:=1 to 4 do { 4 porque son 4 los cereales }
                    begin
                    A := 8 - length(TV_Cereales[i]);
                    WriteLn(i,' - ',TV_Cereales[i],AuxStr:A,': ',TV_Porc[i]:5:2,' %');
                    end;
    
                Separador;
                TextColor(red);
                Write('ENTER -> Salir ');
                TextColor(white);
                ReadLn;
                end; { A }
    
            'B' :
                begin
                    repeat
                        ClrScr;
                        Write('Ingrese una patente: ');
                        ReadLn(Pat);
                        Pat := UpCase(Pat);
    
                        ClrScr;
                        Writeln('PATENTE: ',Pat);
                        
                        i := Patente(TV_Pat, N, Pat);
                        
                        Separador;
                        
                        if i <> 0 then
                            begin
                            WriteLn('Cliente   : ',TV_Nom[i]);
                            WriteLn('Cereal    : ',TV_Cereales[TV_TdC[i]]); { He flipao..!}
                            WriteLn('Toneladas : ',TV_Ton[i]:0:1);
                            end
                        else
                            Writeln('NO SE ENCONTRÓ LA PATENTE');
    
                        Separador;
    
                        TextColor(red);
                        Write('ENTER -> Reinicia | S -> Salir |  ');
                        TextColor(white);
                        S := ReadKey;
                        S := UpCase(S);
    
                    until (S = 'S');
    
                end; { B }
            'C' : 
                begin
                    repeat
                        
                        MaxPeso := MaximoPeso(TV_Ton,N);
                        
                        repeat
                            ClrScr;
                            Write('Ingresar PESO (Máximo Peso ',MaxPeso:3:1,'): ');
                            ReadLn(X);
                        until X < maxPeso;
    
                        ClrScr;
                        WriteLn('PESO: ',X:3:1);
    
                        Separador;
    
                        ClientesPeso(TV_Nom, TV_Ton, N, X, TV_CliOrd, C);
    
                        WriteLn('Clientes que superan las ',X:3:1,' toneladas.');
                        for i:=1 to C do
                            Writeln(' ',TV_CliOrd[i]);
                        
                        Separador;
    
                        TextColor(red);
                        Write('ENTER -> Reinicia | S -> Salir |  ');
                        TextColor(white);
                        S := ReadKey;
                        S := UpCase(S);
    
                    until (S = 'S');
                end; {C}
        end; {case}
    until false; {Salida y Fin de Programa con una opción dentro del procedimiento Menu : * -> halt;}
end.