** PROJECT: VISUALIZACION DATOS
** PROGRAM: grafico_distribucion.do
** PROGRAM TASK: HISTOGRAMA
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

    use https://rodrigotaborda.com/ad/data/ee/encuesta_estudiantes_202510_old.dta, clear;

********************************************************************;
** #20 ** GRAFICO HISTOGRAMA;
********************************************************************;

    histogram icfes
        ,
        name(hist_icfes0, replace)
        ;

        graph export  ..\..\texto\figures\hist_icfes0.eps, replace;
        graph export  ..\..\texto\figures\hist_icfes0.jpg, replace;
        
    histogram icfes
        ,
        title("Distribución ICFES")
        ytitle("Densidad")
        xtitle("")
        name(hist_icfes1, replace)
        ;

        graph export  ..\..\texto\figures\hist_icfes1.eps, replace;
        graph export  ..\..\texto\figures\hist_icfes1.jpg, replace;

    histogram icfes
        ,
        title("ICFES")
        subtitle("Distribución")
        ytitle("Porcentaje")
        xtitle("")
        percent
        width(10)
        name(hist_icfes2, replace)
        ;

        graph export  ..\..\texto\figures\hist_icfes2.eps, replace;
        graph export  ..\..\texto\figures\hist_icfes2.jpg, replace;

    twoway 
        (histogram icfes if genero_num==0, start(290) width(10) color(blue*2%30) percent)
        (histogram icfes if genero_num==1, start(290) width(10) color(pink*.4%30) percent)
        ,
        title("ICFES")
        subtitle("Distribución por género")
        ytitle("Porcentaje")
        legend(row(1) order(1 "Hombres" 2 "Mujeres" ) position(6))
        name(hist_icfes3, replace)
            ;

        graph export  ..\..\texto\figures\hist_icfes3.eps, replace;
        graph export  ..\..\texto\figures\hist_icfes3.jpg, replace;

    twoway
        (kdensity icfes if genero_num == 0, lcolor(blue*2))
        (kdensity icfes if genero_num == 1, lcolor(pink*.4))
        ,
        title("ICFES")
        subtitle("Distribución por género")
        ytitle("Densidad (Kernel)")
        legend(row(1) label(1 "Hombres") label(2 "Mujeres") position(6))
        name(hist_icfes4, replace)
        ;

        graph export  ..\..\texto\figures\hist_icfes4.eps, replace;
        graph export  ..\..\texto\figures\hist_icfes4.jpg, replace;
