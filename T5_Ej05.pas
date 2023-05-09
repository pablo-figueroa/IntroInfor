(*
5.- A partir de dos fracciones devolver la fracción suma. 
¿Podría utilizarse una función que realice la misma operación?

RTA: D E P E N D E.
            Sí, devolviendo el resultado en un string.
            Peeeero... si después....
*)

program T5_Ej05;

uses crt, SysUtils;

{ ---------------------- FUNCTION ---------------------------------------------- }
function fraccion(N1,D1,N2,D2:integer):string;
var
    SumaNdor, SumaDdor : integer;
begin
    SumaNdor := (N1 * D2) + (N2 * D1);
    SumaDdor := D1 * D2;
    fraccion := IntToStr(SumaNdor) + '/' + IntToStr(SumaDdor);

    while (SumaNdor mod 7 = 0) and (SumaDdor mod 7 = 0) do
        begin
        SumaNdor := SumaNdor div 7;
        SumaDdor := SumaDdor div 7;
        end;
    
    while (SumaNdor mod 5 = 0) and (SumaDdor mod 5 = 0) do
        begin
        SumaNdor := SumaNdor div 5;
        SumaDdor := SumaDdor div 5;
        end;
    
    while (SumaNdor mod 3 = 0) and (SumaDdor mod 3 = 0) do
        begin
        SumaNdor := SumaNdor div 3;
        SumaDdor := SumaDdor div 3;
        end;
    
    while (SumaNdor mod 2 = 0) and (SumaDdor mod 2 = 0) do
        begin
        SumaNdor := SumaNdor div 2;
        SumaDdor := SumaDdor div 2;
        end;

    if SumaDdor <> 1 then
        fraccion := IntToStr(SumaNdor) + '/' + IntToStr(SumaDdor)
    else        
        fraccion := IntToStr(SumaNdor);

end; {function}


{ ---------------------- PROCEDURE --------------------------------------------- }
procedure fraction(N1,D1,N2,D2:integer);
var SumaNdor, SumaDdor : integer;
begin
    SumaNdor := (N1 * D2) + (N2 * D1);
    SumaDdor := D1 * D2;
    WriteLn('La suma de las fracciones es: ', SumaNdor, '/', SumaDdor);
    
    while (SumaNdor mod 7 = 0) and (SumaDdor mod 7 = 0) do
        begin
        SumaNdor := SumaNdor div 7;
        SumaDdor := SumaDdor div 7;
        end;
    
    while (SumaNdor mod 5 = 0) and (SumaDdor mod 5 = 0) do
        begin
        SumaNdor := SumaNdor div 5;
        SumaDdor := SumaDdor div 5;
        end;
    
    while (SumaNdor mod 3 = 0) and (SumaDdor mod 3 = 0) do
        begin
        SumaNdor := SumaNdor div 3;
        SumaDdor := SumaDdor div 3;
        end;
    
    while (SumaNdor mod 2 = 0) and (SumaDdor mod 2 = 0) do
        begin
        SumaNdor := SumaNdor div 2;
        SumaDdor := SumaDdor div 2;
        end;

    if SumaDdor <> 1 then
        WriteLn('LA FRACCIÓN SIMPLIFICADA ES : ', SumaNdor, '/', SumaDdor)
    else        
        WriteLn(' LA FRACCIÓN SIMPLIFICADA ES: ', SumaNdor);
    
end; {procedure}


{ ---------------------- VARIABLES GLOBALES ------------------------------------- }
var
    Ndor1, Ddor1, Ndor2, Ddor2, SumaNdor, SumaDdor: integer;
    q : char;


{ ---------------------- MAIN --------------------------------------------------- }
begin
    repeat
    ClrScr;
    WriteLn('------------------');
    WriteLn('SUMA DE FRACCIONES');
    WriteLn('------------------');
    WriteLn;
    
    WriteLn('Ingrese la primera fraccion: ');
    Write('  Numerador  : ');
    ReadLn(Ndor1);
    Write('  Denominador: ');
    ReadLn(Ddor1);
    
    WriteLn;
    WriteLn('Ingrese la segunda fraccion: ');
    Write('  Numerador  : ');
    ReadLn(Ndor2);
    Write('  Denominador: ');
    ReadLn(Ddor2);
    
    {CALCULOS}
    SumaNdor := (Ndor1 * Ddor2) + (Ndor2 * Ddor1);
    SumaDdor := Ddor1 * Ddor2;
    
    WriteLn;
    WriteLn('La suma de las fracciones es: ', SumaNdor, '/', SumaDdor);

    (* while (SumaNdor mod 10 = 0) and (SumaDdor mod 10 = 0) do
        begin
        SumaNdor := SumaNdor div 10;
        SumaDdor := SumaDdor div 10;
        WriteLn('MOD 10: ', SumaNdor, '/', SumaDdor);
        end; *)

    while (SumaNdor mod 7 = 0) and (SumaDdor mod 7 = 0) do
        begin
        SumaNdor := SumaNdor div 7;
        SumaDdor := SumaDdor div 7;
        (* WriteLn('MOD 7: ', SumaNdor, '/', SumaDdor); *)
        end;
    
    while (SumaNdor mod 5 = 0) and (SumaDdor mod 5 = 0) do
        begin
        SumaNdor := SumaNdor div 5;
        SumaDdor := SumaDdor div 5;
        (* WriteLn('MOD 5: ', SumaNdor, '/', SumaDdor); *)
        end;
    
    while (SumaNdor mod 3 = 0) and (SumaDdor mod 3 = 0) do
        begin
        SumaNdor := SumaNdor div 3;
        SumaDdor := SumaDdor div 3;
        (* WriteLn('MOD 3: ', SumaNdor, '/', SumaDdor); *)
        end;
    
    while (SumaNdor mod 2 = 0) and (SumaDdor mod 2 = 0) do
        begin
        SumaNdor := SumaNdor div 2;
        SumaDdor := SumaDdor div 2;
        (* WriteLn('MOD 2: ', SumaNdor, '/', SumaDdor); *)
        end;

    TextColor(cyan);
    if SumaDdor <> 1 then
        WriteLn('LA FRACCIÓN SIMPLIFICADA ES : ', SumaNdor, '/', SumaDdor)
    else        
        WriteLn(' LA FRACCIÓN SIMPLIFICADA ES: ', SumaNdor);
    TextColor(white);
    
    WriteLn;
    TextColor(green);
    WriteLn('--------------------------------------------');
    WriteLn('DESDE LA FUNCIÓN');
    WriteLn(' LA FRACCIÓN SIMPLIFICADA ES: ', fraccion(Ndor1,Ddor1,Ndor2,Ddor2));
    
    TextColor(yellow);

    WriteLn;
    WriteLn('--------------------------------------------');
    WriteLn('DESDE EL PROCEDIMIENTO');
    fraction(Ndor1,Ddor1,Ndor2,Ddor2);

    { SALIDA }
    WriteLn;
    TextColor(red);
    WriteLn('q -> sale');
    TextColor(white);
    q := readkey;
    q := UpCase(q);
    if q = 'Q' then
        halt;
    until false;
end.