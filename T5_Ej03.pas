(*
3.- Reescribir el Ejercicio 12 del capítulo 3 para un conjunto de puntos, mediante una función string .

TEMA 3
Ejercicio 12

Ingresar X e Y, representan ordenada y abscisa de un punto en el plano, 
determinar a qué cuadrante pertenecen, 
si está sobre un eje o en el centro.
*)

program T5_Ej03;
uses crt;
function cuadrante(x,y:real):string;
begin
    if x > 0 then
        if y > 0 then
            cuadrante := 'cuadrante I'
        else
            cuadrante := 'cuadrante IV';
    if x < 0 then
        if y > 0 then
            cuadrante := 'cuadrante II'
        else
            cuadrante := 'cuadrante III';
    
    if (x = 0) and (y = 0) then
        cuadrante := 'origen.'
    else
        if x = 0 then
            cuadrante  := 'eje de las ordenadas.'
        else
            if y = 0 then
                cuadrante  := 'eje de las abscisas.';
end; {function}

var 
    x,y : real;

begin
    repeat
    ClrScr;
    WriteLn('---------------------------');
    WriteLn('DETERMINACIÓN DEL CUADRANTE');
    WriteLn('---------------------------');
    WriteLn;

    WriteLn('Ingresar el punto (x,y)');
    Write('  x: ');
    ReadLn(x);
    Write('  y: ');
    ReadLn(y);
    WriteLn;
    TextColor(cyan);
    WriteLn('El punto pertenece al ',cuadrante(x,y));
    TextColor(white);
    ReadLn;
    until false;
end.