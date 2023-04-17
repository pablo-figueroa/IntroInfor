program Heladeria;

uses crt;

var
    Peso    : single; { Unidad de Medida: Kgs  }
    Importe : single; { Almacena el Importe    }
    Desc    : single; { Almacena el Descuento  }

    Tipo    : char;   { A:Agua L:Leche C:Crema }
    F       : char;   { Finalizar Repeat       }
    D       : char;   { Acceder al Detalle     }

begin
repeat
    Peso := 0;
    Tipo := ' ';

{---TITULO PRINCIPAL-----------------------------------------------------------}
    clrscr();
    WriteLn('-------------');
    TextBackground(green);
    WriteLn('  HELADERIA  ');
    TextBackground(black);
    WriteLn('-------------');
    WriteLn();

{---ENTRADA DE DATO: PESO------------------------------------------------------}
    TextColor(yellow);
    Write('Ingrese el PESO en kgr de Helado: ');
    While Peso <= 0 do
        begin
        gotoxy(36,5);
        clreol();
        Readln(Peso);
        If Peso <= 0 then {Validar entrada}
            begin
            gotoxy(36,5);
            clreol();
            TextColor(red);
            Write('El peso debe ser mayor que cero!!!'); {Mensaje de error}
            TextColor(yellow);
            readln();
            end;
        end;

        {Confirmación de Entrada: PESO}
    gotoxy(36,5);
    clreol();
    TextColor(green);
    Writeln(Peso:6:3);
    WriteLn();

{---ENTRADA DE DATO: TIPO------------------------------------------------------}
    TextColor(yellow);
    WriteLn('Ingrese el TIPO de Helado: ');

    WriteLn('  "A" : Agua');
    WriteLn('  "L" : Leche');
    WriteLn('  "C" : Crema');

    While (Tipo <> 'A') and (Tipo <> 'L') and (Tipo <> 'C') do  {Validar entrada}
        begin
        gotoxy(28,7);
        clreol();
        ReadLn(Tipo);
        Tipo := UpCase(Tipo);
        end;

        {Confirmación de Entrada: TIPO}
    gotoxy(28,7);
    clreol();
    TextColor(green);
    WriteLn(Tipo);
    gotoxy(1,12);


{---CALCULOS-------------------------------------------------------------------}

        {Asignación de los Descuentos}

    If Peso < 1.5 then         {Descuento:  0%}
        Desc := 0.0
    Else

        If Peso <= 3 then      {Descuento:  5%}
            Desc := 0.05
        Else

            If Peso <= 5 then  {Descuento:  7%}
                Desc := 0.07
            Else               {Descuento: 10%}
                Desc := 0.10;


        {Asignación de los Precios}

    Case Tipo of
        'A' : Importe := 2000;  { Agua  }

        'L' : Importe := 2300;  { Leche }

        'C' : Importe := 2500;  { Crema }

    end; {Case}


{--------SALIDA DE INFORMACIÓN-------------------------------------------------}

        {Muestra del Importe Final}
    TextColor(cyan);
    Writeln('Importe Final: $ ', Peso * Importe * (1 - Desc):9:2);
    Writeln();

        {Consulta de Detalle}
    TextColor(yellow);
    Write('"D" para Detalle: ');
    D := readkey;
    D := UpCase(D);

        {Muestra del Detalle}
    If D = 'D' then
        begin
        gotoxy(1,13);
        clreol();
        writeln();
        TextColor(white);
        WriteLn(' Detalle de la compra: ');
        WriteLn('  Importe General: ',Peso:6:3, ' kg. x $ ', Importe:8:2, ' = $ ', (Peso * Importe):8:2);
        if (not(Desc = 0)) then
            WriteLn('  Descuento      : ',(Desc*100):5:2, '  %   x $ ', (Peso * Importe):8:2, ' = $ ', -(Peso * Importe * Desc):8:2)
        else
            writeln('  A partir de 1.5 kg participa de grandes descuentos!');
            writeln('                                            ------------');
            writeln('                                             $ ', ((Peso*Importe) - (Peso*Importe*Desc)):8:2);
        end;



        {Consulta de Finalización o Continuación}
    Writeln();
    TextColor(White);
    TextBackground(red);
    Write(' F para Fin ');
    TextBackground(green);
    Write(' ENTER para Continuar ');
    TextBackground(black);

    F := readkey;
    F := UpCase(F);


until (F = 'F');

end.

// Dos juegos de datos de entrada con las salidas obtenidas

 {     |-----------------------------------------||-------------|     }
 {     |   ENTRADA:        PESO         TIPO     ||    SALIDA   |     }
 {     |-----------------------------------------||-------------|     }
 {     |   JUEGO 1:       0.750            A     ||   1500.00   |     }
 {     |-----------------------------------------||-------------|     }
 {     |   JUEGO 2:       5.000            C     ||  11625.00   |     }
 {     |-----------------------------------------||-------------|     }



// Una heladería realiza ventas los fines de semana.

// Se pide CALCULAR y MOSTRAR el IMPORTE que debe PAGAR cada cliente.

// Los datos que se ingresan son:
//     PESO: cantidad de kilos de helado a comprar (Real).
//     TIPO: tipo de helado ‘A’:Agua, ‘L’:Leche, ‘C’:Crema (Carácter).

// El precio se calcula de acuerdo al tipo, cada Kg del tipo:
//     ‘A’ cuesta 2000 pesos,
//     ‘L’ cuesta 2300 pesos
//     ‘C’ cuesta 2500 pesos.

// Si el peso está entre 1.5 y 3 Kg
//     se aplica un descuento del 5% sobre el valor a pagar.

// si el peso es mas de 3 hasta 5 Kg
//     se aplica un descuento del 7% sobre el valor a pagar.

// si el peso es más de 5 Kg
//     se aplica un descuento del 10% sobre el valor a pagar.