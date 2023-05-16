(*
----------------------------------------- EJERCICIO 8 -----------------------------------------

    Verificar si todos los elementos de un arreglo de K enteros son pares.

    EJEMPLO:
        (-2 4 6 0 )   ==> TRUE
        (-1 4 6 0 )   ==> FALSE
    
*)

program T6_Ej08;
//{$codepage UTF8}
uses crt;

type
    TV_50_Int16 = array[1..50] of Int16; { word }


{ LEER VECTORES ---------------------------------------------------------------------------}
procedure LeerVector
    (
        var VectorK : TV_50_Int16;
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
        VectorK   : TV_50_Int16;
        K     : byte
    );

var i : byte;

begin
    Write('VECTOR INGRESADO: (');
    for i:=1 to K do begin
        Write(VectorK[i]:4);
    end; {for}
    WriteLn(' )');
end; {procedure}


{ VERIFICAR SI TODOS SON PARES ---------------------------------------------------------------}
function VerificarSiPares
    (
        VectorK : TV_50_Int16;
        k       : byte
    ):boolean;

var 
    i       : byte;
    ContPar : byte;

begin
    ContPar := 0;
    for i:=1 to K do begin
        if VectorK[i] mod 2 = 0 then
            ContPar := ContPar + 1;
    end; {for}

    if ContPar = K then
        VerificarSiPares := True;
    
end; {function}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    VectorK : TV_50_Int16;
    k       : byte;
    S       : char;

begin
repeat
    LeerVector(VectorK,K);
    
    ClrScr;
    
    MostrarVector(VectorK,K);
    
    Separador;

    WriteLn('¿Todos los elementos del vector son pares?  ==>  ',VerificarSiPares(VectorK,K));
    
    Separador;
    
    TextColor(red);
    Write('Enter para reiniciar | S -> Salir ');
    TextColor(white);
    S := ReadKey;
    S := UpCase(S);

until (S = 'S');
end.