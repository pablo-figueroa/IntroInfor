// TEMA 4
// EJERCICIO 10.-

// Leer un número, calcular e informar la suma de los números naturales hasta ese número.

// JUEGO DE DATOS:

program T4Ej10;

{$codepage UTF8}

uses crt, SysUtils;
var
  N    : longWord; { número sin signo de 32 bits }
  Suma : real;

begin
repeat
clrscr();
    WriteLn('---------------------------------');
    WriteLn('Suma de Números Naturales hasta N');
    WriteLn('---------------------------------');
    WriteLn();

    repeat
        Write('Ingrese un número Natural (hasta ', high(N),'): ');
        ReadLn(N);
    until (N > 0);

    Suma := ((N / 2) * (N + 1));

    WriteLn();

    Write('La suma desde 1 hasta ', FormatFloat('#,##0',N),' es de: ');
    TextColor(cyan);
    WriteLn(FormatFloat('#,##0',Suma));

    WriteLn();
    TextColor(green);
    Write('ENTER para reiniciar...');
    TextColor(white);
    readln();
until FALSE;
end.