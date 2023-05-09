// TEMA 4
// EJERCICIO 15-

// En un entrenamiento de ciclismo cada participante, efectúa una vuelta a la pista y
// al terminar la misma se registra el nombre (*** fin de datos),
// la velocidad máxima alcanzada y sus pulsaciones.

// Se pide desarrollar un programa Pascal que lea de teclado los datos mencionados,
// obtenga e informe:
//   - La categoría de cada ciclista y su nivel de riesgo
//   - La cantidad de participantes en cada categoría
//   - El porcentaje de participantes cuyo de nivel de riesgo es 3

// Calcule CATEGORIA y NIVEL DE RIESGO según las siguientes tablas:

//        | VELOCIDAD MAXIMA         | CATEGORIA       |
//        | Más de 50km/h            | A               |
//        | Entre 40km/h y 49km/h    | B               |
//        | Menos de 40km/h          | C               |

//        | PULSACIONES              | NIVEL DE RIESGO |
//        | Hasta 120                | 1               |
//        | Entre 121 y 160          | 2               |
//        | Más de 160               | 3               |

// Como modificaría el código si se pidiera además
//   a. Promedio de velocidades máximas
//   b. Cantidad de corredores de categoría A con nivel de riesgo 1
//   c. Informar categorías sin participantes


program T4Ej15;

{$codepage UTF8}

uses crt;

var
  Nom : string[20];

  ContCatA, ContCatB, ContCatC,
  ContR1, ContR2, ContR3,
  AcumVelMax, ContA1 : byte;

  VelMax, Pulso : word;  { Pulso: Para poder validar, con byte si se ingresa 258 => 1 }

  arch: text;

  Cat,NivR : char;

begin
repeat
clrscr();

    { INICIALIZACION DE CONTADORES Y ACUMULADORES }
    ContCatA   := 0;
    ContCatB   := 0;
    ContCatC   := 0;
    ContR1     := 0;
    ContR2     := 0;
    ContR3     := 0;
    AcumVelMax := 0;
    ContA1     := 0;

    TextColor(cyan);
    Writeln('----------------------------------');
    Writeln('        PRUEBA DE CICLISMO');
    Writeln('----------------------------------');
    WriteLn();

    assign(arch, 'ciclismo.txt');
    ReWrite(arch);

    TextColor(yellow);
    WriteLn('INGRESAR los siguientes DATOS:');
    TextColor(white);

    TextColor(yellow);
    Write('  Nombre: ');
    TextColor(white);
    ReadLn(Nom);
    WriteLn(arch, Nom);

    While (Nom <> '***') do
        begin
        repeat
            Write('  Velocidad Máxima: ');
            ReadLn(VelMax);
        until (VelMax > 0) and (VelMax < 300);

        repeat
            Write('  Pulsaciones por minutos: ');
            ReadLn(Pulso);
        until (Pulso > 0) and (Pulso < 250);

        { ACUMADOR DE VELOCIDAD MÁXIMA }
        AcumVelMax := AcumVelMax + VelMax;

        { CATEGORIA}
        if VelMax < 40 then
            begin
            WriteLn('    Categoría: C');
            ContCatC := ContCatC + 1;
            Writeln(arch, 'C');
            end

        else
            if VelMax <= 49 then
                begin
                WriteLn('    Categoría: B');
                ContCatB := ContCatB + 1;
                Writeln(arch, 'B');
                end
            else
                begin
                WriteLn('    Categoría: A');
                ContCatA := ContCatA + 1;
                Writeln(arch, 'A');
                end;

        { NIVEL DE RIESGO }
        //if pulso <= 120 then
        //    begin
        //    WriteLn('    Nivel de Riesgo: 1');
        //    ContR1 := ContR1 + 1;
        //    Writeln(arch, '1');
        //    end
        //else
        //    if pulso <= 160 then
        //        begin
        //        WriteLn('    Nivel de Riesgo: 2');
        //        ContR2 := ContR2 + 1;
        //        Writeln(arch, '2');
        //        end
        //    else
        //        begin
        //        WriteLn('    Nivel de Riesgo: 3');
        //        ContR3 := ContR3 + 1;
        //        Writeln(arch, '3');
        //        end;

        case pulso of
            1..120:
                begin
                WriteLn('    Nivel de Riesgo: 1');
                ContR1 := ContR1 + 1;
                Writeln(arch, '1');
                end;

            121..159:
                begin
                WriteLn('    Nivel de Riesgo: 2');
                ContR2 := ContR2 + 1;
                Writeln(arch, '2');
                end;

            160..255:
                begin
                WriteLn('    Nivel de Riesgo: 3');
                ContR3 := ContR3 + 1;
                Writeln(arch, '3');
                end;
        end;



        { CONTADOR CATEGRIA A Y RIESGO 1 }
        if (VelMax > 50) and (pulso <= 120) then
            ContA1 := ContA1 + 1;

        WriteLn();
        TextColor(yellow);
        Write('  Nombre: ');
        TextColor(white);
        ReadLn(Nom);
        WriteLn(arch, Nom);
        end;
    close(arch);
    WriteLn();

    TextColor(red);
    Write('ENTER para ver el INFORME 1');
    TextColor(white);
    ReadLn();

    { SALIDA DE INFORME 1 }
    clrscr();
    TextColor(blue);
    WriteLn('------------- I N F O R M E - 1 -------------');
    WriteLn();
    TextColor(cyan);
    WriteLn('Categoría de cada ciclista y su nivel de riesgo');
    TextColor(white);

    reset(arch);
    ReadLn(arch, Nom);
    while Nom <> '***' do
        begin

        ReadLn(arch, Cat);
        ReadLn(arch, NivR);
        WriteLn();

        TextColor(Yellow);
        Write('CICLISTA: ');
        TextColor(White);
        WriteLn(Nom);
        Writeln('  Categoria       : ', Cat);
        Writeln('  Nivel de Riesgo : ', NivR);

        ReadLn(arch, Nom);
        end; {while}
    close(arch);

    WriteLn();
    TextColor(cyan);
    WriteLn('Cantidad de Participantes en cada Categoría');
    TextColor(white);
    WriteLn('  Categoria A :',ContCatA);
    WriteLn('  Categoria B :',ContCatB);
    WriteLn('  Categoria C :',ContCatC);

    WriteLn();
    TextColor(cyan);
    WriteLn('Porcentaje de participantes cuyo de nivel de riesgo es 3:');
    TextColor(white);
    WriteLn('  Riesgo 3: ',(ContR3 * 100 / (ContR1+ContR2+ContR3)):6:2,'%');

    WriteLn();
    TextColor(red);
    Write('ENTER para ver el INFORME 2');
    TextColor(white);
    ReadLn();

    { SALIDA DE INFORME 2 }
    clrscr();
    TextColor(blue);
    WriteLn('------------- I N F O R M E - 2 -------------');
    WriteLn();

    TextColor(cyan);
    WriteLn('PROMEDIO de Velocidades Máximas:');
    TextColor(white);
    WriteLn('  ',(AcumVelMax / (ContR1+ContR2+ContR3)):3:2,' km/h');
    WriteLn();

    TextColor(cyan);
    WriteLn('CANTIDAD de corredores de CATEGORÍA A con NIVEL de RIESGO 1:');
    TextColor(white);
    WriteLn('  Cantidad A-1: ',ContA1);
    WriteLn();

    TextColor(cyan);
    WriteLn('Categorías sin Participantes:');
    TextColor(white);

    if (ContCatA > 0) and (ContCatB > 0) and (ContCatC > 0) then
        WriteLn('  Todas las categorías tienen participantes!');

    if ContCatA = 0 then
        WriteLn('  Categoría A');

    if ContCatB = 0 then
        WriteLn('  Categoría B');

    if ContCatC = 0 then
        WriteLn('  Categoría C');

    WriteLn();
    TextColor(red);
    Write('ENTER para reiniciar...');
    TextColor(white);
    ReadLn();

until FALSE;
end.