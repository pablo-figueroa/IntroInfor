// 4.-Dado un conjunto de números enteros distintos de cero,
// informar el mayor múltiplo de 3.

program T4Ej4;
{$codepage UTF8}
uses crt;
var
    Numero : int32;
    Mayor3 : int32;
begin
repeat
clrscr();
    Mayor3 := low(int32);
    Textcolor(yellow);
    Writeln('NUMERO MAYOR MULTIPLO DE 3');
    WriteLn('Para finalizar la carga de datos: 0');
    Textcolor(white);
    WriteLn();
    Write('Ingresar Número: ');
    ReadLn(Numero);


    if numero = 0 then
        writeln('No ha ingresado ningun valor')
    else
        begin
        While Numero <> 0 do
            begin

            if Numero mod 3 = 0 then
                begin
                  if Numero > Mayor3 then
                      Mayor3 := Numero
                end;

            Write('Ingresar Número: ');
            ReadLn(Numero);
            end;

        Writeln();
        Textcolor(yellow);
        if Mayor3 = low(int32) then
            Writeln('No ha ingresado números multiplos de 3')
        else
            Writeln('El Número Mayor Multiplo de 3 es: ', Mayor3);
        end;

        Writeln();
        Textcolor(green);
        Write('ENTER para reiniciar');
        Textcolor(white);
        readln();

until FALSE;
end.