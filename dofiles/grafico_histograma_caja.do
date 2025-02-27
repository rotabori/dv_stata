** PROJECT: VISUALIZACION DATOS
** PROGRAM: grafico_distribucion.do
** PROGRAM TASK: GRAFICO DE BARRAS
** AUTHOR: RODRIGO TABORDA
** DATE CREATEC: 2025/02/10
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
** #10 ** LOAD DATA;
********************************************************************;

    use https://rodrigotaborda.com/ad/data/ee/encuesta_estudiantes_202510_old.dta;

********************************************************************;
** #20 ** GRAFICO BARRAS ICFES;
********************************************************************;

    histogram icfes
        ,
        title("")
        ytitle("")
        xtitle("")
        xsca(alt)
        percent
        xscale(range(280 570))
        xlabel(300(50)550)
        yscale(range(0 20))
        ylabel(5(5)18)
        ylabel(,labgap(-5) tposition(inside))
        name(hist_icfes, replace)
        ;

    graph hbox icfes
        ,
        ytitle("")
        fysize(25)
        yscale(range(280 570))
        ylabel(300(50)550)
        name(box_icfes, replace)
        ;

    graph combine
        hist_icfes
        box_icfes
        ,
        title(ICFES)
        cols(1)
        imargin(b=0 l+5 t=0)
        note(Nota: Histograma muestra el porcentaje.)
        ;
        graph export  ..\..\texto\figures\distribucion.eps, replace;
        graph export  ..\..\texto\figures\distribucion.jpg, replace;

    graph drop 
        hist_icfes
        box_icfes
        ;
