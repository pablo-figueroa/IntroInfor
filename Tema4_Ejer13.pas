                           // TEMA 4
// EJERCICIO 13.-

// Para N personas, ingresar sexo ( F : femenino, M : masculino) y edad (en años).

// Calcular e informar:
//   a) Porcentaje de cada sexo.
//   b)
//       1) Promedio de edades en general ingresadas,
//       2) promedio de edad de los varones y el
//       3) promedio de edad de las mujeres.

// ¿Qué control puede hacer para darle robustez al algoritmo y evitar que cancele por división por 0?.



// JUEGO DE DATOS:

program T4Ej13;

//{$codepage UTF8}

uses crt;

var
    Edad      : byte;
    AcumEdadF : word;
    AcumEdadM : word;

    ContF : byte;
    ContM : byte;

    Res    : char;

begin
repeat
clrscr();
    { INICIALIZACIÓN }
    ContF     := 0;
    ContM     := 0;
    AcumEdadF := 0;
    AcumEdadM := 0;

    { TILTULO }
    WriteLn('-------------------------');
    WriteLn('   PROMEDIO DE EDADES');
    WriteLn('-------------------------');
    WriteLn();

    repeat
        Write('Ingresar: F | M : ');
        ReadLn(Res);
        Res := UpCase(Res);
    until (Res = 'F') or (Res = 'M');

    While (Res = 'F') or (Res = 'M') do
        begin
        Write('Ingrese Edad: ');
        ReadLn(Edad);
        WriteLn();
        if Res = 'F' then
            begin
            ContF := ContF + 1;
            AcumEdadF := AcumEdadF + Edad;
            end
        else
            begin
            ContM := ContM + 1;
            AcumEdadM := AcumEdadM + Edad;
            end;

        repeat
            Write('Ingresar: F | M | (S)alir : ');
            ReadLn(Res);
            Res := UpCase(Res);
        until (Res = 'F') or (Res = 'M') or (Res = 'S');
        end; {while}
    WriteLn();

    { SALIDAS DE INFORMACIÓN }

    TextColor(Yellow);
    if ContF > 0 then
        WriteLn('Las Mujeres representan el ', ((ContF / (ContF + ContM))*100):6:2 , '% del total');

    if ContM > 0 then
        WriteLn('Los Varones representan el ', ((ContM / (ContF + ContM))*100):6:2 , '% del total');

    WriteLn();

    TextColor(cyan);
    if (ContF > 0) and (ContM > 0) then
        WriteLn('Promedio Edad General: ', ((AcumEdadF + AcumEdadM)/(ContF + ContM)):7:1);

    if ContF > 0 then
        WriteLn('Promedio Edad Mujeres: ', (AcumEdadF / ContF):7:1)
    else
        WriteLn('Promedio Edad Mujeres: NO DATA');

    if ContM > 0 then
        WriteLn('Promedio Edad Varones: ', (AcumEdadM / ContM):7:1)
    else
        WriteLn('Promedio Edad Varones: NO DATA');


    WriteLn();
    TextColor(green);
    Write('ENTER para reiniciar...');
    TextColor(white);
    ReadLn();
until FALSE;
end.