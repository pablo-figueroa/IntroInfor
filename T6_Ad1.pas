(*
-------------- ADICIONAL 1 --------------

Almacenar en un arreglo M números enteros. 

Se pide poner en 0 los lugares ocupados por valores iguales al
máximo, salvo el primero de ellos. 

Mostrar por pantalla el conjunto original y el modificado. 

Además indicar la cantidad de reemplazos efectuados.

    Ejemplo:
    números originales  : 3 4 8 1 24 3 1 24 15 24
    números modificados : 3 4 8 1 24 3 1  0 15  0 , reemplazos = 2
----------------------------------------------------------------------
    EJEMPLO:
    Números Originales   :   1   1   8   1   2   1  -1   8   6   8
    Números Modificados  :   1   1   8   1   2   1  -1   0   6   0
    Reemplazos = 2

    Números Originales   :  -1  -1  -1  -1  -1  -1  -1 -10
    Números Modificados  :  -1   0   0   0   0   0   0 -10
    Reemplazos = 6

*)

program T6_Ad1;

//{$codepage UTF8}

uses crt;

type
    TV_20_Int  = array[1..20] of Integer;


{ --------------------------------------------------------------------------------------------}
procedure Titulo();

begin
    ClrScr;
    WriteLn('----------------------------------------------------------------------');
    WriteLn('             REEMPLAZAR MAX NUMERO ENTERO REPETIDOS');
    WriteLn('----------------------------------------------------------------------');
    WriteLn;
    WriteLn;
end;{procedure}


{ --------------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('----------------------------------------------------------------------');
    WriteLn;
end;{procedure}


{ --------------------------------------------------------------------------------------------}
procedure LeerVector
    (
        var V : TV_20_Int; { Vector Original     }
        var N : Byte       { Longitud del Vector }
    );

var
    i   : Byte;
    Y   : Byte;
    Num : Integer;

begin
    Write('Ingresar longitud del vector: ');
    ReadLn(N);

    Titulo;
    Y := whereY;
    for i:=1 to N do
        begin
        gotoxy(1,Y+1);
        ClrEol;
        gotoxy(1,Y);
        ClrEol;
        
        Write('Ingrese Entero (',i,' de ',N,'): ');
        ReadLn(Num);
        V[i] := Num;
        end; {for}
end;


{ --------------------------------------------------------------------------------------------}
procedure MostrarVector
    (
        V : TV_20_Int; { Vector Original     }
        N : Byte       { Longitud del Vector }
    );

var
    i : Byte;

begin
    for i:=1 to N do
        Write(V[i]:4);
    WriteLn;
end; {procedure}


{ --------------------------------------------------------------------------------------------}
procedure Reemplazar
    (
    V          : TV_20_Int;  { Vector Original        }
    N          : Byte;       { Longitud del Vector    }
    
    var Vmodif : TV_20_Int;  { Vector Modificado      }
    var R      : byte        { Cantidad de Reemplazos }
    
    );

var
    i      : Byte;
    NumMax : Integer;
    LugMax : Byte;
    
begin
    R := 0;
    NumMax := -9999;
    LugMax := N+1;
    
    Vmodif := V;
    
    { Hallar el Máximo y Lugar }
    for i:=1 to N do
        if V[i] > NumMax then
            begin
            NumMax := V[i];
            LugMax := i;
            end;

    { Reemplazar los repetidos }
    if LugMax < N+1 then
        for i:=LugMax+1 to N do 
            if V[i] = NumMax then
                begin
                Vmodif[i] := 0;
                R := R + 1;
                end;

end; { procedure }


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    V_Orig  : TV_20_Int; { Vector Original        }
    V_Modif : TV_20_Int; { Vector Modificado      }
    N       : Byte;      { Longitud del Vector    }
    R       : byte;      { Cantidad de Reemplazos }

    S : char;

begin
    repeat
        Titulo;
        LeerVector(V_Orig, N);
        
        Titulo;
        Write('Números Originales   :');
        MostrarVector(V_Orig, N);

        Separador;

        Reemplazar(V_Orig, N, V_Modif, R);
        if R > 0 then
            begin
            Write('Números Modificados  :');
            MostrarVector(V_Modif, N);
            Writeln;
            WriteLn('Reemplazos = ',R);
            
            end
        else
            WriteLn('No se encontraron números repetidos.-');
        
        Separador;

        TextColor(red);
        Write('ENTER -> Reinicia | S -> Salir |  ');
        TextColor(white);
        S := ReadKey;
        S := UpCase(S);

    until (S = 'S');

end.