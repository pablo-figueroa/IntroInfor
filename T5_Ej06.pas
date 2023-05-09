(*
6.- Leer de un archivo de texto los coeficientes de un conjunto de polinomios con raíces reales, calcular y mostrar las raíces de cada uno.

P(x) = ax2 + bx + c

*)

program T5_Ej06;

//{$codepage UTF8}

uses crt, SysUtils;

procedure linea(color:byte);
begin
    TextColor(color);
    WriteLn('------------------------------------------------');
end;


procedure raices(a,b,c:real);
var
    raiz1, raiz2, disc : real;
begin
    disc := b * b - 4 * a * c;

    if disc > 0 then
        begin

        raiz1 := (-b - sqrt(disc)) / (2 * a);
        raiz2 := (-b + sqrt(disc)) / (2 * a);

        TextColor(yellow);
        WriteLn('  Raices en: x1 = ',raiz1:8:4);
        WriteLn('             x2 = ',raiz2:8:4);
        TextColor(white);
        end
    else
        if disc = 0 then
            begin
            raiz1 := -b / 2 * a;
            TextColor(yellow);
            WriteLn('  Única raiz x  = ',raiz1:8:4);
            TextColor(white);
            end
        else
            begin
            TextColor(yellow);
            WriteLn('  No existen raices reales');
            TextColor(white);
            end;
end; {procedure}

var
    arch  : text;
    a,b,c : real;

begin
    Assign(arch, 'T5_Ej06.txt');
    Reset(arch);
    ClrScr;
    TextColor(blue);
    WriteLn('------------------------------');
    WriteLn('RAICES DE UN POLINOMIO GRADO 2');
    WriteLn('     P(x) = ax2 + bx + c');
    WriteLn('------------------------------');
    TextColor(white);

    While not eof(arch) do
        begin
        ReadLn(arch, a,b,c);
        TextColor(red);
        linea(red);
        TextColor(white);
        WriteLn('Coeficientes: a = ',a:5:2,' | b = ',b:5:2,' | c = ',c:5:2);

        raices(a,b,c);

        end; {while}
    Close(arch);

    linea(red);
    ReadLn;
end. {main}