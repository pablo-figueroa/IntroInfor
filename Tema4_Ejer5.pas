// TEMA 4
// EJERCICIO 5

// Ingresar largo y ancho de un conjunto de rectángulos, 
// para cada uno calcular e informar la superficie. 

// Detener el proceso cuando se hayan ingresado N datos o el perímetro del
// rectángulo ingresado supere un valor X. (N y X son valores ingresados por teclado) 


// INTERPRETACIÓN: 
// Entiendo que el programa debe informar la superficie de un rectangulo;
// con los siguientes límites:
//   a) puede calcular hasta N superficies.
//   b) el perímetro del rectángulo no puede superar un valor X.
//   c) N y X ingresados por teclado.

program T4Ej5;

//{$codepage UTF88} {Para no tener probemas con los acentos}

uses crt; { Biblioteca para limpieza de pantalla, cambio de color... }

var
    N          : byte;   { Cantidad de Rectángulos }
    ContN      : byte;   { Contador de N           }
    MaxPer     : single; { Límite X del perímetro  }
    
    Largo      : single;
    Ancho      : single;

    Perim      : single; { Perímetro  }
    Sup        : single; { Superficie }

begin
repeat {Generar bucle de todo el programa}
clrscr();
TextColor(White); { Fija color de texto en blanco}

{---INICIALIZACIÓN DE CONTADOR---}
    ContN := 0;

{---TITULO---}
    WriteLn('CALCULO DE SUPERFICIE');
    WriteLn();

{---ENTRADA DE DATOS---}    
    repeat { Validar que sea mayor que cero }
        Write('Establecer Cantidad de Rectángulos: ');
        ReadLn(N);
            if N <= 0 then
                begin
                TextColor(red);
                WriteLn('    Error. Dato inválido.');
                TextColor(white);
                end;
    until N > 0;
    WriteLn();
    repeat { Validar que sea mayor que cero }
        Write('Establecer Perímetro Máximo: ');
        ReadLn(MaxPer);
            if MaxPer <= 0 then
                begin
                TextColor(red);
                WriteLn('  Error. Dato inválido.');
                TextColor(white);
                end;
    until MaxPer > 0;
    
    WriteLn;

    { INICIO: ENTRADA DE LARGO Y ANCHO. VERIFICACIÓN DEL PERIMETRO }
    
    

{---CICLO WHILE DE SALIDA Y ENTRADA DE DATOS---}    
    while (N <> ContN) do
        begin
        ContN := ContN + 1; { Entró al ciclo while le sumo 1 }
               
        { INICIO: ENTRADA DE LARGO Y ANCHO. VERIFICACIÓN DEL PERIMETRO }
        REPEAT { Hasta Ingresar Perímetro Válido }
            repeat { Validar que sea mayor que cero }
                Write('Ingrese Largo: ');
                ReadLn(Largo);
                    if Largo <= 0 then
                    begin
                    TextColor(red);
                    WriteLn('  Error. Dato inválido.');
                    TextColor(white);
                    end;
            until Largo > 0;
    
            repeat { Validar que sea mayor que cero }
               Write('Ingrese Ancho: ');
                ReadLn(Ancho);
                if Ancho <= 0 then
                   begin
                   TextColor(red);
                   WriteLn('  Error. Dato inválido.');
                   TextColor(white);
                   end;
            until Ancho > 0;
           
            Perim := (Largo * 2) + (Ancho * 2);
    
              if Perim > MaxPer then { ERROR. PERIMETRO INGRESADO SUPERA EL MAXIMO }
                  begin
                  TextColor(red);
                  WriteLn('Perímetro Ingresado supera el Máximo establecido.');
                  WriteLn('Ingresó: ', Perim:0:2, ' | Perímetro Máximo: ', MaxPer:0:2);
                  { CONSEJOS }
                  //WriteLn('Ud puede: Reducir Largo a: ', ((MaxPer - (2 * Ancho)) * (1 / 2)):0:2, ' , manteniendo el Ancho. (Ignorar si es menor que 0)');

                  //WriteLn('Ud puede: Reducir Ancho a: ', ((MaxPer - (2 * Largo)) * (1 / 2)):0:2, ' , manteniendo el Largo. (Ignorar si es menor que 0)');
                  //WriteLn('Ud puede: Modificar ambos.');
                  
                  TextColor(White);
                  WriteLn();
                  end;    
        UNTIL (Perim <= MaxPer); { Fin Perímetro Válido } 
        { FIN: ENTRADA DE LARGO Y ANCHO. VERIFICACIÓN DEL PERIMETRO }

        Writeln('La superficie del rectángulo es: ', (Largo * Ancho):0:2);
        if N <> ContN then
            WriteLn('Cálculos restantes: ', N - ContN, ' de ', N, ' establecidos.');
        WriteLn();
        
        
   end; { WHILE }
   
   WriteLn();
   Writeln('FIN DEL PROGRAMA. ENTER para reiniciar.');
   
   readln();

until FALSE;
end.