program TpSeleccion_Figueroa;

var
    Peso    : real;   { Unidad de Medida: Kgs                  }
    Precio  : real;   { Almacena el Importe del TIPO de helado }
    Importe : real;   { Almacena Peso*Precio                   }
    Desc    : real;   { Almacena el Descuento                  }

    Tipo    : char;   { A:Agua L:Leche C:Crema                 }

begin
    Peso := 0;
    Tipo := ' ';

{---TITULO PRINCIPAL-----------------------------------------------------------}

    WriteLn('---------------');
    WriteLn('  FACTURACION  ');
    WriteLn('---------------');
    WriteLn();

{---ENTRADA DE DATO: PESO------------------------------------------------------}

    Write('Ingrese kgr. de helado: ');
    Readln(Peso);

{---ENTRADA DE DATO: TIPO------------------------------------------------------}

    WriteLn();
    WriteLn('TIPOS de helado:');

    WriteLn('  "A" : Agua.');
    WriteLn('  "L" : Leche.');
    WriteLn('  "C" : Crema.');

    WriteLn();
    Write('Ingrese el TIPO de helado: ');
    ReadLn(Tipo);
    Tipo := UpCase(Tipo);

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
        'A' : Precio := 2000;  { Agua  }

        'L' : Precio := 2300;  { Leche }

        'C' : Precio := 2500;  { Crema }

    end; {Case}

        {Calculo de Importe General: Importe antes del Descuento}

    Importe := Peso * Precio;

{--------SALIDA DE INFORMACIÓN-------------------------------------------------}

        {Muestra del Detalle e IMPORTE A PAGAR}

    writeln();
    WriteLn(' Detalle de la compra: ');
    WriteLn('  Importe General: ',Peso:6:3, ' kg. x $ ', Precio:7:2, ' = $ ', (Importe):8:2);
    if (not(Desc = 0)) then
        //WriteLn('  Descuento      : ',(Desc*100):5:2, '  %   x $ ', (Peso * Importe):8:2, ' = $ ', -(Peso * Importe * Desc):8:2)
        WriteLn('  Aplica un Descuento del: ',(Desc*100):5:2, ' %        = $ ', -(Importe * Desc):8:2)
    else
        writeln('  A partir de 1.5 kg participa de grandes descuentos!');
        writeln('                                           ------------');
        writeln('  IMPORTE A PAGAR:                          $ ', ((Importe) - (Importe*Desc)):8:2);

    ReadLn(); {para generar una espera y ver poder la impresión de la pantalla}

end. {Fin del programa.}


// Dos juegos de datos de entrada con las salidas obtenidas

{      |-----------------------------------------||-------------|     }
{      |   ENTRADA:        PESO         TIPO     ||    SALIDA   |     }
{      |-----------------------------------------||-------------|     }
{      |-----------------------------------------||-------------|     }
{      |   JUEGO 1:       1.750            L     ||   3823.75   |     }
{      |-----------------------------------------||-------------|     }
{      |-----------------------------------------||-------------|     }
{      |   JUEGO 2:       4.500            C     ||  10462.50   |     }
{      |-----------------------------------------||-------------|     }



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