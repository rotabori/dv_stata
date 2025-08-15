** PROJECT: VISUALIZACION DATOS
** PROGRAM: grafico_cluster.do
** PROGRAM TASK: REGRESION LINEAL
** AUTHOR: RODRIGO TABORDA
** DATE CREATEC: 2025/08/12
** DATE REVISION 1: 
** DATE REVISION #:

********************************************************************;
** #0
********************************************************************;

** PROGRAM SETUP

    pause on
    #delimit ;
        /*COMMAND LINES WILL ONLY END ONCE SEMICOLON IS FOUND*/;

** #0.1 ** SET PATH FOR READING/SAVING DATA;

********************************************************************;
** #10 ** SIMULATE DATA;
********************************************************************;

    clear;
    set obs 900;
    generate time=_n;
    format %td time;
    tsset time;

    set seed 12345;
    gen e1 = rnormal(0,1);
        label var e1 "e1 N(0,1)";

    local b0 = .3 /*COEFICIENTE CONSTANTE.*/;
    local b1 = .98 /*COEFICIENTE PENDIENTE. REEMPLAZAR CON VALOR MENOR A 1*/;
    local b2 = .001 /*COEFICIENTE TENDENCIA*/;

    generate y = .;
    replace y = e1 in 1;
    replace y = `b0' + `b1' * l.y + `b2' * time + e1 in 2/l;
    
    drop in 1/30;

********************************************************************;
** #20 ** GRAFICO SERIE TIEMPO;
********************************************************************;

    tsline y
        ,
        lcolor(ltblue)
        ylabel(,nogrid)
        xlabel(,nogrid)
        ytitle("")
        ttitle("")
        ttick(01jan1960(92)30jun1962) 
        tlabel(01jan1960(368)30jun1962, format(%tdCCYY))
        name(serie_tiempo_0, replace)
        ;

    reg y time;
        predict y_trend, xb;
        predict y_notrend, residuals;

    tsline y y_trend
        ,
        lcolor(ltblue black)
        legend(off)
        ylabel(,nogrid)
        xlabel(,nogrid)
        ttitle("")
        ttick(01jan1960(92)30jun1962) 
        tlabel(01jan1960(368)30jun1962, format(%tdCCYY))
        name(serie_tiempo_1, replace)
        ;

    tsline y_notrend
        ,
        lcolor(ltblue)
        ytitle("")
        ylabel(,nogrid)
        xlabel(,nogrid)
        ttitle("")
        ttick(01jan1960(92)30jun1962) 
        tlabel(01jan1960(368)30jun1962, format(%tdCCYY))
        name(serie_tiempo_2, replace)
        ;

    tssmooth dexponential y_ewma08 = y_notrend, parms(.2);

    tsline y_notrend y_ewma08
        ,
        lcolor(ltblue black)
        legend(off)
        ylabel(,nogrid)
        xlabel(,nogrid)
        ttitle("")
        ttick(01jan1960(92)30jun1962) 
        tlabel(01jan1960(368)30jun1962, format(%tdCCYY))
        name(serie_tiempo_3, replace)
        ;

    gen y_notrend_nocicle = y_notrend - y_ewma08;

    tsline y_notrend_nocicle
        ,
        lcolor(ltblue)
        legend(off)
        ytitle("")
        ylabel(,nogrid)
        xlabel(,nogrid)
        yline(0)
        ttitle("")
        ttick(01jan1960(92)30jun1962) 
        tlabel(01jan1960(368)30jun1962, format(%tdCCYY))
        name(serie_tiempo_4, replace)
        ;

    graph combine
        serie_tiempo_0
        serie_tiempo_1
        ,
        cols(1)
        ysize(5)
        xsize(8)
        title(Serie de tiempo)
        subtitle("Tendencia")
        iscale(*.9)
        name(serie_tiempo, replace)
        ;

        graph export  ..\..\text\figures\serie_tiempo_tendencia.eps, replace;
        graph export  ..\..\text\figures\serie_tiempo_tendencia.jpg, replace;

    graph combine
        serie_tiempo_2
        serie_tiempo_3
        ,
        cols(1)
        ysize(5)
        xsize(8)
        title(Serie de tiempo)
        subtitle("Ciclo")
        iscale(*.9)
        name(serie_tiempo, replace)
        ;

        graph export  ..\..\text\figures\serie_tiempo_ciclo.eps, replace;
        graph export  ..\..\text\figures\serie_tiempo_ciclo.jpg, replace;

    graph combine
        serie_tiempo_0
        serie_tiempo_4
        ,
        cols(1)
        ysize(5)
        xsize(8)
        title(Serie de tiempo)
        subtitle("Ruido")
        iscale(*.9)
        name(serie_tiempo, replace)
        ;

        graph export  ..\..\text\figures\serie_tiempo_ruido.eps, replace;
        graph export  ..\..\text\figures\serie_tiempo_ruido.jpg, replace;

    graph combine
        serie_tiempo_0
        serie_tiempo_1
        serie_tiempo_2
        serie_tiempo_3
        serie_tiempo_4
        ,
        cols(1)
        ysize(10)
        xsize(8)
        title(Serie de tiempo)
        subtitle("Descomposición")
        iscale(*.9)
        name(serie_tiempo_todas, replace)
        ;

        graph export  ..\..\text\figures\serie_tiempo_todas.eps, replace;
        graph export  ..\..\text\figures\serie_tiempo_todas.jpg, replace;
