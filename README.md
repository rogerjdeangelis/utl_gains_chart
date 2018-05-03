# utl_gains_chart
Create a lift or gains chart from your logistic scores

     Producing the Logistic Gains chart

     It is important to note that I am only interested in predictions and
     not inference. NO training output.

     see

     for output in excel
     see utl_ganrpt.xls
     excel gains table - macro's output - excell workbook

     data in project
     see tut_fakdat.sas7bdat?dl=0


     HAVE   ( From logistic regression)
     ===================================

     Up to 40 obs from tut.tut_fakdat total obs=110,588


      Obs    DECILES    RESPONSE     SCORE

        1       1           1       0.95986
        2       1           1       0.94596
        3       1           1       0.94170
        4       1           1       0.93679
        5       1           1       0.93437
      ...



     WANT ( The ouput is in excel but here is printer listing)
     ==========================================================


     Index and Gains Table for Overall Response

     The Overall Percentage of Patients with a Stroke or Heart Attack is 1.4794%
     The index is the Percent Response in the Decile divided by the Overall Response.
     For instance for the top decile the Index=11.1482/1.4794 or 7.536
     Patients in the top Decile are almost 8 times as likely to have a Stroke or Heart Attack
     The average score times the decile total should roughly equal to the number of patients with a Stroke or Heat Attack


                                            Decile Stats
                                                            Cum
                                                            Dec                                                           Percents
                                                            ile                                               Stroke            Stroke
                  Probabilities                             Per                                                Heart             Heart      Cum
                 Max                                        cen                                               Attack   Stroke   Attack   Stroke
               Score    Mean     Min                          t       Response and Non Response Counts       Percent    Heart  Percent    Heart
                       Score   Score     Decile        Cum                        Cum     Stroke        Cum  of Tota   Attack  of Deci   Attack
      Decile                              Count     Decile         Healthy    Healthy      Heart     Stroke        l  Percent       le  Percent
                                                     Count        Patients   Patients     Attack      Heart   Stroke    Total    Total  of Deci   Index and Gain
                                                                                                     Attack    Heart  Respons                le               Cum
                                                                                                              Attack        e            Totals    Index    Index
           1   0.960   0.107   0.021      10909      10909   10       9673       9673       1236       1236    75.55    75.55    11.33    11.33     7.66     7.66
           2   0.021   0.012   0.008      10728      21637   20      10561      20234        167       1403    10.21    85.76     1.56     6.48     1.05     4.38
           3   0.008   0.007   0.005      11429      33066   30      11322      31556        107       1510     6.54    92.30     0.94     4.57     0.63     3.09
           4   0.005   0.005   0.005      14495      47561   43      14411      45967         84       1594     5.13    97.43     0.58     3.35     0.39     2.27
           5   0.005   0.004   0.004       7772      55333   50       7730      53697         42       1636     2.57   100.00     0.54     2.96     0.37     2.00
           6   0.004   0.003   0.003      10725      66058   60      10725      64422          0       1636     0.00   100.00     0.00     2.48     0.00     1.67
           7   0.003   0.003   0.003       8312      74370   67       8312      72734          0       1636     0.00   100.00     0.00     2.20     0.00     1.49
           8   0.003   0.003   0.003       3972      78342   71       3972      76706          0       1636     0.00   100.00     0.00     2.09     0.00     1.41
           9   0.003   0.003   0.003      32246     110588  100      32246     108952          0       1636     0.00   100.00     0.00     1.48     0.00     1.00




