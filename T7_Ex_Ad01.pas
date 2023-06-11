(*

TEMA 7 - ADICIONAL 1.

Leer dos matrices MatColor de caracteres y MatCant de enteros, ambas de NxN.

Dichas matrices representan un tablero con fichas rojas, azules y verdes (‘R’, ‘A’ y ‘V’).

En cada casillero puede haber solamente fichas (1 o más) de un solo color, por lo tanto la
matriz MatCant indica esa cantidad.

Determinar e informar:

    a) Cuántas columnas contienen todos los colores.

    b) Para un color dado (ingresado por teclado), generar un arreglo paralelo a las filas
    con el total de fichas de dicho color, mostrar dicha cantidad y el % que representa
    sobre el total del color
        Nota: Creo que pide:
                Un Vector fila de la suma de las fichas por columna s/ color.


Ejemplo: N=4
               A R R V                    1  7  4  3
    Mat Color= R V R V         MatCant =  2  2  5  6
               R V A A                    2  8  5 20
               V R A R                   10  8 10  9

    Supongo que el b) pide:
        Se ingresa por teclado: "R"
                                Vector    4 15  7  9
                                Total R: 35
                                Total %:  11.43%  42.86%  20.00%  25.71%
 *)

 program T7_Ex_Ad01.pas;

 //{$codepage UTF8}

 uses crt;

 type
    TM_C = array[1..10,1..10] of char;
    TM_B = array[1..10,1..10] of byte;
    TV_B = array[1..10]       of byte;

{---------------------------------------------}
{ SEPARADOR }
procedure Separador();

var
    i : byte;

begin
    WriteLn;
    for i:=1 to 45 do
        write('-');
    WriteLn;
    WriteLn;
end;


{---------------------------------------------}
{ DETERMINAR LA DIMENSION DE LA MATRIZ }
{ Con una matriz basta porque ambas tienen la misma dimensión }
procedure Dimension (
    var N : byte
);

var
    arch : text;

begin
    N := 0;
    Assign(arch, 'T7_Ex_Ad01_fColor.txt');
    Reset(arch);
    while not eof(arch) do
        begin
        N := N + 1;
        ReadLn(arch);
        end;
    Close(arch);
end;


{---------------------------------------------}
{ LEER ARCHIVOS Y GENERAR MATRICES }
procedure LeeArchGenMat(
    var Mat1 : TM_C;
    var Mat2 : TM_B;
    N        : byte
);

var
    i,j  : byte;
    aux  : char;
    arch1 : text;
    arch2 : text;

begin
    Assign(arch1, 'T7_Ex_Ad01_fColor.txt');
    Reset(arch1);

    Assign(arch2, 'T7_Ex_Ad01_fCant.txt');
    Reset(arch2);

    while not eof(arch1) do         { porque ambos son de igual dimensión }
        for i:=1 to N do
            begin
            for j:=1 to N do
                begin

                { ATENCIÓN !!! }
                { Usar este código: }
                { Por el posible no espacio en blanco al final de cada i }
                if j < N then
                    read(arch1, Mat1[i,j],aux)
                else
                    read(arch1, Mat1[i,j]);

                read(arch2, Mat2[i,j]);
                end;
            readln(arch1);
            readln(arch2);
            end;
    Close(arch1);
    Close(arch2);
end;


{---------------------------------------------}
{ MOSTRAR LA MATRIZ DE QUE INDICA COLOR FICHA }
procedure MostrarMatrizColor(
    Mat1 : TM_C;
    N    : byte
);

var
    i,j : byte;

begin
    for i:=1 to N do
        begin
        write(' |');
        for j:=1 to N do
            if Mat1[i,j] = 'R' then
                begin
                TextColor(red);
                write(Mat1[i,j]:3);
                end
            else
                if Mat1[i,j] = 'A' then
                    begin
                    TextColor(blue);
                    write(Mat1[i,j]:3);
                    end
                else
                    begin
                    TextColor(green);
                    write(Mat1[i,j]:3);
                    end;
        TextColor(white);
        write('|':3);
        WriteLn;
        end; {for i}
end; {procedure}


{---------------------------------------------}
{ MOSTRAR LA MATRIZ DE QUE INDICA CANTIDAD FICHA }
procedure MostrarMatrizCant(
    Mat2 : TM_B;
    N    : byte;
    Mat1 : TM_C
);

var
    i,j : byte;

begin
    for i:=1 to N do
        begin
        write(' |');
        for j:=1 to N do
            if Mat1[i,j] = 'R' then
                begin
                TextColor(red);
                write(Mat2[i,j]:3);
                end
            else
                if Mat1[i,j] = 'A' then
                    begin
                    TextColor(blue);
                    write(Mat2[i,j]:3);
                    end
                else
                    begin
                    TextColor(green);
                    write(Mat2[i,j]:3);
                    end;
        TextColor(white);
        write('|':3);
        WriteLn;
        end; {for i}
end; {procedure}


{---------------------------------------------}
{ CANTIDAD DE COLUMNAS DEL MISMO COLOR }
{ Función Secundaria : Verifica si x columna es del mismo color }
function VerificaFullColor(
    Mat1 : TM_C;
    N    : byte;
    Col  : byte
):boolean;

var
    row : byte;
    Aux : byte;

begin
    VerificaFullColor := False;
    Aux := 0;
    row := 1;
    while (row < N) and (Mat1[row+1,col] = Mat1[row,col]) do
        begin
        row := row + 1;
        Aux := Aux + 1;
        end;
    if Aux = N-1 then
        VerificaFullColor := True;
end;


{---------------------------------------------}
{ CANTIDAD DE COLUMNAS DEL MISMO COLOR }
{ Función Primaria : Devuelve al MAIN cantidad de col del mismo color  }
function CantFullColor(
    Mat1 : TM_C;
    N    : byte
):byte;

var
    col : byte;
    Aux : byte;

begin
    Aux := 0;
    for col:=1 to N do
        if VerificaFullColor(Mat1, N, col) = True then
            Aux := Aux + 1;
    CantFullColor := Aux;
end;


{---------------------------------------------}
{ Generar Vector Fila }
procedure GenVec(
    Mat1  : TM_C;
    Mat2  : TM_B;
    N     : byte;
    Color : char;
    var Vec : TV_B
);

var
    i,j : byte;
    Aux : byte;

begin

    for j:=1 to N do
        begin
        Aux := 0;
        for i:=1 to N do
            begin
            if Mat1[i,j] = Color then
                Aux := Aux + Mat2[i,j];
            end;
        Vec[j] := Aux;
        end;
end;


{---------------------------------------------}
{ Mostrar el Vector Generado }
procedure MostrarVec(
    Vec : TV_B;
    N   : byte
);

var i : byte;

begin
    Write('|');
    for i:=1 to N do
        Write(Vec[i]:3);
    WriteLn('|':3);
end;


{---------------------------------------------}
procedure ClrYY(
    Y1 : byte;
    Y2 : byte
);

var y : byte;

begin
    for y:=(Y2) downto Y1 do
        begin
        gotoxy(1,y);
        ClrEOL;
        end;
end;


{---------------------------------------------}
{ TOTAL VECTOR = TOTAL DEL COLOR }
function TotalVector(
    Vec : TV_B;
    N   : byte
):byte;

var
    i   : byte;
    Aux : byte;

begin
    Aux := 0;
    for i:=1 to N do
        Aux := Aux + Vec[i];
    TotalVector := Aux;
end;


{---------------------------------------------}
{ MOSTRAR LOS PORCENTAJES }
procedure MostrarPorcentajes(
    Vec    : TV_B;
    N      : byte;
    TotVec : byte
);

var
    i : byte;

begin
    for i:=1 to N do
        writeLn(' ',Vec[i]:2,' -> ',((Vec[i]/TotVec)*100):5:2,'%');
end;



{---------------------------------------------}
{ PROGRAMA PRINCIPAL }
var
    Mat1 : TM_C;
    Mat2 : TM_B;
    N    : byte;
    Vec  : TV_B;

    Color    : char;
    TotalVec : byte;

    Y1 : byte;
    Y2 : byte;
    Q  : char;

begin

    ClrScr;
    { Determinar tamaño de la Matriz }
    Dimension(N);

    { Leer Archivos y Generar Matrices }
    LeeArchGenMat(Mat1, Mat2, N);

    { Mostrar Matrices }
    WriteLn('Matriz de Colores:');
    MostrarMatrizColor(Mat1, N);
    WriteLn;

    WriteLn('Matriz de Cantidades:');
    MostrarMatrizCant(Mat2, N, Mat1);

    Separador;

    Writeln('Cantidad de columnas del mismo color: ',CantFullColor(Mat1, N));

    Separador;
    Write('ENTER para limpiar esta pantalla e ir a la siguente... ');
    ReadLn;
    ClrScr;

    Y1 := WhereY;

    repeat
        repeat
            gotoxy(1,Y1);
            ClrEOL;
            TextColor(yellow);
            Write('Ingrese un color {R, A, V} : ');
            ReadLn(Color);
            Color := UpCase(Color);
        until (Color = 'R') or (Color = 'A') or (Color = 'V');

        { Generar Vector Fila }
        GenVec(Mat1, Mat2, N, Color, Vec);

        { Mostrar el Vector Generado }

        if Color = 'R' then
            TextColor(red)
        else
            if Color = 'A' then
                TextColor(blue)
            else
                TextColor(green);

        gotoxy(1,Y1);
        ClrEOL;
        Write('Vector -> ');
        MostrarVec(Vec, N);
        TotalVec := TotalVector(Vec, N);
        WriteLn('Total Vector = ', TotalVec);
        WriteLn;
        WriteLn('Porcentajes:');

        if TotalVec <> 0 then
            MostrarPorcentajes(Vec, N, TotalVec)
        else
            Writeln('No es posible calcular para este color, :-(');


        TextColor(white);

        Separador;

        TextColor(magenta);
        Write('ENTER para otro color | q para Finalizar : ');
        TextColor(white);
        read(Q);
        Y2 := WhereY;
        Q := UpCase(Q);
        if Q <> 'Q' then
            ClrYY(Y1,Y2);
    until Q = 'Q';
    ReadLn;
    Separador;

    Write('F I N . . .  ');
    ReadLn;
end.