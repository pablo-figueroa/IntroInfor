(*
----------------------------------------- EJERCICIO 17 -----------------------------------------

En un taller de reparación de vehículos, se ha registrado en un archivo los siguientes datos de
las unidades:

    * Tipo 
        (
            1-particular, 
            2-carga, 
            3-transporte de pasajeros, 
            4-oficial, 
            5-servicios
        )
    
    * Costo de la reparación

Se pide leer la información para calcular e informar para cada tipo: 
    * el monto recaudado y el
    * porcentaje que representa del total.

    EJEMPLO:
        Tipo   Monto       Porcentaje
        1       2000.00     10.00 %                   
        2       3000.00     15.00 %                    
        3       4000.00     20.00 %                     
        4       5000.00     25.00 %                      
        5       6000.00     30.00 %                      
    SUMA ->    20000.00    100.00 %

*)

program T6_Ej17;

//{$codepage UTF8}

uses crt, SysUtils;

type
    TV_50_Byte = array[1..50] of Byte;
    TV_50_Real = array[1..50] of Real;
    TV_5_Str   = array[1..5]  of string;


{ --------------------------------------------------------------------------------------------}
procedure Titulo();

begin
    ClrScr;
    WriteLn('-------------------------------------------------');
    WriteLn('       TALLER DE REPARACIÓN DE VEHÍCULOS');
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


{ --------------------------------------------------------------------------------------------}
procedure LeerVector
    (
        var VT : TV_50_Byte; { Vector Tipo         }
        var VM : TV_50_Real; { Vector Monto        }
        var L  : byte        { Longitud del Vector }
    );

var
    
    i : Byte;
    T : Byte; { Tipo  }
    M : Real; { Monto }

    arch : text;

begin

    i := 0;
    Assign(arch, 'T6_Ej17.txt');
    Reset(arch);
    while not eof(arch) do
        begin
        i := i + 1;
        Read(arch, T,M);
        VT[i] := T;
        VM[i] := M;
        end; {while}
    Close(arch);
    L := i;

end; {procedure}


{ MOSTRAR VECTOR REAL ------------------------------------------------------------------------}
procedure MostrarVector
    (
        V : TV_50_Real;
        N : byte
    );

var
    i : byte;

begin
    for i:=1 to N do
        if V[i] = Trunc(V[i]) then
            Write(V[i]:6:0)
        else
            Write(V[i]:6:1);
end;{procedure}


{ --------------------------------------------------------------------------------------------}
procedure CalcularMontos
    (
        VT          : TV_50_Byte; { Vector Tipo             }
        VM          : TV_50_Real; { Vector Monto            }
        L           : byte;       { Longitud del Vector     }
        var VM_Acum : TV_50_Real  { Vector Monto Acumulador }
    );

var
    i : byte;

begin
    { Inicializo el Vector Monto Acumulador}
    for i:=1 to 5 do
        VM_Acum[i] := 0;
    
    for i:=1 to L do
        case VT[i] of
            1 : VM_Acum[i] := VM_Acum[i] + VM[i];
            2 : VM_Acum[i] := VM_Acum[i] + VM[i];
            3 : VM_Acum[i] := VM_Acum[i] + VM[i];
            4 : VM_Acum[i] := VM_Acum[i] + VM[i];
            5 : VM_Acum[i] := VM_Acum[i] + VM[i];
        end; {case}
end; 


{ --------------------------------------------------------------------------------------------}
procedure CalcularPorcentajes
    (
        VM_Acum        : TV_50_Real; { Vector Monto Acumulador  }
        var V_Porcent  : TV_50_Real; { Vector Porcentajes       }
        var T          : Real        { Suma TOTAL de los montos }
    );

var
    i : Byte;

begin
    T := 0;
    for i:=1 to 5 do
        T := T + VM_Acum[i];

    for i:=1 to 5 do
        V_Porcent[i] := 0;
    
    for i:=1 to 5 do
        begin
        V_Porcent[i] := VM_Acum[i] * 100 / T;
        end;
end;


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
const
    TV_Taller: TV_5_Str = ('Particular', 'Carga', 'Transporte de pasajeros', 'Oficial', 'Servicios');

var
    TV_Tipo    : TV_50_Byte;  { Vector Tipo              }
    TV_Monto   : TV_50_Real;  { Vector Monto             }
    L          : byte;        { Longitud del Vector      }

    VM_Acum    : TV_50_Real;  { Vector Monto Acumulador  }
    V_Porcent  : TV_50_Real;  { Vector Porcentajes       }
    MontoTotal : Real;        { Suma TOTAL de los montos }

    i : Byte;
    Y : Byte;
    S : Char;

begin
    repeat
        i := 0;
        Titulo;
        LeerVector(TV_Tipo, TV_Monto, L);
      
        CalcularMontos(TV_Tipo, TV_Monto, L, VM_Acum);
        CalcularPorcentajes(VM_Acum, V_Porcent, MontoTotal);
        
        WriteLn('TIPO DE VEHÍCULO              MONTO    PORCENTAJE');
        WriteLn;
        for i:=1 to 5 do
            WriteLn(' ',TV_Taller[i]);
        
        Y := WhereY - 5;
            
        for i:=1 to 5 do
            begin
            GotoXY(25,Y);
            Writeln(' : ',TV_Monto[i]:8:2,'      ',V_Porcent[i]:5:2,' %');
            Y := Y + 1;
            end;
        WriteLn;
        WriteLn('MONTO TOTAL: ',MontoTotal:8:2);

        Separador;
        
        TextColor(red);
        Write(' | S -> Salir |  ');
        TextColor(white);
        S := ReadKey;
        S := UpCase(S);
    
    until (S = 'S');
end.