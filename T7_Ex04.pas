(*
EJERCICIO 4

Se han registrado las ventas mensuales de cada uno de N empleados en el último semestre. 
Cada mes se ha establecido un objetivo de importe de ventas a cumplir. 

Se pide leer la información en una matriz de 6x N real y un vector de 6 elementos reales, 
luego calcular e informar:

    a. Cuantos fueron los meses en los cuales todos los empleados superaron el objetivo
    b. Dado un número de empleado (1..N) cuantos meses no cumplió el objetivo

    
    Leer de una matriz 6xN
      Hacer la traspuesta
    
    Matriz Nx6
      N:filas:empleados
      M:col:meses

    vector[1..6] objetivos mensuales

    EJEMPLO:

    Archivo/Matriz de entrada: (6xN {N=3})
    
    4 -> indica la cantidad de columnas
    12 4900.00	5000.00 5100.00
    1  4600.00	4700.00 4800.00
    2  4500.00	4600.00 4700.00
    3  4400.00	4500.00 4600.00
    4  4300.00	4400.00 4500.00
    5  4200.00	4300.00 4400.00

            Primera Columna indica el Mes
            Segunda Columna indica Empleado 1
            Tercera Columna indica Empleado 2
            M       Columna indica Empleado M-1

    Matriz Traspuesta: (3x6)
  |       Dic      Ene      Feb      Mar      Abr      May  |
  |   4900.00  4600.00  4500.00  4400.00  4300.00  4200.00  |
  |   5000.00  4700.00  4600.00  4500.00  4400.00  4300.00  |
  |   5100.00  4800.00  4700.00  4600.00  4500.00  4400.00  |

Objetivos Mensuales: 
  |   4999.00  4500.00  4450.00  4450.00  4450.00  4500.00  |
    
    a. Cuantos fueron los meses en los cuales todos los empleados superaron el objetivo
    Meses -> 2

    b. Dado un número de empleado (1..N) cuantos meses no cumplió el objetivo
    E1 -> 4
    E2 -> 2
    E3 -> 1
    
*)

program T7_Ex02;

//{$codepage UTF8}

uses crt, SysUtils;

type
    TM = array[1..10,1..10] of real;
    TV = array[1..6] of real; { Objetivos }
    TVStr = array[1..12] of String[3]; { Objetivos }

const
    N : byte = 6;
    Meses : TVStr = ('Ene', 'Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic');
{---------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('-------------------------------------------------------------');
    WriteLn;
end;{procedure}


{---------------------------------------------------------------------------------------}
procedure LeerMatriz (
    var Mat : TM;
    var Vec : TV;
    N       : byte;
    var M   : byte
);

var
    i : byte;
    j : byte;
    arch : text;

begin
    Assign(arch, 'T7_Ex04.txt');
    Reset(arch);
    ReadLn(arch, M);
    
    for i:=1 to N do
        begin
        for j:=1 to M do
            read(arch, Mat[i,j]);
        ReadLn(arch);
        end;
    Close(arch);
end;


{---------------------------------------------------------------------------------------}
procedure MostrarMatriz (
    Mat : TM;
    N   : byte;
    M   : byte
);

var
    i : byte;
    j : byte;
    aux : byte;

begin
    for i:=1 to N do
        begin
        write('  | ');
        for j:=1 to M do
            if j = 1 then
                begin
                aux := Round(Mat[i,j]);
                Write(Meses[aux]);
                end
            else    
                write(Mat[i,j]:9:2);
        WriteLn('  |');
        end;
end;


{---------------------------------------------------------------------------------------}
procedure LeerVector (
    var V : TV;
    N     : byte
);

var
    i : byte;
    arch : text;

begin
    Assign(arch, 'T7_Ex04_Objetivos.txt');
    Reset(arch);
    for i:=1 to N do
        read(arch, V[i]);
    Close(arch);
end;


{---------------------------------------------------------------------------------------}
procedure MostrarVector (
    V : TV;
    N : byte
);

var
    i : byte;

begin
    write('  | ');
    for i:=1 to N do
        write(V[i]:9:2);
    WriteLn('  |');    
end;


{---------------------------------------------------------------------------------------}
procedure MatrizTraspuesta (
    Mat      : TM;
    N        : byte;
    M        : byte;
    var MatT : TM
    
);

var
    i,j : byte;
    k,l : byte;

begin
    l := 0;
    for i:=1 to N do
        begin
        l := l +1;
        k := 0;
        for j:=1 to M do
            begin
            k := k + 1;
            MatT[k,l] := Mat[i,j];
            end;
        end;
end;

{---------------------------------------------------------------------------------------}
procedure MostrarMatrizTrasp (
    MatT : TM;
    N   : byte;
    M   : byte
);

var
    i : byte;
    j : byte;
    aux : byte;

begin
    for i:=1 to N do
        begin
        write('  | ');
        for j:=1 to M do
            if i = 1 then
                begin
                aux := Round(MatT[i,j]);
                Write(Meses[aux]:9);
                end
            else    
                write(MatT[i,j]:9:2);
        WriteLn('  |');
        end;
end;


{---------------------------------------------------------------------------------------}
{ a. Cuantos fueron los meses en los cuales todos los empleados superaron el objetivo }
function MesesGetObj (
    MatT : TM;
    N    : byte;
    M    : byte;
    V    : TV
):byte;

var
    i,j : byte;
    Supera : byte; { Supera el Objetivo }
    TodosS : byte; { Todos superan el objetivo }

begin
    TodosS := 0;
    for j:=1 to N do
        begin
        Supera := 0;
        for i:=2 to M do
            
            begin

            if MatT[i,j] > V[j] then
                Supera := Supera + 1;
            { Ver que sucede... }
            (* Writeln('i: ',i,' j: ',j,' MatT: ',MatT[i,j]:0:2,' | j: ',j,' Vec: ',V[j]:0:2,' | Supera = ',Supera); *)
            end;
          
        if (Supera = (M-1)) then
            TodosS := TodosS + 1;
        { Ver que sucede... }
        (* WriteLn('Supera: ',Supera,' | TodosS = ',TodosS);
        WriteLn; *)
        
        end;
    MesesGetObj := TodosS;    
end;


{---------------------------------------------------------------------------------------}
{ b. Dado un número de empleado (1..N) cuantos meses no cumplió el objetivo }
function EmpNotGetObj (
    MatT : TM;
    N    : byte;
    M    : byte;
    V    : TV;
    NumE : byte
):byte;

var
    j : byte;
    Supera : byte; { Supera el Objetivo }

begin
    NumE := NumE + 1;
    Supera := 0;
    for j:=1 to N do
        begin
        if MatT[NumE,j] > V[j] then
            Supera := Supera + 1;    
        
        { Ver que sucede... }
        (* WriteLn('NumE: ',NumE,' j: ',j,' MatT: ',MatT[NumE,j]:0:2,' VS V[j]: ', V[j]:0:2,' | Supera = ',Supera); *)
        
        end;
    EmpNotGetObj := N - Supera;
end;


{---------------------------------------------------------------------------------------}
{PROGRAMA PRINCIPAL}
var
    Mat  : TM;
    MatT : TM;
    Vec  : TV;
    M    : byte;

    Vector : TV;
    
    MesesObj : byte;
    NumE     : byte;
    EmpNoObj : byte;

begin
    LeerMatriz(Mat, Vec, N, M);
    ClrScr;

    WriteLn('Registro de Ventas: ');
    Writeln;
    WriteLn('  Fila -> Mes | Columna -> Venta');
    Writeln;
    MostrarMatriz(Mat, N, M);

    Separador;

    MatrizTraspuesta(Mat, N, M, MatT);
    MostrarMatrizTrasp(MatT, M, N);

    LeerVector(Vector, N);
    Writeln;
    WriteLn('Objetivos Mensuales: ');
    
    MostrarVector(Vector, N);
    
    Separador;

    MesesObj := MesesGetObj(MatT,N,M,Vector);
    WriteLn('Meses que todos alcanzaron el objetivo: ',MesesObj);

    Separador;

    repeat
        Write('Ingrese un número de empleado (1..',M-1,'): ');
        ReadLn(NumE);
    until (NumE >= 1) and (NumE <= M-1);

    EmpNoObj := EmpNotGetObj(MatT,N,M,Vector,NumE);
    WriteLn;
    WriteLn('Cantidad de Meses que NO cumplió el objetivo: ',EmpNoObj);

    Separador;

    Write('FIN ');
    ReadLn;

end.