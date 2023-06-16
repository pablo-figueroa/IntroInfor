(*

    Se tiene en un archivo 'Pacientes.TXT' -> 'T8_Ex01.txt'
    los siguientes datos: Nombre, edad, peso y altura.

    Se pide leer la información, calcular e informar:
        a) El nombre del paciente más joven,
        b) Promedio de altura,
        c) Generar un arreglo con los Nombres y edades
        de los pacientes con peso Normal (IMC=Peso/Altura2)
        El peso se considera Normal si 18.5 <= IMC < 25 

*)

program T8_Ex01;

uses crt;

type
    tNombre = string[7];
    tEdad   = 15..80;
    
    TR = record
        Nombre : tNombre;
        Edad   : tEdad;
        Peso   : real;
        Altura : real;
        end;

    TR_2 = record
        Nombre : tNombre;
        Edad   : tEdad;
        end;
    
    TV = array[1..100] of TR;

    

{-----------------------------------------------------------------------------}
procedure Separador();

var i : byte;

begin
    for i:=1 to 50 do
        write('-');
    WriteLn;
end;

{-----------------------------------------------------------------------------}
procedure LeeArchGenVector(
    var Pacientes : TV;
    var N         : byte
);

var
    arch : text;

begin
    Assign(arch, 'T8_Ex01.txt');
    Reset(arch);
    
    N := 0;
    while not eof(arch) do
        begin
        N := N + 1;
        with Pacientes[N] do
            begin
            ReadLn(arch, Nombre);
            Read(arch, Edad, Peso, Altura);
            end;
        ReadLn(arch);
        end;
    Close(arch);
end;


{-----------------------------------------------------------------------------}
procedure VerRegistro(
    Pacientes : TV;
    N         : byte
);

var i : byte;

begin
    for i:=1 to N do
        with Pacientes[i] do
            begin
            WriteLn('Nombre  : ',Nombre);
            WriteLn(' Edad   : ',Edad);
            WriteLn(' Peso   : ',Peso:0:0);
            WriteLn(' Altura : ',Altura:0:2);
            WriteLn;
            end;
end;

{-----------------------------------------------------------------------------}
{ EJERCICIO a) El nombre del paciente más joven }
function NombreJoven(
    Pacientes : TV;
    N         : byte
):tNombre;

var 
    i       : byte;
    MinEdad : tEdad; { Edad Menor }
    PosName : byte;  { Posición del Nombre}

begin
    MinEdad := Pacientes[1].Edad;
    for i:=2 to N do
        with Pacientes[i] do
            if Edad < MinEdad then
                begin
                MinEdad := Edad;
                PosName := i;
                end;
    NombreJoven := Pacientes[PosName].Nombre;
end;

{-----------------------------------------------------------------------------}
{ EJERCICIO b) Promedio de altura }
function PromAltura(
    Pacientes : TV;
    N         : byte
):real;

var
    i    : byte;
    Suma : real;

begin
    Suma := 0;    
    for i:=1 to N do
        with Pacientes[i] do
            Suma := Suma + Altura;
    
    PromAltura := (Suma / N) * 100; { Porque quiero la Altura en cm. }

end;


{-----------------------------------------------------------------------------}
{ EJERCICIO c) ARRAY con Nombres y edades de los pacientes con peso Normal }

{ Función secundaria ---------------------------}
function VerificaNormal(
    Pacientes : TV;
    i         : byte
):boolean;

var
    IMC : real;

begin
    VerificaNormal := FALSE;
    IMC := Pacientes[i].Peso / sqr(Pacientes[i].Altura);
    
    if (IMC >= 18.5) and (IMC < 25) then
        VerificaNormal := TRUE;
end;

{ Procedimiento Principal ----------------------}
procedure GenPacPesoNor(
    Pacientes : TV;
    N         : byte;
    var PacPesoNor : TV;
    var M          : byte
);

var i : byte;

begin
    M := 0;
    for i:=1 to N do
        if VerificaNormal(Pacientes, i) = TRUE then
            begin
            M := M + 1;
            with PacPesoNor[M] do
                begin
                Nombre := Pacientes[i].Nombre;
                Edad   := Pacientes[i].Edad;
                end;
            end; {if}
end;

{-----------------------------------------------------------------------------}
procedure MostrarPacPesoNor(
    PacPesoNor : TV;
    M          : byte
);

var
    i : byte;
    w : byte;

begin
    for i:=1 to M do
        with PacPesoNor[i] do
            begin
            write(' ',Nombre);
            
            for w:=1 to 7 - length(Nombre) do
                write(' ');
            
            writeLn(' : ',Edad);
            writeLn;
            end;
end;


{-----------------------------------------------------------------------------}
{ PROGRAMA PRINCIPAL }

var
    Pacientes  : TV;
    N          : byte;

    PacPesoNor : TV;
    M          : byte;

begin
    ClrScr;
    LeeArchGenVector(Pacientes, N);

    { MOSTRAR EL REGISTRO }
    Separador;
    WriteLn('Registro Generado:');
    Separador;
    VerRegistro(Pacientes, N);
    Separador;
    TextColor(red);
    Write('ENTER para seguir... ');
    TextColor(white);
    ReadLn;
    ClrScr;

    { RESPUESTAS A LOS EJERCICIOS }
    Separador;
    { a }
    WriteLn('Nombre del Paciente más joven : ',NombreJoven(Pacientes, N));
    Separador;
    { b }
    WriteLn('Promedio de Altura (cm)       : ',PromAltura(Pacientes, N):0:1);
    Separador;

    { c }
    WriteLn('Nombre y Edad de los que tienen Peso Normal: ');
    WriteLn;
    GenPacPesoNor(Pacientes, N, PacPesoNor, M);
    MostrarPacPesoNor(PacPesoNor, M);
    Separador;

end.