(*
----------------------------------------- EJERCICIO 15 -----------------------------------------
SELECTION SORT
A partir de un arreglo A de reales desordenado, 
    se pide generar OTRO arreglo B 
    con los mismos elementos de A ordenados, 
    utilizando el procedimiento SeleccionOrdenado()

    EJEMPLO:
    Vector Ingresado   : [     3     2     1     0    -1  -2.1  ]

    Vector Original  A : [     3     2     1     0    -1  -2.1  ]
    Vector Ordenado  B : [  -2.1    -1     0     1     2     3  ]

    ---

    Vector Ingresado   : [   2.2   3.3   1.1     0  -1.1  -2.2  ]

    Vector Original  A : [   2.2   3.3   1.1     0  -1.1  -2.2  ]
    Vector Ordenado  B : [  -2.2  -1.1     0   1.1   2.2   3.3  ]

*)

program T6_Ej15;

//{$codepage UTF8}

uses crt, SysUtils;

type
    TV_20_Real = array[1..20] of Real;


{ --------------------------------------------------------------------------------------------}
procedure Titulo();

begin
    ClrScr;
    WriteLn('-------------------------------------------------');
    WriteLn('          ORDENAR CON SELECTION SORT');
    WriteLn('-------------------------------------------------');
    WriteLn;
    WriteLn;
end;


{ ENTRADA DEL VECTOR -------------------------------------------------------------------------}
procedure LeerVector
    (
        var V : TV_20_Real;
        var N : byte
    );

var
    i : byte;
    Y : byte;

begin
    Y := whereY;
    
    repeat
        Write('Ingresar cantidad de posiciones del array [1..20]: ');
        ReadLn(N)
    until (N >= 1) and (N <= 20);

    for i:=1 to N do
        begin
        gotoxy(1,Y+1);
        ClrEol;
        gotoxy(1,Y);
        ClrEol;
        Write('Ingresar Real N° ',i,' de ',N,': ');
        ReadLn(V[i]);
        end;{for}

end;{procedure}


{ MOSTRAR VECTOR ENTERO ----------------------------------------------------------------------}
procedure MostrarVector
    (
        V : TV_20_Real;
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


{ ALGOTIRMO DE SELECTION SORT ----------------------------------------------------------------------}
Procedure SeleccionOrdenar
    (
        var V : TV_20_Real;
        N     : byte
    );

var
    Min,i,k : byte;
    aux     : Real;

begin
    for k:=1 to N-1 do
        begin
        Min := k;
        for i:=k+1 to N do
            if V[Min] > V[i] then
                Min := i;
        if Min <> k then
            begin
            Aux    := V[k];
            V[k]   := V[Min];
            V[Min] := Aux;
            end;
        end; {for}
end; {procedure}

{ SEPARADOR ----------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('-------------------------------------------------------');
    WriteLn;
end;{procedure Separador}


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    Vector    : TV_20_Real;
    VectorOrd : TV_20_Real;
    N         : byte;

    S         : char;
    

begin
    repeat
    Titulo;
    LeerVector(Vector,N);

    Titulo;
    Write('Vector Ingresado   : [');
    MostrarVector(Vector,N);
    WriteLn('  ]');

    Separador;

    VectorOrd := Vector;
    SeleccionOrdenar(VectorOrd,N);
    Write('Vector Original  A : [');
    MostrarVector(Vector,N);
    WriteLn('  ]');
    Write('Vector Ordenado  B : [');
    MostrarVector(VectorOrd,N);
    WriteLn('  ]');

    Separador;
    
    TextColor(red);
    Write('Enter -> Intentar otro Vector | S -> Salir ');
    TextColor(white);
    S := ReadKey;
    S := UpCase(S);

until (S = 'S');
end.