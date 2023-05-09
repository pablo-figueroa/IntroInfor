(*
Leer M números y para cada uno calcular e informar el factorial mediante una función
entera.

Recordar:
         -----------------------
         | 1            si n=0
    n! = |
         | n . (n-1)!   si n>0
         -----------------------
*)

program T5_Ej02;
//{$codepage UTF8}
uses crt;

function factorial (n:byte):UInt64;
    var
        i   : byte;
        rdo : UInt64;
    begin
    rdo := 1;
    factorial := 0;
    if n > 0 then
        begin
        for i:= 1 to n do
            begin
            rdo := rdo * i;
            end; {for}
        factorial := rdo;
        end
    else
        factorial := 1;
    end; {function}

var
    arch : text;
    M,i  : byte;
    nro  : Int8;

begin
    Assign(arch, 'T5_Ej02.txt');
    Reset(arch);

    WriteLn('CALCULAR EL FACTORIAL DE N');
    WriteLn(' Lectura desde archivo');
    WriteLn;
    WriteLn(' n  -> n!');

    ReadLn(arch, M);

    for i:=1 to M do
        begin
        ReadLn(arch, nro);

        if (nro >= 0) and (nro <= 20) then
            WriteLn(nro:3,' -> ',factorial(nro):20)
        else
            if (nro < 0) then
                begin
                TextColor(red);
                WriteLn(nro:3,' -> Factorial NO está definida para n < 0');
                TextColor(white);
                end
            else
                begin
                TextColor(red);
                WriteLn(nro:3,' -> No se puede representar. Supera UInt64');
                TextColor(white);
                end;
                //

        end; {for}
    close(arch);
    WriteLn;
    WriteLn('---------------------------------------------------');
    WriteLn('  High Integer: ', high(Integer):20, ' | ¿.......?');
    WriteLn('  High UInt64 : ', high(UInt64) :20, ' | Hasta 20!');
    ReadLn;
end.