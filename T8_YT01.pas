(*

https://www.youtube.com/watch?v=WW-EVVy3rDo

Leer de un archivo:
    El primer valor es una cadena de texto con el nombre del alumno. Longitud no mayor a 15.
    A continuación 9 números con decimales entre 0 y 10.

Mostrar:
    El nombre del alumno/s con la nota promedio más alta.
    La nota.

Ejemplo del archivo:
Juan Perez
    8.25 6.00 7.50 4.75 9.75 5.25 2.50 3.75 6.00
    Maria Garcia
    9.25 2.00 5.25 8.75 6.25 7.25 4.50 3.75 1.25
    ...
    ...

*)
{-----------------------------------------------------------------------------}
program AlumnoPromedio;

uses crt;

type
    Str15 = string[15];
    TV_Notas = array[1..9] of real;

    TR = record
        Nombre   : Str15;
        Notas    : TV_Notas;
        Promedio : real;
        end;

    TV = array[1..100] of TR;



{-----------------------------------------------------------------------------}   
procedure LeeArchGenVector(
    var Alumno : TV;
    var N      : byte
);
 
var
    i,j : byte;
    arch : text;
begin
    N := 0;
    Assign(arch, 'T8_YT01.txt');
    Reset(arch);
    while not EOF(arch) do
        begin
        N := N + 1;
        readln(arch, Alumno[N].Nombre);
        for i:= 1 to 9 do
            read(arch, Alumno[N].Notas[i]);
        ReadLn(arch);
        end;
    Close(arch);
    
end;

{-----------------------------------------------------------------------------}
procedure whiteSpace(cantidad:byte);

var i : byte;

begin
    for i:=1 to cantidad do
        write(' ');
end;

{-----------------------------------------------------------------------------}   
procedure MostrarVector(
    Alumno : TV;
    N      : byte
);

var
    i,j : byte;
    len : byte;
    
begin
    for i:=1 to N do
        begin
        Write(' Nombre : ', Alumno[i].Nombre);

        if Alumno[i].Promedio > 0 then
            begin
            len := length(Alumno[i].Nombre);
            whiteSpace(15-len);
            WriteLn(' ( ',Alumno[i].Promedio:0:2,' )');
            end
        else
            begin
            WriteLn;
            Write(' Notas  : ');
            for j:=1 to 9 do
                write(Alumno[i].Notas[j]:0:2,' ');
            WriteLn;
            end;
        
        WriteLn;
        end;
end;

{-----------------------------------------------------------------------------}
procedure CalcularPromedio(
    var Alumno : TV;
    N          : byte
);

var
    i,j  : byte;
    Suma : real;

begin
    
    for i:=1 to N do
    with Alumno[i] do
        begin
        Suma := 0;
        for j:=1 to 9 do
            Suma := Suma + Notas[j];
        Promedio := Suma / 9;
        end;
end;


{-----------------------------------------------------------------------------}
{ PROGRAMA PRINCIPAL }
var
    Alumno : TV;
    N      : byte;

begin
    ClrScr;
    LeeArchGenVector(Alumno, N);
    
    TextColor(yellow);
    WriteLn('Alumno y NOTAS: ');
    TextColor(white);
    WriteLn;
    MostrarVector(Alumno, N);
    Write('ENTER para seguir... ');
    ReadLn;
    ClrScr;

    TextColor(yellow);
    WriteLn('Alumno y PROMEDIO: ');
    TextColor(white);
    WriteLn;
    CalcularPromedio(Alumno, N);
    MostrarVector(Alumno, N);
end.

{
Archivo COMPLETO:
Juan Perez
8.25 6.00 7.50 4.75 9.75 5.25 2.50 3.75 6.00
Maria Garcia
9.25 2.00 5.25 8.75 6.25 7.25 4.50 3.75 1.25
Carlos Lopez
7.25 9.00 6.75 3.75 8.00 4.25 2.50 6.75 9.50
Laura Rodriguez
5.25 3.00 8.25 2.75 7.25 9.25 4.50 6.75 1.25
Jose Martinez
8.25 6.00 9.50 7.75 4.75 5.25 1.50 3.75 2.00
Ana Sanchez
6.25 9.00 3.75 2.75 5.00 8.25 1.50 7.75 4.50
Miguel Torres
4.25 7.00 2.50 9.75 6.75 3.25 8.50 4.75 5.00
Sofia Ramirez
2.25 6.00 9.25 5.75 3.25 2.25 8.50 7.75 4.25
Daniel Herrera
9.25 1.00 3.75 4.75 2.00 6.25 5.50 8.75 7.50
Carolina Castro
6.25 4.00 7.25 1.75 5.25 8.25 3.50 9.75 2.25
Alejandro Diaz
8.25 7.00 4.50 6.75 1.75 5.25 9.50 2.75 3.00
Marta Paredes
2.25 3.00 9.75 8.75 7.00 4.25 1.50 5.75 6.50
Sergio Castro
4.25 5.00 2.50 9.75 6.75 3.25 8.50 7.75 2.00
Paula Ortega
6.45 8.91 9.78 1.23 7.88 2.34 5.67 4.12 3.45
}