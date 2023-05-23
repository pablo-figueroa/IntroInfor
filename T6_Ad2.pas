(*
-------------- ADICIONAL 2 --------------

Dados dos archivos de números enteros positivos A1 (primos) y A2 (no primos).

Leer los números primos de A1 y almacenar en un arreglo VPrimo.

Leer los números de A2 (sin almacenar en un arreglo),
determinar e informar para cada uno de ellos cuántos divisores primos tiene en VPrimos.
Recorrer una sola vez el archivo A2.

        Ejemplo :
        A1 VPrimo = (7, 2 , 5 , 11 , 3)
        A2 = 10 105 50 22 30 

        ->  10 tiene 2 divisores, 
        -> 105 tiene 1 divisor……



Divisores     2   1
*)

program T6_Ad1;

//{$codepage UTF8}

uses crt, SysUtils;

type
    TV_20_Int  = array[1..200] of Integer;


{ --------------------------------------------------------------------------------------------}
procedure Titulo();

begin
    ClrScr;
    WriteLn('--------------------------------------------');
    WriteLn('           PRIMOS Y NO PRIMOS');
    WriteLn('--------------------------------------------');
    WriteLn;
    WriteLn;
end;{procedure}


{ --------------------------------------------------------------------------------------------}
procedure Separador();
begin
    WriteLn;
    WriteLn('------------------------------------------------------------');
    WriteLn;
end;{procedure}


{ --------------------------------------------------------------------------------------------}
procedure LeerVectorArch   { Leer Vector de Archivo }
    (
        NArch : string;
        var V : TV_20_Int; { Vector Original     }
        var N : Byte       { Longitud del Vector }
    );

var
    i   : Byte;
    Num : Integer;
    arch: text;

begin
    i := 0;
    Assign(arch, NArch);
    Reset(arch);

    ReadLn(arch, Num);
    while Num <> -9999 do
        begin
        i := i + 1;
        V[i] := Num;
        ReadLn(arch, Num);
        end; {while}
    N := i;
    Close(arch);
end; {procedure}


{ --------------------------------------------------------------------------------------------}
procedure MostrarVector
    (
        V : TV_20_Int; { Vector Original     }
        N : Byte       { Longitud del Vector }
    );

var
    i : Byte;

begin
    for i:=1 to N do
        Write(V[i]:4);
    WriteLn;
end; {procedure}


{ --------------------------------------------------------------------------------------------}
procedure VectorPrimoStepByStep
    (
        V      : TV_20_Int;  { Vector Original       }
        N      : Byte;       { Longitud del Vector   }
        var VP : TV_20_Int;  { Vector Primo          }
        var P  : Byte        { Longitud Vector Primo }
    );

var
    i : byte;
    j : byte;
    Cont : byte;

begin
    P := 0;
    Titulo;
    WriteLn('Vector Original A1: ');
    WriteLn;
    MostrarVector(V, N);
    Separador;
    
        
    for i:=1 to N do
        begin
        TextColor(blue);
        WriteLn('V[',i,'] -> ',V[i]);
        TextColor(white);


        if V[i] < 2 then
            begin
            WriteLn;
            TextColor(red);
            Writeln('Ya que: ',V[i],' es MENOR que 2 -> NO ES PRIMO');
            TextColor(white);
            Separador;
            readLn;
            ClrScr;
            Titulo;
            WriteLn('Vector Original A1: ');
            WriteLn;
            MostrarVector(V, N);
            Separador;
            end
        else if V[i] = 2 then
            begin
            WriteLn;
            TextColor(green);
            WriteLn('Ya que: ',V[i],' es el único PAR PRIMO -> ES PRIMO..!');
            TextColor(white);
            Separador;
            readLn;
            ClrScr;
            Titulo;
            WriteLn('Vector Original A1: ');
            WriteLn;
            MostrarVector(V, N);
            Separador;
            P := P + 1;
            VP[p] := V[i];
            end

        else if odd(V[i]) then
            begin
            Cont := 0;
            WriteLn;
            WriteLn('Ya que: ',V[i],' es IMPAR veremos si es primo...');
            WriteLn;

            WriteLn('Truncar la Raiz de ',V[i],' = ',trunc(sqrt(V[i])));
            WriteLn('Recorrido de j: Desde 2 -> Hasta ',trunc(sqrt(V[i])));
            WriteLn;

            for j:=2 to trunc(sqrt(V[i])) do     { más   EFICIENTE }
            (* for j:=2 to V[i] do                  { menos EFICIENTE } *)
                begin

                WriteLn('j = ',j:2,' para el número ',V[i]:2,' | => ',V[i]:2,' MODULO ',j:2,' => ',(V[i] mod j):2);
                (* READLN; *)

                if V[i] mod j = 0 then
                    begin
                    cont := cont + 1;
                    TextColor(yellow);
                    WriteLn('Contador de ceros = ',Cont);
                    TextColor(white);
                    if j < trunc(sqrt(V[i])) then
                        begin
                        TextColor(cyan);
                        WriteLn;
                        Write('B R E A K !');
                        WriteLn;
                        TextColor(white);
                        end;
                    break;

                    (* READLN; *)
                    end; {if mod}
                end; {for j}
            WriteLn;

            if cont = 0 then      { = 1 PARA EL MENOS EFICIENTE }
                begin
                TextColor(green);
                WriteLn(V[i]:2,' ES PRIMO..! | Cantidad de Ceros = ',cont);
                TextColor(white);
                P := P + 1;
                VP[p] := V[i];
                Separador;
                readLn;
                ClrScr;
                Titulo;
                WriteLn('Vector Original A1: ');
                WriteLn;
                MostrarVector(V, N);
                Separador;
                end {cont = 0}
            else
                begin
                TextColor(red);
                WriteLn(V[i]:2,' NO ES PRIMO..! | Cantidad de Ceros = ',cont,' > 0');
                TextColor(white);
                Separador;
                readLn;
                ClrScr;
                Titulo;
                WriteLn('Vector Original A1: ');
                WriteLn;
                MostrarVector(V, N);
                Separador;
                end; {else}
            //WriteLn('--------------------------------------------------');
            //WriteLn;
            end {else odd}
        else
            begin
            WriteLn;
            WriteLn('Ya que: ',V[i],' es PAR y Mayor que 2 -> No hacer nada.-');
            Separador;
            readLn;

            ClrScr;
            Titulo;
            WriteLn('Vector Original A1: ');
            WriteLn;
            MostrarVector(V, N);
            Separador;

            end;
        end; {for i}
    WriteLn;
    WriteLn('FIN DE VECTOR ORIGINAL (A1)');
    ReadLn;
    ClrScr;


end;{procedure VectorPrimoStepByStep}



{ --------------------------------------------------------------------------------------------}
procedure VectorPrimoFast
    (
        V      : TV_20_Int;  { Vector Original       }
        N      : Byte;       { Longitud del Vector   }
        var VP : TV_20_Int;  { Vector Primo          }
        var P  : Byte        { Longitud Vector Primo }
    );

var
    i : byte;
    j : byte;
    Cont : byte;

begin
    P := 0;
    for i:=1 to N do
        begin
        if V[i] < 2 then
        else if V[i] = 2 then
            begin
            P := P + 1;
            VP[p] := V[i];
            end
        else if odd(V[i]) then
            begin
            Cont := 0;
            for j:=2 to trunc(sqrt(V[i])) do 
                begin
                if V[i] mod j = 0 then
                    begin
                    cont := cont + 1;
                    break;
                    end; {if mod}
                end; {for j}
            if cont = 0 then
                begin
                P := P + 1;
                VP[p] := V[i];
                end; {cont = 0}
            end; {else if odd}
        end; {for i}
end;{procedure fast}




{ PROGRAMA PRINCIPAL -------------------------------------------------------------------------}
var
    Vector  : TV_20_Int;
    N       : Byte;

    VectorP : TV_20_Int;
    P       : Byte;
    
    i       : Byte;
    num     : Integer;
    Cont    : Byte;

    S       : Char;
    res     : char;
    arch    : text;

begin

    Titulo;
    LeerVectorArch('T6_Ad2_A1.txt', Vector, N);

    WriteLn('Vector Original A1: ');
    WriteLn;
    MostrarVector(Vector, N);

    Separador;

    Write('Ver el paso a paso | S -> Sí ');
    ReadLn(Res);
    Res := UpCase(Res);
    
    if Res = 'S' then
        VectorPrimoStepByStep(Vector,N,VectorP,P)
    else
        VectorPrimoFast(Vector,N,VectorP,P);

    Titulo;
    Writeln('Vector Primo A1:');
    WriteLn;
    MostrarVector(VectorP, P);

    Separador;

    { BUSCAR LA CANTIDAD DE DIVISORES }
    Assign(arch, 'T6_Ad2_A2.txt');
    Reset(Arch);

    Cont := 0;
    
    WriteLn('Archivo A2 en RELACIÓN al Vector de Primos:');
    WriteLn;
    while not eof(arch) do
        begin
        ReadLn(arch, num);
        for i:=1 to P do
            begin
            (* WriteLn(num,' mod ',VectorP[i] , ' = ',num mod VectorP[i]); *)
            if num mod VectorP[i] = 0 then
                Cont := Cont + 1;
            end; {for}
        WriteLn('-> ',num:3,' tiene ',Cont,' divisores.-');
        (* WriteLn; *)
        Cont := 0;
        end; {while}

    Separador;

    TextColor(red);
    Write('ENTER -> Salir ');
    TextColor(white);
    S := ReadKey;
    S := UpCase(S);

end.