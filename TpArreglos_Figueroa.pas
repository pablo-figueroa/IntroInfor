(*      // = Corrección del profesor/a      *)
(*      {} = Mis comentarios                *)

program TP_Arreglos; { EJEMPLOS Y ENUNCIADO AL FINAL, en ese orden. }

type
    TV_50_Int = array[1..50] of integer;

{-----------------------------------------------------------------------------}
procedure LeerVector (var V: TV_50_Int; var N: byte);
var 
    i    : byte; // i: variable innecesaria. Usar N { ENTENDIDO }
    Arch : text;
begin
    Assign(Arch, 'Datos.txt');
    Reset(Arch);
    i := 0;
    while not eof(Arch) do
        begin
        i := i + 1;
        Readln(arch, V[i]);
        end;{while}
    N := i;
    Close(Arch);
end;{procedure}
{-----------------------------------------------------------------------------}
procedure MostrarVector(V: TV_50_Int; N: byte);
var i : byte;
begin
    for i:=1 to N do
        write(V[i],'  ');
end;{procedure}
{-----------------------------------------------------------------------------}
function CalcularMaximo(V: TV_50_Int; N: byte):integer;
var 
    i   : byte;
    Max : integer;
begin
    Max := -9999; //La otra opción es inicializar el maximo en el primer elemento del vector { Max := V[1] }
    for i:=1 to N do
        if V[i] > Max then
            Max := V[i];
    CalcularMaximo := Max;
end;{function}
{-----------------------------------------------------------------------------}
procedure GenerarArreglo_B(VA: TV_50_Int; Max: integer; var VB: TV_50_Int; var N: byte);
//Se utiliza el mismo límite N para las dos estructuras. Se debe utilizar otra variable, M por ej. Sino, se pierde la dimensión de VA, importante! { ENTENDIDO }
var
    i,j : byte;
begin
    j := 0;
    for i:=1 to N do
        if (VA[i] <> 0) and (Max mod VA[i] = 0) then { La div. por 0 es una indeterminación }
        (* if (Max mod VA[i] = 0) then  *)
        //Ok, pero el mod devolverá false. Primer condición lógica no es necesaria.
        { Si VA[i] = 0 -> "Max mod 0 = 0" no retorna false. Genera Runtime Error. }
        { Primera condición lógica necesaria } { La div. por 0 no está definida. }
        
            begin
            j := j + 1;
            VB[j] := VA[i];
            end;
    N := j;
end; {procedure}
{-----------------------------------------------------------------------------}
function CalcularPromedio(VB: TV_50_Int; N: byte):real;
var 
    i    : byte;
    Acum : integer;
begin
    Acum := 0;
    for i:=1 to N do
        Acum := Acum + VB[i];

    CalcularPromedio := Acum / N
    
    //Y si no hay divisores? Como mencionaste antes, la división por cero es una indeterminación. If else para verificar que no ocurra 
    
    { Sí correcto al if else PERO no ACÁ, sí en el MAIN - LINEA 123 }
    { Siempre(*) va a existir un divisor, todo número es divisible por sí mismo }
    { (*)Salvo que A = (0) -> B = ∅ -> N = 0 | PERO desde el MAIN no se llama a la FUNCTION, dado el if else. }
    { El promedio no está definido para cero elementos }

end; {function}
{-----------------------------------------------------------------------------}
{ PROGRAMA PRINCIPAL }
var
    V_Arreglo_A, V_Arreglo_B : TV_50_Int;
    N   : byte;
    Max : integer;

begin
    WriteLn('-------------');
    WriteLn('TP - ARREGLOS');
    WriteLn('-------------');
    Writeln;

    { Lectura del archivo y generación del Arreglo A}
    LeerVector(V_Arreglo_A, N);

    if N > 0 then
        begin
        { Mostrar el Arreglo A }
        Write('A = (  ');
        MostrarVector(V_Arreglo_A, N); 
        WriteLn(')');
        WriteLn;
    
        { Calcular y Mostrar el Máximo del Arreglo A }
        Max := CalcularMaximo(V_Arreglo_A, N);
        WriteLn('Maximo: ',Max);
        WriteLn;
    
        { Generar y Mostrar el Arreglo B }
        GenerarArreglo_B(V_Arreglo_A, Max, V_Arreglo_B, N);
        Write('B = (  ');
        MostrarVector(V_Arreglo_B, N);
        WriteLn(')');
        WriteLn;
    
        { Calcular y Mostrar el promedio del Arreglo B }
        { Corregido por mi } { Viene de LINEA 79 }
        if N > 0 then { significa que: B ≠ ∅ }{ Por lo puedo calcular promedio }
            WriteLn('Promedio: ',CalcularPromedio(V_Arreglo_B, N):0:2,'. | FIN |')
        else
            WriteLn('B está vacío. NO ES POSIBLE CALCULAR PROMEDIO. | FIN |');
        end
    else    
        WriteLn('El archivo está vacío. | FIN |');
        
    ReadLn;
end.

//Bien modularizado
//Reutilización de N para ambas estructuras, chequear que esto no ocurra { ENTENDIDO }
//No se valida posible indeterminación { Chequeado, validado antes de llamar a la función en el MAIN }
//Bien indentado
//Nombres representativos y correcto pasaje de parámetros (en lo que respecta a valor y referencia)

(*

EJEMPLO 1:
    A = (  17  1  2  3  4  5  6  7  8  9  ) 
    Maximo: 17
    B = (  17  1  )
    Promedio: 9.00

EJEMPLO 2: un cero en el archivo:
    A = (  0  25  -5  -1  2  1  5  )
    Maximo: 25
    B = (  25  -5  -1  1  5  )
    Promedio: 5.00

EJEMPLO 3: el cero como máximo:
    A = (  0  -1  -2  -3  -4  -5  )
    Maximo: 0
    B = (  -1  -2  -3  -4  -5  )
    Promedio: -3.00

---------------------------------------------------------------------
{ Nuevos Ejemplos }
EJEMPLO 4: archivo vacío -> nada que hacer.
    El archivo está vacío. | FIN |

EJEMPLO 5: archivo no vacío -> O bien contiene un cero, o bien solo contiene varios ceros.
    A = (  0  )    ó     A = (  0  0  0  0  )
    Maximo: 0
    B = (  )
    B está vacío. NO ES POSIBLE CALCULAR PROMEDIO. | FIN |

EJEMPLO 6:
    A = (  0  2  3  7  )
    Maximo: 7
    B = (  7  )
    Promedio: 7.00. | FIN |
    
*)

(*

TP (Trabajo Practico) : Arreglos

Se debe entregar:
    ➢ Programa en Pascal (.PAS)

Ejercicio:
    Dado un archivo de enteros, 
    leerlos en un arreglo A, 
    obtener el promedio de todos los números divisores del máximo y 
    con ellos armar otro arreglo B.

    Mostrar ambos arreglos (A y B), el máximo y el promedio.

    Ejemplo:
    A = (5, 7, 1, 12, 15, -8, 10, 2, 25, 26, 50, 13)
    Máximo = 50                 { Máximo de los elementos de A }
    B = ( 5, 1, 10, 2, 25, 50 ) { B = Elementos de A que son divisores del máximo elemento de A}
    Promedio = 15.5             { Promedio de los elementos de B }

    NOTA: Resolver el enunciado haciendo un programa eficaz, eficiente y
          correctamente indentado, modularizado y parametrizado.

Datos.txt ORIGINALES:

5
7
1
12
15
-8
10
2
25
26
50
13

*)