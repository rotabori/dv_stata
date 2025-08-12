** PROJECT: VISUALIZACION DATOS
** PROGRAM: grafico_dispersión.do
** PROGRAM TASK: DISPERSIÓN
** AUTHOR: RODRIGO TABORDA
** DATE CREATEC: 2025/08/11
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

    use https://rodrigotaborda.com/ad/data/ee/encuesta_estudiantes_202520_old.dta, clear;

********************************************************************;
** #20 ** GRAFICO DISPERSIÓN;
********************************************************************;

    scatter peso estatura
        ,
        name(dispersion_pe0, replace)
        ;

*        graph export  ..\..\text\figures\dispersion_pe0.eps, replace;
*        graph export  ..\..\text\figures\dispersion_pe0.jpg, replace;

    twoway
    (scatter peso estatura if genero_num == 0)
    (scatter peso estatura if genero_num == 1)
        ,
        name(dispersion_pe1, replace)
        ;

*        graph export  ..\..\text\figures\dispersion_pe1.eps, replace;
*        graph export  ..\..\text\figures\dispersion_pe1.jpg, replace;

    twoway
    (scatter peso estatura if genero_num == 0, msymbol(Oh) mcolor(ltblue))
    (scatter peso estatura if genero_num == 1, msymbol(Oh) mcolor(pink))
        ,
        name(dispersion_pe2, replace)
        ;

        graph export  ..\..\text\figures\dispersion_pe2.eps, replace;
        graph export  ..\..\text\figures\dispersion_pe2.jpg, replace;

    twoway
    (scatter peso estatura if genero_num == 0, msymbol(Oh) mcolor(ltblue))
    (scatter peso estatura if genero_num == 1, msymbol(Oh) mcolor(pink))
        ,
        legend(order(1 "Hombre" 2 "Mujer") rows(1) position(6))
        name(dispersion_pe3, replace)
        ;

        graph export  ..\..\text\figures\dispersion_pe3.eps, replace;
        graph export  ..\..\text\figures\dispersion_pe3.jpg, replace;

    sum estatura if genero_num == 0;
        local estatura_0: di%3.2f = r(mean);
    sum estatura if genero_num == 1;
        local estatura_1: di%3.2f = r(mean);
    sum peso if genero_num == 0;
        local peso_0: di%3.2f = r(mean);
    sum peso if genero_num == 1;
        local peso_1: di%3.2f = r(mean);
    twoway
    (scatter peso estatura if genero_num == 0, msymbol(Oh) mcolor(ltblue))
    (scatter peso estatura if genero_num == 1, msymbol(Oh) mcolor(cranberry))
        ,
        ysize(5)
        ylabel(,nogrid)
        xlabel(,nogrid)
        title(Los hombres son más grandes)
        subtitle(Combinación de peso y estatura en estudiantes de pregrado de U.Andes)
        legend(order(1 "Hombre" 2 "Mujer") rows(1) position(6))
        note("La combinación de peso y estatura promedio para hombres es: `peso_0' Kg. - `estatura_0' Cm. y para" "mujeres es: `peso_1' Kg. - `estatura_1' Cm.")
        name(dispersion_pe4, replace)
        ;

        graph export  ..\..\text\figures\dispersion_pe4.eps, replace;
        graph export  ..\..\text\figures\dispersion_pe4.jpg, replace;

