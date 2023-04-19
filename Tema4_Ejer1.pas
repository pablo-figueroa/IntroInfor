// 1.-Dado un conjunto de números enteros distintos de cero,
// informar el porcentaje de pares e impares.

program Tema4_Ej1;

uses crt; {para poder usar clrscr();}

var
    Numero    : integer;

    ContPar   : byte;
    ContImpar : byte;

begin
repeat    {Para crear un ciclo infinito en la ejecucion del programa}
    clrscr(); {Limpia la pantalla}

    ContPar   := 0;
    ContImpar := 0;

      {TITULO}
    WriteLn('NUMEROS ENTEROS DISTINTOS DE CERO.');
    WriteLn('INFORMA PORCENTAJE DE PARES E IMPARES.');
    WriteLn('Para finalizar entrada de numeros: 0');
    WriteLn();

      {ENTRADA DE DATOS}
    write('Ingresar un numero: ');
    readln(Numero);

    if Numero = 0 then {}
        Write('No ha ingresado ningun numero!')
    else
        begin
        while Numero <> 0 do
            begin

            if (numero mod 2 = 0) then {también puede ser <> 1 | con ambos es par}
                begin
                ContPar  := ContPar + 1;
                end
            else
                begin
                ContImpar  := ContImpar + 1;
                end;
            write('Ingresar un numero: ');
            readln(Numero);
            end;

          {PRUEBA DE CONTEO}
        {writeln();
        Writeln('Pares  : ', ContPar);
        Writeln('Impares: ', ContImpar);
        Writeln('Total  : ', ContPar + ContImpar);}

          {CALCULOS Y SALIDA DE INFORMACIÓN}
        writeln();
        writeln('Porcentaje de Pares  : ', (ContPar   * 100 / (ContPar + ContImpar)):6:2 );
        writeln('Porcentaje de Impares: ', (ContImpar * 100 / (ContPar + ContImpar)):6:2 );
    end;

    readln();
until FALSE;
end. 