(*
Ejemplo 2

Ingresar un conjunto de letras mayúsculas y minúsculas ( * indica fin de datos). Generar
un nuevo arreglo que contenga solo las consonantes. Mostrar el arreglo obtenido o indicar que no
hubo consonantes.
*)

program Ej2;
//{$codepage UTF8}
uses crt;

TYPE
    TV=array[1..100] of char;

{ LEER VECTOR --------------------------------------------------------------------------------}
procedure LeeVector (Var V : TV;
                     Var N : byte);
Var
    Car : char;
Begin
    N:=0;
    Write('Ingrese una letra | ');
    TextColor(red);
    Write('*');
    TextColor(white);
    Write(' -> fin de datos: '); 
    Readln(Car);
    While Car <> '*' do
        Begin
        N:= N + 1;
        V[N]:= Car;
        Write('Ingrese una letra | ');
        TextColor(red);
        Write('*');
        TextColor(white);
        Write(' -> fin de datos: ');
        Readln(Car);
        End;{while}
End;{procedure}

{ VERIFICAR VOCAL ----------------------------------------------------------------------------}
function EsVocal(L:char): boolean;
Begin
    L := Upcase(L);
    case L of
        'A','E','I','O','U': EsVocal := True;
    else
        EsVocal := false;
    end;{case}
End;{function}

{ GENERAR OTRO VECTOR ------------------------------------------------------------------------}
procedure GeneraOtro (VL     : TV;
                      N      : byte; 
                      VAR VC : TV;
                      VAR M  : byte);
Var
    i : byte;
Begin
    M:= 0;
    For i:=1 to N do
        Begin
        If Not EsVocal(VL[i]) Then
            Begin
            M:=M +1;
            VC[M] := VL[i];
            End;{if}
        End;{for}    
End;{procedure}

{ ESCRIBIR VECTOR -----------------------------------------------------------------------------}
procedure EscVector ( V : TV; 
                      L : byte);
Var
    i : byte;
Begin
    For i:=1 to L do
        Write(V[i] : 5);
End;{procedure}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
VAR
    N, M  : byte;
    VL,VC : TV;

begin
    ClrScr;
    LeeVector(VL, N);
    GeneraOtro (VL , N, VC , M );
    WriteLn;
    If M <> 0 then
        begin
        TextColor(yellow);
        Write('Consonantes ingresadas: ');
        EscVector(VC, M);
        end
    else
        begin
        TextColor(red);
        Writeln('No se ingresaron consonantes.-');
        end;
    ReadLn;
end.