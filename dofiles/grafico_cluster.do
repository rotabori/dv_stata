** PROJECT: VISUALIZACION DATOS
** PROGRAM: grafico_cluster.do
** PROGRAM TASK: DISPERSIÓN
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
** #10 ** LOAD DATA;
********************************************************************;

    use https://rodrigotaborda.com/ad/data/ee/encuesta_estudiantes_202520_old.dta, clear;

********************************************************************;
** #20 ** GRAFICO CLUSTER;
********************************************************************;

    scatter peso estatura
        ,
        msize(vsmall)
        ylabel(,nogrid)
        xlabel(,nogrid)
        legend(off)
        name(cluster_pe0, replace)
        ;

        graph export  ..\..\text\figures\cluster_pe0.eps, replace;
        graph export  ..\..\text\figures\cluster_pe0.jpg, replace;

    cluster wardslinkage peso estatura, name(pe_wl);

    cluster dendrogram pe_wl
        ,
        cutnumber(4)
        title("")
        ytitle("")
        showcount
        name(cluster_dnd_pe0, replace)
        ;

        graph export  ..\..\text\figures\cluster_dnd_pe0.eps, replace;
        graph export  ..\..\text\figures\cluster_dnd_pe0.jpg, replace;

    cluster generate pe_wl_g4 = groups(4), name(pe_wl);
        foreach num of numlist 1/4{;
            sum estatura if pe_wl_g4 == `num';
                local estatura_`num': di%3.2f = r(mean);
            sum peso if pe_wl_g4 == `num';
                local peso_`num': di%3.2f = r(mean);
            };

    twoway
    (scatter peso estatura if pe_wl_g4 == 1, mcolor(ltblue) msize(vsmall))
    (scatter peso estatura if pe_wl_g4 == 2, mcolor(cranberry) msize(vsmall))
    (scatter peso estatura if pe_wl_g4 == 3, mcolor(black) msize(vsmall))
    (scatter peso estatura if pe_wl_g4 == 4, mcolor(orange) msize(vsmall))
        ,
        ylabel(,nogrid)
        xlabel(,nogrid)
        legend(order(1 "G1" 2 "G2" 3 "G3" 4 "G4") rows(1) position(6))
        name(cluster_pe1, replace)
        ;

        graph export  ..\..\text\figures\cluster_pe1.eps, replace;
        graph export  ..\..\text\figures\cluster_pe1.jpg, replace;

    graph combine 
        cluster_dnd_pe0 cluster_pe1
        ,
        rows(1)
        name(cluster_pe_a, replace)
        ;

    graph combine 
        cluster_pe0 cluster_pe_a
        ,
        cols(1)
        ysize(6)
        xsize(8)
        title(Cluster)
        subtitle(Peso y estatura estudiantes de pregrado de U.Andes)
        note("Nota:"
             "Las combinaciones de peso y estatura promedio son: G1. `peso_1' Kg. - `estatura_1' Cm.; G2. `peso_2' Kg. - `estatura_2' Cm.;"
             "G3 `peso_3' Kg. - `estatura_3' Cm.; y G4 `peso_4' Kg. - `estatura_4' Cm."
             ,size(vsmall)
             )
        name(cluster_pe, replace)
        ;

        graph export  ..\..\text\figures\cluster_pe.eps, replace;
        graph export  ..\..\text\figures\cluster_pe.jpg, replace;
