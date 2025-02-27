** PROJECT: VISUALIZACION DATOS
** PROGRAM: grafico_caja.do
** PROGRAM TASK: CAJA
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
** #20 ** GRAFICO CAJA;
********************************************************************;

    graph box icfes
        ,
        name(caja_icfes0, replace)
        ;

        graph export  ..\..\texto\figures\caja_icfes0.eps, replace;
        graph export  ..\..\texto\figures\caja_icfes0.jpg, replace;
        
    graph box icfes
        ,
        title("Distribución ICFES")
        name(caja_icfes1, replace)
        ;

        graph export  ..\..\texto\figures\caja_icfes1.eps, replace;
        graph export  ..\..\texto\figures\caja_icfes1.jpg, replace;

    graph box icfes
        ,
        over(genero_num)
        title("ICFES")
        subtitle("Distribución por género")
        name(caja_icfes2, replace)
        ;

        graph export  ..\..\texto\figures\caja_icfes2.eps, replace;
        graph export  ..\..\texto\figures\caja_icfes2.jpg, replace;

    generate icfes_hombre = icfes if genero_num == 0;
    generate icfes_mujer = icfes if genero_num == 1;

    graph box icfes_hombre icfes_mujer
        ,
        over(genero_num)
        title("ICFES")
        subtitle("Distribución por género")
        legend(row(1) label(1 "Hombres") label(2 "Mujeres") position(6))
        name(caja_icfes3, replace)
        ;




