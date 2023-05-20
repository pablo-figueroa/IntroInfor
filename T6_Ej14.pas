(*
----------------------------------------- EJERCICIO 14 -----------------------------------------

Ingresar un conjunto de números ordenados
almacenando en un arreglo los números sin repetición

    EJEMPLO

    Vector Ingresado        : [  1  2  2  2  2  3  ]
    Vector Sin Repeticiones : [  1  2  3  ]

    Vector Ingresado        : [  11  22  33  44  55  55  66  77  88  88  ]
    Vector Sin Repeticiones : [  11  22  33  44  55  66  77  88  ]

    Vector Ingresado        : [  -2  -1  0  0  1  2  ]
    Vector Sin Repeticiones : [  -2  -1  0  1  2  ]

    Vector Ingresado        : [  -2  -1  -0.5  -0.5  0  0  0  3  ]
    Vector Sin Repeticiones : [  -2  -1  -0.5  0  3  ]

*)

program T6_Ej14;

//{$codepage UTF8}

uses crt;

type
    TV_50_Real = array[1..50] of single;
    
    { LEAME! | Si se cambia la longitud del arryay 
                => cambiar valor var PriRep en LeerVectorAndPriRep}

{---------------------------------------------------------------------------------------------}
procedure Titulo();

begin
    ClrScr;
    WriteLn('-------------------------------------------------');
    WriteLn('    GENERA ARREGLO DE NÚMEROS SIN REPETICIÓN');
    WriteLn('-------------------------------------------------');
    WriteLn(' Nota: Ingresar números ordenados ascendentemente');
    WriteLn;
    WriteLn;
end;


{---------------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('------------------------------------------------------');
    WriteLn;
end;


{---------------------------------------------------------------------------------------------}
procedure LeerVectorAndPriRep    { Lee Vector y encuentra la primera repetición }
    (
        var V       : TV_50_Real;
        var N       : byte;
        var PriRep  : byte;
        var vNoRep  : TV_50_Real;
        var Cont0   : byte
    );

var
    i : byte;
    j : byte;
    Y : byte; { Posición y }
    
begin
    Cont0  := 0;
    Y      := whereY;
    PriRep := 51;          { porque el array es [1..50] así asumo que al ppio no hay repetidos}
    
    repeat
        GotoXY(1,Y);
        ClrEol;
        Write('Ingrese longitud del vector [1..50]: ');
        ReadLn(N);
    until (N >= 1) and (N <= 50);


    { El primer número nunca será repetido, el sugundo puede ser repetido del primero.}
    i      := 1;
    j      := 1;
    GotoXY(1,Y+1);
    ClrEol;
    GotoXY(1,Y);
    ClrEol;
    Write('Ingrese número (',i,' de ',N,') -> ');
    ReadLn(V[i]);
    vNoRep[j] := i;
    
    for i:=2 to N do
        begin
        repeat
            GotoXY(1,Y+1);
            ClrEol;
            GotoXY(1,Y);
            ClrEol;
            
            Write('Ingrese número (',i,' de ',N,') -> ');
            ReadLn(V[i]);
            
            if V[i] < V[i-1] then
                begin
                GotoXY(1,Y);
                ClrEol;
                TextColor(red);
                Write('Error -> Se esperaba N° >= ',V[i-1]:0:1,' | TRY AGAIN ');
                TextColor(white);
                ReadLn;
                end;
        until (V[i] >= V[i-1]);

        { Guardar la primera vez que se repite un número }
        if (V[i] = V[i-1]) and (i < PriRep) then
            PriRep := i;

        { Generar vector de números no repetidos; los repetidos = 0 }
        if (V[i] <> V[i-1]) then
            begin
            j := j + 1;
            vNoRep[j] := i;
            end
        else    
            begin
            j := j + 1;
            vNoRep[j] := 0;
            Cont0 := Cont0 + 1;
            end
        end; {for}

end; {procedure}


{---------------------------------------------------------------------------------------------}
procedure MostrarVector
    (
        V : TV_50_Real;
        N : byte
    );

var
    i : byte;

begin
    for i:=1 to N do
        { Si el n° No tiene decimales => No se muestran (estamos con reales) }
        if V[i] = Trunc(V[i]) then
            write(V[i]:0:0,'  ')
        else
            write(V[i]:0:1,'  ');

end; {procedure}


{---------------------------------------------------------------------------------------------}
procedure EliminarRepeticiones
    (
        var V       : TV_50_Real;
        var N       : byte;
        PriRep      : byte;
        var vNoRep  : TV_50_Real;
        Cont0       : byte
    );

var
    i : byte;
    j : byte;

begin
    j := PriRep;

    { cuando PriRep > N no se ejecuta | Por ende el vector "Vector" quedará como entró }
    for i:=PriRep to N do           
        if vNoRep[i] <> 0 then
            begin
            V[j] := V[i];
            j := j + 1;
            end;

    { Nuevo valor de N | si PriRep fue > N , el Cont0 fue cero -> N queda como entró }
    N := N - Cont0;


end; {procedure}        


{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    Vector    : TV_50_Real;
    N         : byte;
    PriRep    : byte;

    vNoRep  : TV_50_Real;
    Cont0   : byte;

    S         : char;
    
begin
    repeat
        Titulo;
        LeerVectorAndPriRep(Vector,N,PriRep,vNoRep,Cont0);

        Titulo;
        Write('Vector Ingresado        : [  ');
        MostrarVector(Vector,N);
        WriteLn(']');

        Separador;
        
        EliminarRepeticiones(Vector,N,PriRep,vNoRep,Cont0);
        WriteLn;
        Write('Vector Sin Repeticiones : [  ');
        MostrarVector(Vector,N);
        WriteLn(']');
        
        Separador;
        
        TextColor(red);
        Write('Enter -> Intentar otro Vector | S -> Salir ');
        TextColor(white);
        S := ReadKey;
        S := UpCase(S);

    until (S = 'S');
end.