(*

Una panadería vende sus productos por Kg., a los
siguientes valores:
    *Pan: $ 500
    *Masas: $ 1000
    *Tortas: $ 1500

Al final del día desea procesar todas las ventas realizadas, por cada una ingresa:
     Código de Producto: (P-Pan, M-Masas, T-Tortas, *-Fin de datos)
     Peso de la venta
     Tipo de Pago (E-Efectivo, T-Tarjeta)

Se pide leer todos los datos correspondientes a las ventas desde el archivo
“Panaderia.txt”, calcular e informar:
    a- Porcentaje de ventas en el día, efectivo y tarjeta por separado, sobre la
cantidad total de ventas.
    b- Cantidad de kilos de pan, de masas y de tortas, por separado.
    c- Importe de la venta máxima, aclarando si fue en efectivo o con tarjeta.

        MODELO panaderia.txt
            T 1 E
            M 2 E
            T 1.5 T
            P 2 E
            M 1.5 E
            T 3 T
            P 1 T
            *

*)
(*
Se pide leer todos los datos correspondientes a las ventas desde el archivo “Panaderia.txt”, calcular e informar:
    a- Porcentaje de ventas en el día, efectivo y tarjeta por separado, sobre la
cantidad total de ventas.
    b- Cantidad de kilos de pan, de masas y de tortas, por separado.
    c- Importe de la venta máxima, aclarando si fue en efectivo o con tarjeta.
*)

program Panaderia2;

var
    arch : text;

    AcumkiloPan, AcumkiloMasas, AcumkiloTortas,
    VtaMaxImporte, PesoVta : real;

    VtaMaxTipoPago : string;

    CodProd, TipoPago, aux : char;

    ContVtaEfe, ContVtaTar : byte;

begin
    AcumkiloPan    := 0;
    AcumkiloMasas  := 0;
    AcumkiloTortas := 0;

    ContVtaEfe     := 0;
    ContVtaTar     := 0;

    VtaMaxImporte := 0; { Valor Irrisorio. Si la Venta es cero es porque no hubo venta. }

    assign(arch, 'Panaderia.txt');

    WriteLn('-----------');
    WriteLn('V E N T A S');
    WriteLn('-----------');

    rewrite(arch);

    repeat
        Write('Codigo de Producto: (P-Pan, M-Masas, T-Tortas, *-Fin de datos): ');
        ReadLn(CodProd);
        CodProd := UpCase(CodProd);
    until (CodProd = 'P') or (CodProd = 'M') or (CodProd = 'T') or (CodProd = '*');
    Write(arch, CodProd);
    Write(arch, ' ');


    while CodProd <> '*' do
        begin
            repeat
                Write('Peso de la venta: ');
                ReadLn(PesoVta);
            until (PesoVta > 0);
            Write(arch, PesoVta:0:3);
            Write(arch, ' ');

            repeat
                Write('Tipo de Pago (E-Efectivo, T-Tarjeta): ');
                ReadLn(TipoPago);
                TipoPago := UpCase(TipoPago);
            until (TipoPago = 'E') or (TipoPago = 'T');
            WriteLn(arch, TipoPago);

            Writeln();
            repeat
                Write('Codigo de Producto: (P-Pan, M-Masas, T-Tortas, *-Fin de datos): ');
                ReadLn(CodProd);
                CodProd := UpCase(CodProd);
            until (CodProd = 'P') or (CodProd = 'M') or (CodProd = 'T') or (CodProd = '*');
            Write(arch, CodProd);
            Write(arch, ' ');
        end; {while}

    close(arch);


    { LECTURA Y PROCESAMIENTO DE ARCHIVO }
    reset(arch);

    ReadLn(arch, CodProd,PesoVta,aux,TipoPago);

    while CodProd <> '*' do
        begin

        if CodProd = 'P' then
            AcumKiloPan := AcumKiloPan + PesoVta;
            if ((PesoVta * 500) > VtaMaxImporte) then
                begin
                VtaMaxImporte := PesoVta * 500;
                VtaMaxTipoPago := TipoPago;
                end;

        if CodProd = 'M' then
            AcumKiloMasas := AcumKiloMasas + PesoVta;
            if ((PesoVta * 1000) > VtaMaxImporte) then
                begin
                VtaMaxImporte := PesoVta * 1000;
                VtaMaxTipoPago := TipoPago;
                end;
        if CodProd = 'T' then
            AcumKiloTortas := AcumKiloTortas + PesoVta;
            if ((PesoVta * 1500) > VtaMaxImporte) then
                begin
                VtaMaxImporte := PesoVta * 1500;
                VtaMaxTipoPago := TipoPago;
                end;

        if TipoPago = 'E' then
            ContVtaEfe := ContVtaEfe + 1
        else
            ContVtaTar := ContVtaTar + 1;

        ReadLn(arch, CodProd,PesoVta,aux,TipoPago);
        end; {while}


    close(arch);
    { SALIDAS DE INFORMACIÓN }

    WriteLn();
    WriteLn('a- Porcentaje de ventas en el dia, efectivo y tarjeta por separado, sobre la cantidad total de ventas.');
    WriteLn('  Porcentaje de Ventas en Efectivo: ', (ContVtaEfe * 100 / (ContVtaEfe + ContVtaTar)):0:2);
    WriteLn('  Porcentaje de Ventas en Tarjeta : ', (ContVtaTar * 100 / (ContVtaEfe + ContVtaTar)):0:2);

    WriteLn();
    WriteLn('b- Cantidad de kilos de pan, de masas y de tortas, por separado.');
    WriteLn('  Kilos Vendidos de Pan   : ', AcumkiloPan   :5:1);
    WriteLn('  Kilos Vendidos de Masas : ', AcumkiloMasas :5:1);
    WriteLn('  Kilos Vendidos de Tortas: ', AcumkiloTortas:5:1);

    WriteLn();
    WriteLn('c- Importe de la venta maxima, aclarando si fue en efectivo o con tarjeta.');
    WriteLn('  Venta Maxima: ', VtaMaxImporte:8:2, ' | Tipo de Pago: ', VtaMaxTipoPago);

    readln();

end.