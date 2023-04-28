{ ---------------------- LEYENDO DESDE ARCHIVO ---------------------- }

// TEMA 4
// EJERCICIO 14.-

// Leer las N ventas efectuadas por una farmacia Social.

// Por cada una se ingresa el monto y un código indicador del rubro:
//   L - venta libre
//   M - medicamentos (23% de descuento)
//   P - perfumería (promoción 10% de descuento).
//   A - accesorios (promoción, si el monto supera $X corresponde un 5% de descuento)

// Se pide informar:
//   - por cada venta el importe a pagar (con el descuento efectuado, si corresponde)
//   - Importe total bonificado en concepto de descuentos
//   - Total de operaciones e importe total en venta libre
//   - Monto de venta máximo y a que rubro pertenece

program T4Ej14;

//{$codepage UTF8}

uses crt;

const
    DescMed      : single =    0.23; { Descuento Medicamentos     }
    DescPer      : single =    0.10; { Descuento Perfumeria       }
    DescAcc      : single =    0.05; { Descuento Accesorios       }
    (* MinAcc       : single = 2000.00; { Para acceder al Descuento  } *)

var
    cod          : char;             { Código de Venta            }
    Monto        : single;           { Monto por artículo         }

    Cont         : byte;

    AcumVtaLibre : single;           { Acumula Venta Libre        }
    AcumVtaMed   : single;           { Acumula Venta Medicamentos }
    AcumVtaPer   : single;           { Acumula Venta Perfumeria   }
    AcumVtaAcc   : single;           { Acumula Venta Accesorios   }
    AcumVtaAccAux: single;           { Auxiliar   }

    BonifMed     : single;           { Bonificación Medicamentos  }
    BonifPer     : single;           { Bonificación Perfumería    }
    BonifAcc     : single;           { Bonificación Accesorios    }

    BonifTotal   : single;           { Bonificación Total         }

    arch         : text;

    N            : byte;             { Para las N ventas a leer   }
    i            : byte;
    X            : single;           { Importe Min para desc Acce }
    aux          : char;             { Para leer el espacio       }


begin
repeat
clrscr();

    { INICIALIZACION }
    Cont         := 0;
    AcumVtaLibre := 0;
    AcumVtaMed   := 0;
    AcumVtaPer   := 0;
    AcumVtaAcc   := 0;


    WriteLn('---------------------');
    WriteLn('   F A R M A C I A');
    WriteLn('---------------------');

    assign(arch, 'farmacia.txt');
    reset(arch);

    ReadLn(arch, N);
    ReadLn(arch, X);

    //WriteLn('N = ',N,' | X = ',X:5:2);
    WriteLn();



    for i:= 1 to N do begin
        ReadLn(arch, Monto,aux,Cod);
        case Cod of
            'L' :
                begin
                Cont := Cont + 1; { Para contar el total de operaciones en Venta Libre }
                AcumVtaLibre := AcumVtaLibre + Monto;

                TextColor(yellow);
                WriteLN(' Venta Libre     :  0.00% OFF');
                TextColor(white);
                WriteLn('   Importe FINAL                 : ', Monto:8:2);
                end;

            'M' :
                begin
                AcumVtaMed := AcumVtaMed + Monto;

                TextColor(yellow);
                WriteLn(' Medicamentos    : ', (DescMed*100):5:2, '% OFF');
                TextColor(white);
                WriteLn('   Importe       : ', Monto:8:2);
                WriteLn('   Descuento     : ', -(Monto * DescMed):8:2);
                WriteLn('   Importe FINAL                 : ', Monto * (1 - DescMed):8:2);
                end;

            'P' :
                begin
                AcumVtaPer := AcumVtaPer + Monto;

                TextColor(yellow);
                WriteLn(' Perfumeria      : ', (DescPer*100):5:2, '% OFF');
                TextColor(white);
                WriteLn('   Importe       : ', Monto:8:2);
                WriteLn('   Descuento     : ', -(Monto * DescPer):8:2);
                WriteLn('   Importe FINAL                 : ', Monto * (1 - DescPer):8:2);
                end;

            'A' :
                begin
                AcumVtaAcc := AcumVtaAcc + Monto;

                if (Monto > 0) and (Monto < X) then
                    begin
                    TextColor(yellow);
                    WriteLn(' Accesorios   MIN: $',X:4:0, ' | 0.00% OFF');
                    TextColor(white);
                    BonifAcc := 0;
                    WriteLn('   Importe FINAL                 : ', Monto:8:2);
                    end
                else
                    if (AcumVtaAcc >= X) then
                        begin
                        TextColor(yellow);
                        WriteLn(' Accesorios   MIN: $',X:4:0,' | ', (DescAcc*100):5:2, '% OFF');
                        TextColor(white);
                        WriteLn('   Importe       : ', Monto:8:2);
                        WriteLn('   Descuento     : ', -(Monto * DescAcc):8:2);
                        AcumVtaAccAux := AcumVtaAcc * (1 - DescAcc);   { Para facilitar Importe Total Final}
                        WriteLn('   Importe FINAL                 : ', Monto * (1 - DescAcc):8:2);
                        end;

                end;  {A}
        end; {case of}

    end; {for}
    close(arch);

    { CALCULOS }
    BonifMed   := AcumVtaMed * DescMed;
    BonifPer   := AcumVtaPer * DescPer;
    BonifAcc   := AcumVtaAcc * DescAcc;

    { SALIDA DE INFORMACION}
    TextColor(green);
    Write('ENTER para INFORME FINAL... ');
    TextColor(White);
    readLn();

    clrscr();
    WriteLn('---------------------');
    WriteLn('   I N F O R M E');
    WriteLn('---------------------------------------------');


    BonifTotal := BonifMed + BonifPer + BonifAcc;
    if BonifTotal > 0 then
        begin

        TextColor(cyan);
        Write('IMPORTE TOTAL BONIFICADO         ');
        TextColor(white);
        WriteLn(': ',BonifTotal:8:2);
        end;

    if Cont > 0 then
        begin
        WriteLn('---------------------------------------------');
        TextColor(cyan);
        WriteLn('VENTA LIBRE:');
        TextColor(white);
        WriteLn('  Total de Operaciones           : ', Cont:8);
        WriteLn('  Importe TOTAL                  : ', AcumVtaLibre:8:2);
        end;

    WriteLn('---------------------------------------------');
    TextColor(cyan);
    WriteLn('MONTO DE VENTA MAX Y RUBRO AL QUE PERTENENCE');
    TextColor(White);

    if (AcumVtaLibre > AcumVtaMed) and (AcumVtaLibre > AcumVtaPer) and (AcumVtaLibre > AcumVtaAcc) then
        WriteLn('  Venta Libre                    : ', AcumVtaLibre:8:2)
    else
        if (AcumVtaMed > AcumVtaPer) and (AcumVtaMed > AcumVtaAcc) then
            WriteLn('  Medicamentos                   : ', AcumVtaMed:8:2)
        else
            if AcumVtaPer > AcumVtaAcc then
                WriteLn('  Perfumeria                     : ', AcumVtaPer:8:2)
            else
                WriteLn('  Accesorios                     : ', AcumVtaAcc:8:2);
    WriteLn('---------------------------------------------');


    TextColor(cyan);
    WriteLn(' RESUMEN DE LAS VENTAS:');
    WriteLn();

    if AcumVtaLibre > 0 then
        begin
        TextColor(yellow);
        WriteLn(' Venta Libre     :  0.00% OFF');
        TextColor(white);
        WriteLn('   Importe FINAL                 : ', AcumVtaLibre:8:2);
        end;

    if AcumVtaMed > 0 then
        begin
        TextColor(yellow);
        WriteLn(' Medicamentos    : ', (0.23*100):5:2, '% OFF');
        TextColor(white);
        WriteLn('   Importe       : ', AcumVtaMed:8:2);
        WriteLn('   Descuento     : ', -(AcumVtaMed * 0.23):8:2);
        WriteLn('   Importe FINAL                 : ', AcumVtaMed * (1 - 0.23):8:2);
        end;

    if AcumVtaPer > 0 then
        begin
        TextColor(yellow);
        WriteLn(' Perfumeria      : ', (DescPer*100):5:2, '% OFF');
        TextColor(white);
        WriteLn('   Importe       : ', AcumVtaPer:8:2);
        WriteLn('   Descuento     : ', -BonifPer:8:2);
        WriteLn('   Importe FINAL                 : ', AcumVtaPer * (1 - DescPer):8:2);
        end;

    if (AcumVtaAcc > 0) and (AcumVtaAcc < X) then
        begin
        TextColor(yellow);
        WriteLn(' Accesorios   MIN: $',X:4:0, ' | 0.00% OFF');
        TextColor(white);
        BonifAcc := 0;
        WriteLn('   Importe FINAL                 : ', AcumVtaAcc:8:2);
        end
    else
        if (AcumVtaAcc >= X) then
            begin
            TextColor(yellow);
            WriteLn(' Accesorios   MIN: $',X:4:0,' | ', (DescAcc*100):5:2, '% OFF');
            TextColor(white);
            WriteLn('   Importe       : ', AcumVtaAcc:8:2);
            WriteLn('   Descuento     : ', -BonifAcc:8:2);
            AcumVtaAccAux := AcumVtaAcc * (1 - DescAcc);   { Para facilitar Importe Total Final}
            WriteLn('   Importe FINAL                 : ', AcumVtaAccAux:8:2);
            end;

    //WriteLn();
    WriteLn('                                  ----------');
    WriteLn(' IMPORTE TOTAL FINAL             : ', ((AcumVtaLibre)+(AcumVtaMed * (1 - DescMed))+(AcumVtaPer * (1 - DescPer))+(AcumVtaAccAux)):8:2);
    WriteLn('---------------------------------------------');

    //WriteLn();
    TextColor(green);
    Write('ENTER para reiniciar...');
    TextColor(white);
    ReadLn();
until FALSE;
end.