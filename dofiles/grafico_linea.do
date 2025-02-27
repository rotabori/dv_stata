** PROJECT: VISUALIZACION DATOS
** PROGRAM: grafico_linea.do
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
** #20 ** GRAFICO LINEA TIEMPO ICFES;
********************************************************************;

    preserve;
        collapse (mean) icfes, by(date_year);
        twoway line icfes date_year, sort name(linea_0, replace);
            graph export  ..\..\texto\figures\linea_0.eps, replace;
        twoway connected icfes date_year, sort name(linea_1, replace);
            graph export  ..\..\texto\figures\linea_1.eps, replace;
        twoway connected icfes date_year, sort msymbol(C) mfcolor(white) name(linea_2, replace);
            graph export  ..\..\texto\figures\linea_2.eps, replace;
    restore;

    preserve;
        collapse (mean) icfes, by(genero_num date_year);
        reshape wide icfes, i(date_year) j(genero_num);

        twoway connected icfes0 icfes1 date_year, sort name(linea_3, replace);
            graph export  ..\..\texto\figures\linea_3.eps, replace;

        twoway connected icfes0 icfes1 date_year, sort msymbol(O O) mfcolor(white) name(linea_4, replace);
            graph export  ..\..\texto\figures\linea_4.eps, replace;

        twoway connected icfes0 icfes1 date_year
            ,
            sort 
            msymbol(O O) 
            mfcolor(white white) 
            mcolor(blue*2 pink*.4)
            lcolor(blue*2 pink*.4)
            name(linea_5, replace)
            ;
            graph export  ..\..\texto\figures\linea_5.eps, replace;

        twoway connected icfes0 icfes1 date_year
            ,
            sort 
            msymbol(O O) 
            mfcolor(white white) 
            mcolor(blue*2 pink*.4)
            lcolor(blue*2 pink*.4)
            title(Icfes) 
            subtitle(Año)
            ytitle(Promedio)
            legend(label(1 "Hombre") label(2 "Mujer") position(1) ring(0))
            caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
            name(linea_6, replace)
            ;
            graph export  ..\..\texto\figures\linea_6.eps, replace;

        twoway 
            (connected icfes0 icfes1 date_year if date_year <= 2022
                ,
                sort
                msymbol(O O) 
                mfcolor(white white) 
                mcolor(blue*2 pink*.4)
                lcolor(blue*2 pink*.4)
                )
            (connected icfes0 icfes1 date_year if date_year >= 2022
                ,
                sort
                msymbol(O O) 
                mfcolor(none none) 
                mcolor(none none) 
                lcolor(none none)
                )
            ,
            title(Icfes) 
            subtitle(Año)
            ytitle(Promedio)
            legend(order(1 2) label(1 "Hombre") label(2 "Mujer") position(1) ring(0))
            caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
            name(linea_61, replace)
            ;
            graph export  ..\..\texto\figures\linea_61.eps, replace;

        twoway 
            (connected icfes0 icfes1 date_year if date_year >= 2022
                ,
                sort
                msymbol(O O) 
                mfcolor(white white) 
                mcolor(blue*2 pink*.4)
                lcolor(blue*2 pink*.4)
                )
            (connected icfes0 icfes1 date_year if date_year <= 2022
                ,
                sort
                msymbol(O O) 
                mfcolor(none none) 
                mcolor(none none) 
                lcolor(none none)
                )
            ,
            title(Icfes) 
            subtitle(Año)
            ytitle(Promedio)
            legend(order(1 2) label(1 "Hombre") label(2 "Mujer") position(1) ring(0))
            caption(Fuente: Encuesta estudiantes Rodrigo Taborda. 2025-10. Universidad de los Andes.)
            name(linea_62, replace)
            ;
            graph export  ..\..\texto\figures\linea_62.eps, replace;


    restore;
