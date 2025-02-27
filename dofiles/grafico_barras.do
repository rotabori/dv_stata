** PROJECT: VISUALIZACION DATOS
** PROGRAM: grafico_barras.do
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

    use https://rodrigotaborda.com/ad/data/ee/encuesta_estudiantes_202510_old.dta, clear;

********************************************************************;
** #20 ** GRAFICO BARRAS ICFES;
********************************************************************;

    graph bar icfes, over(hermanos_nro) name(barras_0, replace);
        graph export  ..\..\texto\figures\barras_0.eps, replace;

    graph bar icfes, over(hermanos_nro) exclude0 name(barras_1, replace);

    graph bar icfes, over(hermanos_nro) exclude0 ylabel(350(10)400) name(barras_2, replace);

    graph bar icfes, over(hermanos_nro) 
        exclude0 
        ylabel(350(10)400) 
        title(Icfes) 
        subtitle(Según número de hermanos)
        ytitle(Promedio)
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_3, replace)
        ;

    graph bar icfes, over(hermanos_nro) 
        blabel(bar, position(outside) format(%5.0f))
        exclude0 
        ylabel(350(10)400) 
        title(Icfes) 
        subtitle(Según número de hermanos)
        ytitle(Promedio)
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_4, replace)
        ;

    graph bar icfes, over(hermanos_nro, sort(1)) 
        blabel(bar, position(outside) format(%5.0f))
        exclude0 
        ylabel(350(10)400) 
        title(Icfes) 
        subtitle(Según número de hermanos)
        ytitle(Promedio)
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_5, replace)
        ;

    graph bar icfes, over(hermanos_nro, sort(1) reverse) 
        blabel(bar, position(outside) format(%5.0f))
        exclude0 
        ylabel(350(10)400) 
        title(Icfes) 
        subtitle(Según número de hermanos)
        ytitle(Promedio)
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_6, replace)
        ;

    graph bar icfes, over(genero) over(hermanos_nro, sort(icfes) reverse) 
        blabel(bar, position(outside) format(%5.0f))
        exclude0 
        ylabel(350(10)400) 
        title(Icfes) 
        subtitle(Según número de hermanos)
        ytitle(Promedio)
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_7, replace)
        ;

    graph bar icfes, over(genero) over(hermanos_nro) 
        blabel(bar, position(outside) format(%5.0f))
        exclude0 
        ylabel(350(10)400) 
        title(Icfes) 
        subtitle(Según número de hermanos)
        ytitle(Promedio)
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_8, replace)
        ;

    graph bar icfes, over(genero, gap(*1.2) label(angle(35))) over(hermanos_nro, sort(icfes) reverse) 
        blabel(bar, position(outside) format(%5.0f))
        exclude0 
        ylabel(350(10)400) 
        title(Icfes) 
        subtitle(Según número de hermanos)
        ytitle(Promedio)
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_9, replace)
        ;
        graph export  ..\..\texto\figures\barras_9.eps, replace;

    graph bar icfes, over(genero, gap(*1.2) label(angle(35)) sort(icfes) reverse) over(hermanos_nro, sort(icfes) reverse) 
        blabel(bar, position(outside) format(%5.0f))
        exclude0 
        ylabel(350(10)400) 
        title(Icfes) 
        subtitle(Según número de hermanos)
        ytitle(Promedio)
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_91, replace)
        ;
        graph export  ..\..\texto\figures\barras_91.eps, replace;

    generate icfes_hombre = icfes if genero_num == 0;
    generate icfes_mujer = icfes if genero_num == 1;

    graph bar icfes_hombre icfes_mujer, over(hermanos_nro, sort(icfes) reverse) 
        blabel(bar, position(outside) format(%5.0f))
        bar(1, color(blue*2)) bar(2, color(pink*.4))
        intensity(*.5)
        exclude0 
        ylabel(350(10)400) 
        title(Icfes) 
        subtitle(Según número de hermanos)
        ytitle(Promedio)
        legend(label(1 "Hombre") label(2 "Mujer") position(1) ring(0))
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_92, replace)
        ;
        graph export  ..\..\texto\figures\barras_92.eps, replace;

    graph bar icfes_hombre icfes_mujer, over(date_year, sort(icfes) reverse) 
        blabel(bar, position(outside) format(%5.0f))
        bar(1, color(blue*2)) bar(2, color(pink*.4))
        intensity(*.5)
        exclude0
        ylabel(350(10)400)
        title(Icfes)
        subtitle(Año)
        ytitle(Promedio)
        legend(label(1 "Hombre") label(2 "Mujer") position(1) ring(0))
        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
        name(barras_93, replace)
        ;
        graph export  ..\..\texto\figures\barras_93.eps, replace;

*    Graph hbar icfes, over(genero, gap(*.5)) over(hermanos_nro, sort(icfes) reverse) 
*        blabel(bar, position(outside) format(%5.0f))
*        exclude0 
*        ylabel(350(10)400) 
*        title(Icfes) 
*        subtitle(Según número de hermanos)
*        ytitle(Promedio)
*        caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
*        name(barras_10, replace)
*        ;
