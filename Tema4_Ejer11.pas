// TEMA 4
// EJERCICIO 11.-

// Leer N números enteros,
// calcular el mínimo de los impares y
// la cantidad de repeticiones del mismo
// (¿Cantidad repeticiones de impares o cantidad repeticiones minimo impar.)

// JUEGO DE DATOS:

program T4Ej11;

{$codepage UTF8}

uses crt;

var

  Num         : int16; { Número Entero con signo: 2^16 / 2 }
  MinImpar    : int16;
  NumAbs      : word;  { Número Entero sin signo: 2^16     }

  ContImpar   : byte;
  ContMinImpar: byte;

  Res         : char;

begin
repeat
clrscr();

    ContImpar    := 0;
    ContMinImpar := 0;
    MinImpar     := high(int16);

    WriteLn('--------------------------------------');
    Writeln('MUESTRA LOS IMPARES Y SUS REPETICIONES');
    WriteLn('--------------------------------------');
    WriteLn();

    repeat
        Write('Agregar Número? (S | N): ');
        Readln(Res);
        Res := UpCase(Res);
    until (Res = 'S') or (Res = 'N');

    while Res = 'S' do
        begin
        TextColor(yellow);
        Write('  Ingrese un Número Entero: ');
        Readln(Num);
        TextColor(white);
        Writeln();
        NumAbs := abs(Num);

        if NumAbs mod 2 = 1 then
            begin
            ContImpar := ContImpar +1;

            if Num = MinImpar then
                ContMinImpar := ContMinImpar + 1
            else
                if Num < MinImpar then
                    begin
                    ContMinImpar := 0;
                    MinImpar := Num;
                    end;
            end;
        repeat
            Write('Agregar Número? (S | N): ');
            Readln(Res);
            Res := UpCase(Res);
        until (Res = 'S') or (Res = 'N');
        end;

    WriteLn();
    WriteLn('--------------------------------------');
    WriteLn();
    Writeln('Cantidad de Impares         : ', ContImpar           :3);
    if (MinImpar <> high(MinImpar)) then
        begin
        Writeln('Mínimo Impar Ingresado      : ', MinImpar        :3);
        Writeln('Veces que aparece el Mínimo : ', (ContMinImpar+1):3);
        end;

    readln();
until FALSE;
end.