(*
----------------------------------------- EJERCICIO 9 -----------------------------------------
    
    Verificar si un arreglo de reales esta ordenado ascendentemente.

    EJEMPLO:
        (-1.0  4.0  6.0  8.0 )   ==> TRUE
        (-1.0  4.0  6.0  6.0 )   ==> FALSE
    
*)

program T6_Ej09;
//{$codepage UTF8}
uses crt;

type
    TV_50_Real = array[1..50] of Real; { word }


{ LEER VECTORES ---------------------------------------------------------------------------}
procedure LeerVector
    (
        var VectorK : TV_50_Real;
        var K       : byte
    );

var i : byte;

begin
    repeat
        ClrScr;
        Write('Ingrese longitud del vector: ');
        ReadLn(K);
    until K > 0;
    
    for i:=1 to K do begin
        ClrScr;
        Write('Ingresar ENTERO de la posición ',i,': ');
        ReadLn(VectorK[i]);
    end; {for}

end;{procedure}


{ SEPARADOR ----------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    TextColor(yellow);
    WriteLn('-----------------------------------------------------------------');
    WriteLn;
    TextColor(white);
end;{procedure Separador}


{ MOSTRAR VECTOR INGRESADO -------------------------------------------------------------------}
procedure MostrarVector
    (
        VectorK   : TV_50_Real;
        K     : byte
    );

var i : byte;

begin
    Write('VECTOR INGRESADO: (');
    for i:=1 to K do begin
        Write(VectorK[i]:4:1);
    end; {for}
    WriteLn(' )');
end; {procedure}


{ VERIFICAR SI TODOS SON PARES ---------------------------------------------------------------}
function VerificarAsc
    (
        VectorK : TV_50_Real;
        k       : byte
    ):boolean;

var 
    i       : byte;
    Cont    : byte;

begin
    Cont := 0;
    for i:=1 to (K - 1) do begin
        if VectorK[i] < VectorK[i+1] then begin
            Cont := Cont + 1;
        end;{if}
    end; {for}

    if Cont = (K - 1) then
        VerificarAsc := True;
    
end; {function}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    VectorK : TV_50_Real;
    k       : byte;
    S       : char;

begin
repeat
    LeerVector(VectorK,K);
    
    ClrScr;
    
    MostrarVector(VectorK,K);
    
    Separador;

    WriteLn('¿Elementos ordenados ascendentemente?  ==>  ',VerificarAsc(VectorK,K));
    
    Separador;
    
    TextColor(red);
    Write('Enter para reiniciar | S -> Salir ');
    TextColor(white);
    S := ReadKey;
    S := UpCase(S);

until (S = 'S');
end.