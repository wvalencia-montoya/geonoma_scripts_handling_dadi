#!/bin/bash

##script to retrieve parameters from gim_uncertainty.py script output

#use 
#bash retrieve_gim_out.sh best_m_r res_file chrm outname pop1 pop2 path_file

best_m_r=$1
res_file=$2
chrm=$3
outname=$4
pop1=$5
pop2=$6
path_file=$7



par_bfgs=($(echo "$(cat $res_file | paste -d " "  - - - | sed 's/\[//;s/\]//g')"))

mle_bfgs=NA
aic_bfgs=NA

if_statement () {
  #
  printf 'Comparisson\tChr\tModel\tOpt\tMLE\tAIC\tTheta\tnu1\tnu2\tb1\tb2\thrf\tm12\tm21\tme12\tme21\tTsplit\tTpost-split\tP\tQ\tO\n' > $outname
  #
  if [ "$best_m_r" = "SC2N2mG" ]; then
    #nu1, nu2, b1, b2, hrf, m12, m21, me12, me21, Ts, Tsc, P, Q, O = params
    #0      1   2   3    4    5    6     7     8   9   10 11 12 13
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[14]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\t${par_bfgs[7]}\t${par_bfgs[8]}\t${par_bfgs[9]}\t${par_bfgs[10]}\t${par_bfgs[11]}\t${par_bfgs[12]}\t${par_bfgs[13]}\n" >> $outname
  elif [ "$best_m_r" = "SC2mG" ]; then
    #nu1, nu2, b1, b2,      m12, m21, me12, me21, Ts, Tsc, P,    O = params
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[12]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\t${par_bfgs[7]}\t${par_bfgs[8]}\t${par_bfgs[9]}\t${par_bfgs[10]}\tNA\t${par_bfgs[11]}\n" >> $outname
  elif [ "$best_m_r" = "SC2NG" ]; then
    #nu1, nu2, b1, b2, hrf, m12, m21,             Ts, Tsc,    Q, O = params
    #0,1,2,3,4,5,6,NA,NA,7,8,NA,9,10
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[11]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\tNA\tNA\t${par_bfgs[7]}\t${par_bfgs[8]}\tNA\t${par_bfgs[9]}\t${par_bfgs[10]}\n" >> $outname
  elif [ "$best_m_r" = "SC2N2m" ]; then
    #nu1, nu2,         hrf, m12, m21, me12, me21, Ts, Tsc, P, Q, O = params
    #0,1,NA,NA,2,3,4,5,6,7,8,9,10,11
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[12]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\t${par_bfgs[7]}\t${par_bfgs[8]}\t${par_bfgs[9]}\t${par_bfgs[10]}\t${par_bfgs[11]}\n" >> $outname
  elif [ "$best_m_r" = "SC2m" ]; then
    #nu1, nu2,              m12, m21, me12, me21, Ts, Tsc, P,    O = params
    #0,1,NA,NA,NA,2,3,4,5,6,7,8,NA,9
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[10]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\t${par_bfgs[7]}\t${par_bfgs[8]}\tNA\t${par_bfgs[9]}\n" >> $outname
  elif [ "$best_m_r" = "SC2N" ]; then
    #nu1, nu2,         hrf, m12, m21,             Ts, Tsc,   Q, O = params
    #0,1,NA,NA,2,3,4,NA,NA,5,6,NA,7,8
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[9]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\tNA\tNA\t${par_bfgs[5]}\t${par_bfgs[6]}\tNA\t${par_bfgs[7]}\t${par_bfgs[8]}\n" >> $outname
  elif [ "$best_m_r" = "SCG" ]; then
    #nu1, nu2, b1, b2,      m12, m21,             Ts, Tsc,     O = params
    #0,1,2,3,NA,4,5,NA,NA,6,7,NA,NA,8
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[9]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\t${par_bfgs[4]}\t${par_bfgs[5]}\tNA\tNA\t${par_bfgs[6]}\t${par_bfgs[7]}\tNA\tNA\t${par_bfgs[8]}\n" >> $outname
  elif [ "$best_m_r" = "SC" ]; then
    #nu1, nu2,              m12, m21,             Ts, Tsc,     O = params
    #0,1,NA,NA,NA,2,3,NA,NA,4,5,NA,NA,6
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[7]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\tNA\t${par_bfgs[4]}\t${par_bfgs[5]}\tNA\tNA\t${par_bfgs[6]}\n" >> $outname
  elif [ "$best_m_r" = "AM2N2mG" ]; then
    #nu1, nu2, b1, b2, hrf, m12, m21, me12, me21, Tam, Ts, P, Q, O = params
    #0,1,2,3,4,5,6,7,8,9,10,11,12,13
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[14]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\t${par_bfgs[7]}\t${par_bfgs[8]}\t${par_bfgs[9]}\t${par_bfgs[10]}\t${par_bfgs[11]}\t${par_bfgs[12]}\t${par_bfgs[13]}\n" >> $outname
  elif [ "$best_m_r" = "AM2mG" ]; then
    #nu1, nu2, b1, b2,      m12, m21, me12, me21, Tam, Ts, P,    O = params
    #0,1,2,3,NA,4,5,6,7,8,9,10,NA,11
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[12]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\t${par_bfgs[7]}\t${par_bfgs[8]}\t${par_bfgs[9]}\t${par_bfgs[10]}\tNA\t${par_bfgs[11]}\n" >> $outname
  elif [ "$best_m_r" = "AM2NG" ]; then
    #nu1, nu2, b1, b2, hrf, m12, m21,             Tam, Ts,    Q, O = params
    #0,1,2,3,4,5,6,NA,NA,7,8,NA,9,10
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[11]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\tNA\tNA\t${par_bfgs[7]}\t${par_bfgs[8]}\tNA\t${par_bfgs[9]}\t${par_bfgs[10]}\n" >> $outname
  elif [ "$best_m_r" = "AM2N2m" ]; then
    #nu1, nu2,         hrf, m12, m21, me12, me21, Tam, Ts, P, Q, O = params
    #0,1,NA,NA,2,3,4,5,6,7,8,9,10,11
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[12]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\t${par_bfgs[7]}\t${par_bfgs[8]}\t${par_bfgs[9]}\t${par_bfgs[10]}\t${par_bfgs[11]}\n" >> $outname
  elif [ "$best_m_r" = "AM2m" ]; then
    #nu1, nu2,              m12, m21, me12, me21, Ts, Tam, P,    O = params
    #0,1,NA,NA,NA,2,3,4,5,6,7,8,NA,9
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[10]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\t${par_bfgs[7]}\t${par_bfgs[8]}\tNA\t${par_bfgs[9]}\n" >> $outname
  elif [ "$best_m_r" = "AM2N" ]; then
    #nu1, nu2,         hrf, m12, m21,             Tam, Ts,    Q, O = params
    #0,1,NA,NA,2,3,4,NA,NA,5,6,NA,7,8
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[9]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\tNA\tNA\t${par_bfgs[5]}\t${par_bfgs[6]}\tNA\t${par_bfgs[7]}\t${par_bfgs[8]}\n" >> $outname
  elif [ "$best_m_r" = "AMG" ]; then
    #nu1, nu2, b1, b2,      m12, m21,             Tam, Ts,       O = params
    #0,1,2,3,NA,4,5,NA,NA,6,7,NA,NA,8
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[9]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\t${par_bfgs[4]}\t${par_bfgs[5]}\tNA\tNA\t${par_bfgs[6]}\t${par_bfgs[7]}\tNA\tNA\t${par_bfgs[8]}\n" >> $outname
  elif [ "$best_m_r" = "AM" ]; then
    #nu1, nu2,              m12, m21,             Ts, Tam,       O = params
    #0,1,NA,NA,NA,2,3,NA,NA,4,5,NA,NA,6
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[7]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\tNA\t${par_bfgs[4]}\t${par_bfgs[5]}\tNA\tNA\t${par_bfgs[6]}\n" >> $outname
  elif [ "$best_m_r" = "IM2mG" ]; then
    #nu1, nu2, b1, b2,     m12, m21, me12, me21, Ts,      P,     O = params
    #0,1,2,3,NA,4,5,6,7,8,NA,9,NA,10
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[11]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\t${par_bfgs[7]}\t${par_bfgs[8]}\tNA\t${par_bfgs[9]}\tNA\t${par_bfgs[10]}\n" >> $outname
  elif [ "$best_m_r" = "IM2NG" ]; then
    #nu1, nu2, b1, b2, hrf, m12, m21,            Ts,          Q, O = params
    #0,1,2,3,4,5,6,NA,NA,7,NA,NA,8,9
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[10]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\tNA\tNA\t${par_bfgs[7]}\tNA\tNA\t${par_bfgs[8]}\t${par_bfgs[9]}\n" >> $outname
  elif [ "$best_m_r" = "IM2m" ]; then
    #nu1, nu2,              m12, m21,me12, me21, Ts,       P,    O = params
    #0,1,NA,NA,NA,2,3,4,5,6,NA,7,NA,8
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[9]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\t${par_bfgs[5]}\t${par_bfgs[6]}\tNA\t${par_bfgs[7]}\tNA\t${par_bfgs[8]}\n" >> $outname
  elif [ "$best_m_r" = "IM2N" ]; then
    #nu1, nu2,         hrf, m12, m21,            Ts,          Q, O = params
    #0,1,NA,NA,2,3,4,NA,NA,6,NA,NA,7,8
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[9]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\tNA\tNA\t${par_bfgs[5]}\t${par_bfgs[6]}\tNA\tNA\t${par_bfgs[7]}\t${par_bfgs[8]}\n" >> $outname
  elif [ "$best_m_r" = "IMG" ]; then
    #nu1, nu2, b1, b2,      m12, m21,            Ts,              O = params
    #0,1,2,3,NA,4,5,NA,NA,6,NA,NA,NA,7
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[8]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\t${par_bfgs[4]}\t${par_bfgs[5]}\tNA\tNA\t${par_bfgs[6]}\tNA\tNA\tNA\t${par_bfgs[7]}\n" >> $outname
  elif [ "$best_m_r" = "IM" ]; then
    #nu1, nu2,              m12, m21,            Ts,              O = params
    #0,1,NA,NA,NA,2,3,NA,NA,4,NA,NA,NA,5
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[6]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\tNA\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\tNA\t${par_bfgs[4]}\tNA\tNA\tNA\t${par_bfgs[5]}\n" >> $outname
  elif [ "$best_m_r" = "SI2NG" ]; then
    #nu1, nu2, b1, b2, hrf,                      Ts,           Q, O = params
    #0,1,2,3,4,NA,NA,NA,NA,5,NA,NA,6,7
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[8]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\t${par_bfgs[4]}\tNA\tNA\tNA\tNA\t${par_bfgs[5]}\tNA\tNA\t${par_bfgs[6]}\t${par_bfgs[7]}\n" >> $outname
  elif [ "$best_m_r" = "SI2N" ]; then
    #nu1, nu2,        Ts, nr, bf,                                 O = params
    #nu1, nu2,          bf,                      Ts,          nr, O = params
    #0,1,NA,NA,4,NA,NA,NA,NA,NA,2,NA,3,5
    #nu1, nu2, b1, b2, hrf, m12, m21, me12, me21, Tam, Ts, P, Q, O = params
    #nu1, nu2, Ts, nr, bf, O = params
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[6]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\t${par_bfgs[4]}\tNA\tNA\tNA\tNA\tNA\t${par_bfgs[2]}\tNA\t${par_bfgs[3]}\t${par_bfgs[5]}\n" >> $outname
  elif [ "$best_m_r" = "SIG" ]; then
    #nu1, nu2, b1, b2,                                 Ts,       O = params
    #0,1,2,3,NA,NA,NA,NA,NA,NA,4,NA,NA,5
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[6]}\t${par_bfgs[0]}\t${par_bfgs[1]}\t${par_bfgs[2]}\t${par_bfgs[3]}\tNA\tNA\tNA\tNA\tNA\tNA\t${par_bfgs[4]}\tNA\tNA\t${par_bfgs[5]}\n" >> $outname
  elif [ "$best_m_r" = "SI" ]; then
    #nu1, nu2, Ts, O = params
    #0,1,NA,NA,NA,NA,NA,NA,NA,NA,2,NA,NA,3
    printf "$pop1-$pop2\t$chrm\t$best_m_r\tanneal_bfgs\t$mle_bfgs\t$aic_bfgs\t${par_bfgs[4]}\t${par_bfgs[0]}\t${par_bfgs[1]}\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t${par_bfgs[2]}\tNA\tNA\t${par_bfgs[3]}\n" >> $outname
  else
    printf "You may think this has been long but I didn't find a better way given that evey model is so singular"
  fi
}

#Calling the functions


if_statement


