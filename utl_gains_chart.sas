
*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

   Download tut_fakdat.sas7bdat from my files tut_fakdat

   put in d:\tut\tut.fakdat.sas7bdat

   create d:\tut\xls\  ( this is where  d:\tut\xls\utl_ganrpt.xls will go)

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;


Steps to gains table

The gains table only needs three inputs which are in the file

   tut_fakdata.sas7bdat

   response
   score
   decile

I am running SAS 9.4M2 64bit and Win 7 enterprise 64bit

1. Download tut_fakdat.sas7bdat from my files tut_fakdat
2. Compile the two utility macros or place in autocall library
   utlfkil.sas - delete a file
   utl_odsxls100.sas - template
3. Compile the utl_gain macro or put in your autocall library
   call the macro. Sample invocation is in the SAS macro program
*/

* Invoation;

libname tut "d:/tut";

%utl_gain(
       inp      = tut.tut_fakdat    /* input data */
      ,out      = tut_gain          /* outpt SAS dataset matches excel output */
      /* input variables */
      ,score    = score             /* probability of a stroke or heart attack */
      ,ptile    = deciles
      ,response = response

      ,excel    = d:\tut\xls\utl_ganrpt.xls  /* excel output */

      ,line1    = 'Index and Gains Table for Overall Stroke and Heart Attack Risk'
      ,line2    = 'The Overall Percentage of Patients with a Stroke or Heart Attack is 1.4794%'
      ,line3    = 'The index is the Percent Response in the Decile divided by the Overall Response.'
      ,line4    = 'For instance for the top decile the Index=11.330/1.4794 or 7.66'
      ,line5    = 'Patients in the top Decile are 7.7 times as likely to have a Stroke or Heart Attack '
      ,line6    = 'Average score times decile total is roughly equal to the Stroke or Heat Attack count'
    );

%macro utl_gain
   (
     inp      =   /* input dataset vars=group(decile Deciles) 0 to 9 with 0 having highest score */
    ,score    =   /* scores 0-1                                                                  */
    ,out      =   /* output dataset                                                              */
    ,ptile    =   /* groupings - Deciles                                                         */
    ,response =   /* response variable 0/1                                                       */
    ,excel    =   /* c:\tut\xls\utl_ganrpt.xls                                                   */
    ,line1    =   "Index and Gains Table for Overall Response"
    ,line2    =   "The Overall Percentage of Patients with a Stroke or Heart Attack is 1.4794%"
    ,line3    =   "The index is the Percent Response in the Decile divided by the Overall Response."
    ,line4    =   "For instance for the top decile the Index=11.1482/1.4794 or 7.536"
    ,line5    =   "Patients in the top Decile are almost 8 times as likely to have a Stroke or Heart Attack "
    ,line6    =   "The average score times the decile total should roughly equal to the number of patients with a Stroke or Heat Attack"
    ,line7    =   "The average score times the decile total should roughly equal to the number of patients with a Stroke or Heat Attack"

   )/des="Gains and Index Table";

     /*
     if running without macro

     %let  inp      = tut.tut_fakdat                                                                           ;
     %let  score    = score                                                                                    ;
     %let  out      = tut_gain                                                                                 ;
     %let  ptile    = deciles                                                                                  ;
     %let  response = response                                                                                 ;
     %let  excel    = c:\tut\xls\utl_ganrpt.xls                                                                ;
     %let  line1    = 'Index and Gains Table for Overall Stroke and Heart Attack Risk'                         ;
     %let  line2    = 'The Overall Percentage of Patients with a Stroke or Heart Attack is 1.4794%'            ;
     %let  line3    = 'The index is the Percent Response in the Decile divided by the Overall Response.'       ;
     %let  line4    = 'For instance for the top decile the Index=11.330/1.4794 or 7.66'                        ;
     %let  line5    = 'Patients in the top Decile are 7.7 times as likely to have a Stroke or Heart Attack '   ;
     %let  line6    = 'Average score times decile total is roughly equal to the Stroke or Heat Attack count'   ;

     */

    * check for blank arguments;

    %put %sysfunc(ifc(%sysevalf(%superq(inp     )=,boolean),**** Please Provide Input dataset        ****,));
    %put %sysfunc(ifc(%sysevalf(%superq(score   )=,boolean),**** Please Provide Soce variable        ****,));
    %put %sysfunc(ifc(%sysevalf(%superq(out     )=,boolean),**** Please Provide Output Dataset       ****,));
    %put %sysfunc(ifc(%sysevalf(%superq(ptile   )=,boolean),**** Please Provide an Decile Variable   ****,));
    %put %sysfunc(ifc(%sysevalf(%superq(response)=,boolean),**** Please Provide an Response Variable ****,));
    %put %sysfunc(ifc(%sysevalf(%superq(excel   )=,boolean),**** Please Provide Excel output         ****,));
    %put %sysfunc(ifc(%sysevalf(%superq(line1   )=,boolean),**** Please Provide 1st Tile Line        ****,));
    %put %sysfunc(ifc(%sysevalf(%superq(line2   )=,boolean),**** Please Provide 2nd Title line       ****,));

    %let res= %eval
    (
        %sysfunc(ifc(%sysevalf(%superq(inp      )=,boolean),1,0))
      + %sysfunc(ifc(%sysevalf(%superq(score    )=,boolean),1,0))
      + %sysfunc(ifc(%sysevalf(%superq(out      )=,boolean),1,0))
      + %sysfunc(ifc(%sysevalf(%superq(ptile    )=,boolean),1,0))
      + %sysfunc(ifc(%sysevalf(%superq(response )=,boolean),1,0))
      + %sysfunc(ifc(%sysevalf(%superq(excel    )=,boolean),1,0))
      + %sysfunc(ifc(%sysevalf(%superq(line1    )=,boolean),1,0))
      + %sysfunc(ifc(%sysevalf(%superq(line2    )=,boolean),1,0))
    );

     %if &res = 0 %then %do;

        * Decile stats;
        proc sql noprint;

          select
              count(*)
             ,sum(&response)
             ,sum(&response=0)
          into
              :CntTot    separated by ''   /* sep by to strip macro var */
             ,:RspTot    separated by ''
             ,:NonRspTot separated by ''
          from
             &inp;

          create
            table utl_rspcnt as
          select
            max(&score)          as ScoMax
           ,min(&score)          as ScoMin
           ,mean(&score)         as ScoAvg
           ,sum(&response=0)     as RspNon
           ,sum(&response)       as Rsp
           ,count(*)             as RnkCnt
           ,100 * (calculated Rsp/calculated RnkCnt)      as RspPctTotRnk
           ,100 * (calculated Rsp/&RspTot)                as RspPctTotRsp
           ,calculated RspPctTotRnk/(100*&RspTot/&CntTot) as Idx
          from
            &inp
          group
            by &ptile
          order
            by &ptile

        ;quit;

        /*
        Up to 40 obs WORK.UTL_RSPCNT total obs=8

        Obs     SCOMAX     SCOMIN      SCOAVG    RSPNON     RSP    RNKCNT    RSPPCTTOTRNK    RSPPCTTOTRSP      IDX

         1     0.96637    0.020337    0.10523      9859    1237     11096       11.1482         75.6112      7.53578
         2     0.02029    0.007936    0.01185     10882     175     11057        1.5827         10.6968      1.06986
         3     0.00794    0.005341    0.00631     10570      93     10663        0.8722          5.6846      0.58956
         4     0.00534    0.004390    0.00472     14635      89     14724        0.6045          5.4401      0.40859
         5     0.00439    0.004012    0.00427      7545      42      7587        0.5536          2.5672      0.37420
         6     0.00400    0.003047    0.00337     10931       0     10931        0.0000          0.0000      0.00000
         7     0.00304    0.002814    0.00287     12284       0     12284        0.0000          0.0000      0.00000
         8     0.00273    0.002705    0.00272     32246       0     32246        0.0000          0.0000      0.00000
         */

        * cumulative stats;
        data utl_cum;
         retain Rnk ScoMax ScoAvg ScoMin RnkCnt RnkCntCum RnkCntCumPct
                RspNon RspNonCum Rsp RspCum RspPctTotRsp RspPctTotRspCum RspPctTotRnk
                RspPctTotRnkcum Idx Gan;
        format
          SCOMAX  SCOAVG  SCOMIN 6.3 RNKCNTCUMPCT 3. RSPPCTTOTRSP RSPPCTTOTRSPCUM RSPPCTTOTRNK RSPPCTTOTRNKCUM 7.2  IDX   GAN  7.2;
        label
           Rnk               =  "Decile                                             "
           ScoMax            =  "Max+Score                                        "
           ScoAvg            =  "Average+Score                                    "
           ScoMin            =  "Minimum+Score                                    "
           RnkCnt            =  "Decile+Count                                       "
           RnkCntCum         =  "Cumulative+Decile+Count                            "
           RnkCntCumPct      =  "Cumulative+Decile+Percent                          "
           RspNon            =  "Non-+Responders                                  "
           RspNonCum         =  "Cumulative+Non-+Responders                       "
           Rsp               =  "Responders                                       "
           RspCum            =  "Cumulative+Decile+Count                            "
           RspPctTotRsp      =  "Responder+Percent+of Total+Response              "
           RspPctTotRspCum   =  "Cumulative+Responder+Percent+Total+Response      "
           RspPctTotRnk      =  "Responder+Responder+Percent+of Decile+Total        "
           RspPctTotRnkcum   =  "Cumulative+Responder+Percent+of Decile+Total       "
           Idx               =  "Unitless+Index+Decile Response/+Overall+Response   "
           Gan               =  "Gain+Response-+Overall Response/+Overall Response";

           set utl_rspcnt;

           RnkCntCum        + RnkCnt;
           RnkCntCumPct     = 100*(RnkCntCum/&CntTot);

           RspNonCum        + RspNon;
           RspCum           + Rsp;

           RspPctTotRnkCum  = 100*RspCum/RnkCntCum;
           RspPctTotRspCum  + RspPctTotRsp;

           Gan              = (RspPctTotRnkCum/100) / (&RspTot/&CntTot);

           Rnk=_n_;

           OneVal=1;

           Decile = Rnk;

        run;

        /*

        Middle Observation(4 ) of Last dataset = WORK.UTL_CUM - Total Obs 8

         -- NUMERIC --
        RNK                  N    8       4                   Decile
        SCOMAX               N    8       0.0053390215        Max+Score
        SCOAVG               N    8       0.0047175046        Average+Score
        SCOMIN               N    8       0.0043901185        Minimum+Score
        RNKCNT               N    8       14724               Decile+Count
        RNKCNTCUM            N    8       47540               Cumulative+Decile+Count
        RNKCNTCUMPCT         N    8       42.988389337        Cumulative+Decile+Percent
        RSPNON               N    8       14635               Non-+Responders
        RSPNONCUM            N    8       45946               Cumulative+Non-+Responders
        RSP                  N    8       89                  Responders
        RSPCUM               N    8       1594                Cumulative+Decile+Count
        RSPPCTTOTRSP         N    8       5.4400977995        Responder+Percent+of Total+Response
        RSPPCTTOTRSPCUM      N    8       97.432762836        Cumulative+Responder+Percent+Total+Response
        RSPPCTTOTRNK         N    8       0.6044553111        Responder+Responder+Percent+of Decile+Total
        RSPPCTTOTRNKCUM      N    8       3.3529659234        Cumulative+Responder+Percent+of Decile+Total
        IDX                  N    8       0.4085910999        Unitless+Index+Decile Response/+Overall+Response
        GAN                  N    8       2.2664901928        Gain+Response-+Overall Response/+Overall Response
        ONEVAL               N    8       1                   ONEVAL
        DECILE               N    8       4                   DECILE
        */

      %utl_xlslan100;

      %utlfkil(&excel);
      ods listing close;
      ods escapechar='^';
      ods excel file="&excel" style=utl_xlslan100
      options
       (
      /* start_at                   = "D3"    messes up autofilter? and other stuff */
         tab_color                  = "yellow"
      /* autofilter                 = 'yes'     */
         orientation                = 'landscape'
         zoom                       = "100"
         suppress_bylines           = 'no'
         embedded_titles            = 'yes'
         embedded_footnotes         = 'yes'
         embed_titles_once          = 'yes'
         gridlines                  = 'yes'
      /* frozen_headers             = 'Yes'
         absolute_column_width      =  "30pct,22pct,22pct,23pct" not needed
         frozen_rowheaders          = 'yes'                                 */
        );
    ;run;quit;

    ods excel options(sheet_name="utl_ganrpt" sheet_interval="none");

        title;footnote;
        proc report data=utl_cum nowd missing split='+'
            style(header)={font_size=13pt just=left font_face=Times}
            style(column)={font_size=11pt font_face=Times }
        ;
        cols
          (
           "%sysfunc(dequote(&line1))^{newline 2}
            %sysfunc(dequote(&line2))^{newline 1}
            %sysfunc(dequote(&line3))^{newline 1}
            %sysfunc(dequote(&line4))^{newline 1}
            %sysfunc(dequote(&line5))^{newline 1}
            %sysfunc(dequote(&line6))^{newline 1}  ^{newline 1}"
             Decile
            ( "Probabilities"
             ScoMax
             ScoAvg
             ScoMin
            )
            ( "Decile Stats"
             RnkCnt
             RnkCntCum
             RnkCntCumPct
            )
            ( "Response and Non Response Counts"
             RspNon
             RspNonCum
             Rsp
             RspCum
            )
            ( "Percents"
             RspPctTotRsp
             RspPctTotRspCum
             RspPctTotRnk
             RspPctTotRnkcum
            )
            ( "Index and Gain"
             Idx
             Gan
            )
           );
        define Decile            / display "Decile                             " style={just=right tagattr='format:##0' cellwidth=0.7in};
        define ScoMax            / display "Max+Score                          " style={just=right tagattr='format:0.####0' cellwidth=0.7in};
        define ScoAvg            / display "Mean+Score                      " style={just=right tagattr='format:0.####0' cellwidth=0.7in};
        define ScoMin            / display "Min+Score                      " style={just=right tagattr='format:0.####0' cellwidth=0.7in};
        define RnkCnt            / display "Decile+Count                       " style={just=right tagattr='format:###,##0' cellwidth=0.7in};
        define RnkCntCum         / display "Cum+Decile+Count                   " style={just=right tagattr='format:###,##0' cellwidth=0.7in};
        define RnkCntCumPct      / display "Cum+Decile+Percent                 " style={just=right tagattr='format:###,##0' cellwidth=0.7in};
        define RspNon            / display "Healthy+Patients                   " style={just=right tagattr='format:###,##0' cellwidth=0.7in};
        define RspNonCum         / display "Cum+Healthy+Patients               " style={just=right tagattr='format:###,##0' cellwidth=0.7in};
        define Rsp               / display "Stroke+Heart+Attack                " style={just=right tagattr='format:###,##0' cellwidth=0.7in};
        define RspCum            / display "Cum+Stroke+Heart+Attack            " style={just=right tagattr='format:###,##0' cellwidth=0.7in};
        define RspPctTotRsp      / display "Stroke+Heart+Attack+Percent+of Total+Stroke+Heart+Attack" style={just=right tagattr='format:##0.#0' cellwidth=0.7in};
        define RspPctTotRspCum   / display "Stroke+Heart+Attack+Percent+Total+Response "              style={just=right tagattr='format:##0.#0' cellwidth=0.7in};
        define RspPctTotRnk      / display "Stroke+Heart+Attack+Percent+of Decile+Total             " style={just=right tagattr='format:##0.#0' cellwidth=0.7in};
        define RspPctTotRnkcum   / display "Cum+Stroke+Heart+Attack+Percent+of Decile+Totals "        style={just=right tagattr='format:##0.#0' cellwidth=0.7in};
        define Idx               / display "Index"      style={just=right tagattr='format:##0.##0' cellwidth=0.7in};
        define Gan               / display "Cum+Index"  style={just=right tagattr='format:##0.##0' cellwidth=0.7in};

        run;quit;

        ods excel close;

     %end;

%mend utl_gain;

%utl_gain(
       inp      = tut.tut_fakdat
      ,score    = score
      ,out      = tut_gain
      ,ptile    = deciles
      ,response = response
      ,excel    = c:\tut\xls\utl_ganrpt.xls
      ,line1    = 'Index and Gains Table for Overall Stroke and Heart Attack Risk'
      ,line2    = 'The Overall Percentage of Patients with a Stroke or Heart Attack is 1.4794%'
      ,line3    = 'The index is the Percent Response in the Decile divided by the Overall Response.'
      ,line4    = 'For instance for the top decile the Index=11.330/1.4794 or 7.66'
      ,line5    = 'Patients in the top Decile are 7.7 times as likely to have a Stroke or Heart Attack '
      ,line6    = 'Average score times decile total is roughly equal to the Stroke or Heat Attack count'
    );

* Here are the two macros you need to run the above;


%macro utlfkil
    (
    utlfkil
    ) / des="delete an external file";


    /*-------------------------------------------------*\
    |                                                   |
    |  Delete an external file                          |
    |   From SAS macro guide                                                |
    |  Sample invocations                               |
    |                                                   |
    |  WIN95                                            |
    |  %utlfkil(c:\dat\utlfkil.sas);                    |
    |                                                   |
    |                                                   |
    |  Solaris 2.5                                      |
    |  %utlfkil(/home/deangel/delete.dat);              |
    |                                                   |
    |                                                   |
    |  Roger DeAngelis                                  |
    |                                                   |
    \*-------------------------------------------------*/

    %local urc;

    /*-------------------------------------------------*\
    | Open file   -- assign file reference              |
    \*-------------------------------------------------*/

    %let urc = %sysfunc(filename(fname,%quote(&utlfkil)));

    /*-------------------------------------------------*\
    | Delete file if it exits                           |
    \*-------------------------------------------------*/

    %if &urc = 0 and %sysfunc(fexist(&fname)) %then
        %let urc = %sysfunc(fdelete(&fname));

    /*-------------------------------------------------*\
    | Close file  -- deassign file reference            |
    \*-------------------------------------------------*/

    %let urc = %sysfunc(filename(fname,''));

  run;

%mend utlfkil;
%Macro utl_odsxls100
    (
      style=utl_odsxls100
      ,frame=box
      ,TitleFont=9pt
      ,docfont=9pt
      ,fixedfont=8pt
      ,rules=ALL
      ,bottommargin=.25in
      ,topmargin=.25in
      ,rightmargin=.25in
      ,leftmargin=.25in
      ,cellheight=13pt
      ,cellpadding = 2pt
      ,cellspacing = .2pt
      ,borderwidth = .2pt
      ,outputwidth = 1000px
    ) /  Des="SAS PDF Template for PDF";

ods path work.templat(update) sasuser.templat(update) sashelp.tmplmst(read);

Proc Template;

   define style &Style;
   parent=styles.rtf;

        replace body from Document /

               protectspecialchars=off
               asis=on
               bottommargin=&bottommargin
               topmargin   =&topmargin
               rightmargin =&rightmargin
               leftmargin  =&leftmargin
               ;

        replace color_list /
              'link' = blue
               'bgH'  = _undef_
               'fg'  = black
               'bg'   = _undef_;

        replace fonts /
               'TitleFont2'           = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'TitleFont'            = ("Arial, Helvetica, Helv",&titlefont,Bold)

               'HeadingFont'          = ("Arial, Helvetica, Helv",&titlefont)
               'HeadingEmphasisFont'  = ("Arial, Helvetica, Helv",&titlefont,Italic)

               'StrongFont'           = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'EmphasisFont'         = ("Arial, Helvetica, Helv",&titlefont,Italic)

               'FixedFont'            = ("Courier New, Courier",&fixedfont)
               'FixedEmphasisFont'    = ("Courier New, Courier",&fixedfont,Italic)
               'FixedStrongFont'      = ("Courier New, Courier",&fixedfont,Bold)
               'FixedHeadingFont'     = ("Courier New, Courier",&fixedfont,Bold)
               'BatchFixedFont'       = ("Courier New, Courier",&fixedfont)

               'docFont'              = ("Arial, Helvetica, Helv",&docfont)

               'FootFont'             = ("Arial, Helvetica, Helv", 9pt)
               'StrongFootFont'       = ("Arial, Helvetica, Helv",8pt,Bold)
               'EmphasisFootFont'     = ("Arial, Helvetica, Helv",8pt,Italic)
               'FixedFootFont'        = ("Courier New, Courier",8pt)
               'FixedEmphasisFootFont'= ("Courier New, Courier",8pt,Italic)
               'FixedStrongFootFont'  = ("Courier New, Courier",7pt,Bold);

        replace GraphFonts /
               'GraphDataFont'        = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphValueFont'       = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphLabelFont'       = ("Arial, Helvetica, Helv",&fixedfont,Bold)
               'GraphFootnoteFont'    = ("Arial, Helvetica, Helv",8pt)
               'GraphTitleFont'       = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'GraphAnnoFont'        = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphUnicodeFont'     = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphLabel2Font'      = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphTitle1Font'      = ("Arial, Helvetica, Helv",&fixedfont);

        style Graph from Output/
                outputwidth = 11in ;

        style table from table /
                outputwidth=&outputwidth
                protectspecialchars=off
                asis=on
                background = colors('tablebg')
                frame=&frame
                rules=&rules
                cellheight  = &cellheight
                cellpadding = &cellpadding
                cellspacing = &cellspacing
                bordercolor = colors('tableborder')
                borderwidth = &borderwidth;

         replace Footer from HeadersAndFooters

                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off ;

                replace FooterFixed from Footer
                / font = fonts('FixedFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterEmpty from Footer
                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off;

                replace FooterEmphasis from Footer
                / font = fonts('EmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterEmphasisFixed from FooterEmphasis
                / font = fonts('FixedEmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterStrong from Footer
                / font = fonts('StrongFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterStrongFixed from FooterStrong
                / font = fonts('FixedStrongFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooter from Footer
                / font = fonts('FootFont')  asis=on protectspecialchars=off just=left;

                replace RowFooterFixed from RowFooter
                / font = fonts('FixedFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterEmpty from RowFooter
                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterEmphasis from RowFooter
                / font = fonts('EmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterEmphasisFixed from RowFooterEmphasis
                / font = fonts('FixedEmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterStrong from RowFooter
                / font = fonts('StrongFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterStrongFixed from RowFooterStrong
                / font = fonts('FixedStrongFootFont')  just=left asis=on protectspecialchars=off;

                replace SystemFooter from TitlesAndFooters / asis=on
                        protectspecialchars=off just=left;
    end;
run;
quit;

%Mend utl_odsxls100;

