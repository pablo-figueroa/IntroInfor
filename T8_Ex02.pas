(*

{ --------------------- T8_Ex02 --------------------- }

De una competencia de atletismo se tienen los siguientes datos del lanzamiento de jabalina:

    - Nombre del competidor (ordenado ascendentemente por este dato)
    - 1º lanzamiento
    - 2º lanzamiento

Se pide:
    a) Cuántos competidores superaron con el 2º lanzamiento el 1º.
    b) Nombre del atleta que registró la mejor marca.
    c) Dado el Nombre de un atleta, informar la marca que realizó en ambos lanzamientos.
    d) Generar un nuevo arreglo con los participantes que pasaron a la semifinal.
    (aquellos que superaron una marca X establecida en el 1º ó 2º lanzamiento).
    Mostrar ambos arreglos.
    
    
    Nota Personal: Asumo que X es la menor de los lanzamientos del primer Atleta. Sino quien lanza primero siempre estará descalificado. Así mismo, siempre pasará a la final. Sería mejor ingresar la Marca X por teclado.

*)

program T8_Ex02;

uses crt, SysUtils;

type
    tNombre = string[10];
    
    TR = record
        Nombre : tNombre;
        Lanz1  : real;
        Lanz2  : real;
        end;
    
    TV = array[1..50] of TR;

    TV_SemiF = array[1..50] of tNombre;
{-----------------------------------------------------------------------------}
procedure Separador();

var i : byte;

begin
    for i:=1 to 65 do
        write('-');
    WriteLn;
end;


{-----------------------------------------------------------------------------}
procedure clearYY(Y1,Y2:byte);
var y : byte;
begin
    for y:=Y2 downto Y1 do
        begin
        gotoxy(1,y);
        clreol;
        end;
end;


{-----------------------------------------------------------------------------}
procedure LeeArchGenVector(
    var Competidores : TV;
    var N            : byte
);

var
    arch : text;

begin
    Assign(arch, 'T8_Ex02.txt');
    Reset(arch);
    
    N := 0;
    while not eof(arch) do
        begin
        N := N + 1;
        with Competidores[N] do
            ReadLn(arch, Nombre, Lanz1, Lanz2);
        end;
    Close(arch);
end;


{-----------------------------------------------------------------------------}
procedure VerRegistro(
    Competidores : TV;
    N            : byte
);

var i : byte;

begin
    for i:=1 to N do
        with Competidores[i] do
            begin
            WriteLn('Nombre         : ',Nombre);
            WriteLn(' Lanzamiento 1 : ',Lanz1:5:2);
            WriteLn(' Lanzamiento 2 : ',Lanz2:5:2);
            WriteLn;
            end;
end;


{-----------------------------------------------------------------------------}
{ EJERCICIO a - Cuántos competidores superaron con el 2º lanzamiento el 1º.}

{ Función Secundaria ---------------------------------- }
function Verifica2doSup1er(
    Competidores : TV;
    i            : byte
):boolean;

begin
    Verifica2doSup1er := FALSE;
    
    with Competidores[i] do
        if Lanz2 > Lanz1 then
            Verifica2doSup1er := TRUE;

end;

{ Función Principal ---------------------------------- }
function Cant2doSup1er(
    Competidores : TV;
    N            : byte
):byte;

var 
    i, cont : byte;

begin
    Cont := 0;
    
    for i:=1 to N do
        with Competidores[i] do
            if Verifica2doSup1er(Competidores, i) = TRUE then
                Cont := Cont + 1;
    
    Cant2doSup1er := Cont;
end;

{-----------------------------------------------------------------------------}
{ EJERCICIO b - Nombre del atleta que registró la mejor marca. }
function NombreMejorMarca(
    Competidores : TV;
    N            : byte
):tNombre;

var
    i, PosMax    : byte;
    LanzMax : real; { Almacena el lanzamiento Maximo del atleta }
    MaxGral : real; { Almacena el lanzamiento Maximo de todos   }

begin
    MaxGral    := 0;
    PosMax := 0;
    
    for i:=1 to N do
        with Competidores[i] do
            begin
            LanzMax := Lanz1;
            
            if Verifica2doSup1er(Competidores, i) = TRUE then
                LanzMax := Lanz2;
            
            if LanzMax > MaxGral then
                begin
                MaxGral := LanzMax;
                PosMax := i;
                end;
            end;
    NombreMejorMarca := Competidores[PosMax].Nombre;
    
end;


{-----------------------------------------------------------------------------}
{ EJERCICIO c - Dado el Nombre, informar la marca que realizó en ambos lanzamientos. }

{ ------------------------------------------------------------ }
procedure MostrarCompetidores(Competidores:TV; N:byte);

var i : byte;

begin
    for i:=1 to N do
        with Competidores[i] do
            begin
            { Cantidad de nombres por línea }
            if i mod 9 = 0 then
                WriteLn;
            { Separa ',' y último '.'}
            if i < N then
                write(Trim(Nombre),', ')
            else
                write(Trim(Nombre),'.');
            end;
    WriteLn;
    
end;

{ ------------------------------------------------------------ }
procedure CheckGetPosName(
    Competidores : TV; 
    N            : byte;
    NombreIn     : tNombre;
    
    var VerificaNombre : boolean;
    var PosNombre      : byte
);

begin
    VerificaNombre := FALSE;
    PosNombre := 1;
    
    while (PosNombre <= N) and (Trim(Competidores[PosNombre].Nombre) <> NombreIn) do
        PosNombre := PosNombre + 1;

    if PosNombre <= N then
        VerificaNombre := TRUE;
    
end;

{ ------------------------------------------------------------ }
procedure MostrarLanzamientos(
    Competidores : TV; 
    N            : byte;
    PosNombre    : byte
);

begin
    with Competidores[PosNombre] do
        begin
        WriteLn('Nombre: ', Nombre);
        WriteLn(' Lanzamiento 1°: ',Lanz1:0:2);
        WriteLn(' Lanzamiento 2°: ',Lanz2:0:2);
        end;
end;


{-----------------------------------------------------------------------------}
{ EJERCICIO d - Generar un nuevo arreglo con los participantes que pasaron a la semifinal. }

{ ------------------------------------------------------------ }
function GenMarcaX(Competidores:TV):real;

begin
    GenMarcaX := Competidores[1].Lanz1;
    
    with Competidores[1] do
        if Lanz2 < Lanz1 then    { ¡¡¡¡¡¡¡ LA MARCA MAYOR O LA MARCA MENOR !!!!!!!! }
            GenMarcaX := Competidores[1].Lanz2;
end;

{ ------------------------------------------------------------ }
procedure GenSemifinalistas(
    Competidores : TV;
    N            : byte;
    MarcaX       : real;
    var SemiFin  : TV_SemiF;
    var M        : byte
);

var
    i : byte;
    
begin
    M   := 0;
    for i:=1 to N do
        with Competidores[i] do
            if (Lanz1 > MarcaX) or (Lanz2 > MarcaX) then
                begin
                M := M + 1;
                SemiFin[M] := Nombre;
                end;
end;

{ ------------------------------------------------------------ }
procedure MostrarSemifinalistas(Semifinalistas:TV_SemiF; M:byte);

var i : byte;

begin
    for i:=1 to M do
        begin
        { Cantidad de nombres por línea }
        if i mod 9 = 0 then
            WriteLn;
        { Separa ',' y último '.'}
        if i < M then
            write(Trim(Semifinalistas[i]),', ')
        else
            write(Trim(Semifinalistas[i]),'.');
        end;
    WriteLn;
end;


{-----------------------------------------------------------------------------}
{ PROGRAMA PRINCIPAL }

var
    Competidores : TV;
    N            : byte;

    NombreIn       : tNombre;
    VerificaNombre : boolean;
    PosNombre      : byte;

    MarcaX         : real;
    Semifinalistas : TV_SemiF;
    M              : byte;

    Y1,Y2 : byte;
    S     : char;

begin
    ClrScr;
    LeeArchGenVector(Competidores, N);

    { MOSTRAR EL REGISTRO }
    Separador;
    WriteLn('Registro Generado:');
    WriteLn;
    VerRegistro(Competidores, N);
    Separador;
    TextColor(red);
    Write('ENTER para seguir... ');
    TextColor(white);
    ReadLn;
    ClrScr;

    { EJERCICIO a - Cuántos competidores superaron con el 2º lanzamiento el 1º. }
    Separador;
    WriteLn(' Cantidad que superaron con el 2º lanzamiento el 1º : ',Cant2doSup1er(Competidores, N));
    Separador;

    { EJERCICIO b - Nombre del atleta que registró la mejor marca. }
    Separador;
    WriteLn(' Nombre del Atleta que registró la mejor marca : ',NombreMejorMarca(Competidores, N));
    Separador;

    { EJERCICIO c - Dado el Nombre, informar la marca que realizó en ambos lanzamientos. }
    Separador;
    WriteLn(' Nombre de los Atletas: ');
    WriteLn;
    MostrarCompetidores(Competidores, N);
    Separador;
    WriteLn;
    Y1 := WhereY;
    
    repeat
        repeat
            Write(' Ingrese Nombre para conocer sus marcas: ');
            ReadLn(NombreIn);
            CheckGetPosName(Competidores, N, NombreIn, VerificaNombre, PosNombre);
            if VerificaNombre = FALSE then
                begin
                TextColor(red);
                write('  Verifique nombre ingresado');
                TextColor(white);
                ReadLn;
                end;
            Y2 := WhereY;
            clearYY(Y1,Y2);
        until VerificaNombre = TRUE;

        WriteLn;
        MostrarLanzamientos(Competidores, N, PosNombre);
        
        Separador;
        Write('ENTER para otro Nombre | S para Continuar... ');
        Read(S);
        S := UpCase(S);
        Y2 := WhereY;
        
        if S <> 'S' then
            clearYY(Y1,Y2);
    
    until S = 'S';
    

    { EJERCICIO d - Generar un nuevo arreglo con los participantes que pasaron a la semifinal. }
    ClrScr;
    Separador;
    WriteLn('ATLETAS QUE PASARON A LA SEMIFINAL');
    WriteLn;
    MarcaX := GenMarcaX(Competidores);
    WriteLn(' Marca X = ',MarcaX:0:2);
    WriteLn;
    
    TextColor(yellow);
    WriteLn(' Nombre de los Competidores: ');
    TextColor(white);
    MostrarCompetidores(Competidores, N);
    WriteLn;

    TextColor(yellow);
    WriteLn(' Nombre de los semifinalistas: ');
    TextColor(white);
    GenSemifinalistas(Competidores, N, MarcaX, Semifinalistas, M);
    MostrarSemifinalistas(Semifinalistas, M);
    WriteLn;

    Separador;
    WriteLn;
    Write('FIN ');
    ReadLn;

end.