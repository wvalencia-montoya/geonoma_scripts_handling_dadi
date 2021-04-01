# coding: utf8
#!/bin/env python

####use
#python conv_bio_units_all_snps_f.py par.txt $(pwd) outname '3-X'

##Script to convert final parameter estimates inot biological meaningful units

import sys, os
import pandas as pd
import numpy as np

filename= sys.argv[1]
print('File : ' + filename)
path_file= sys.argv[2]
print('Path: ' + path_file)
out_name = sys.argv[3]
print('File Name: ' + out_name)
chrm = sys.argv[4]
print('Chromosomes: ' + chrm)


os.chdir(path_file)

res_file = pd.read_table(filename, sep='\t')

 ##2.61 x 10-9 Gaut et al. 1996 PNAS
#mu = 3.50E-09
mu = 2.61E-09
#gen_time = 0.1
gen_time = 57.5
#L = 98120681
#L=4357187
#L=217117
###L=644326
#L=453545.8
#L=1072905
#L=1037755
#L=692060.5
#L=678863.6
#L=462362.6
#L=1037755
L=965327.8

#if chrm == '3-X':
#    L = 46571265
#elif chrm == '3':
#    L = 38311193
#elif chrm == 'X':
#    L = 8127116

###To understand this the best option is to check dadi blog answers
#https://groups.google.com/forum/#!topic/dadi-user/6zvpcO_5iWk

res_file['Nref'] =  res_file['Theta'] / (4 * L * mu)
res_file['nu1_r'] =  res_file['nu1'] * res_file['Nref']
res_file['nu2_r'] =  res_file['nu2'] * res_file['Nref']
res_file['b1_r'] = res_file['b1'] * res_file['Nref']
res_file['b2_r'] = res_file['b2'] * res_file['Nref']
res_file['T_r_split'] = res_file['Tsplit'] * 2 * res_file['Nref'] * gen_time
res_file['T_r_post-split'] = res_file['Tpost-split'] * 2 * res_file['Nref'] * gen_time
res_file['m12_r'] = res_file['m12'] / (2 * res_file['Nref'])
res_file['m21_r'] = res_file['m21'] / (2 * res_file['Nref'])
res_file['me12_r'] = res_file['me12'] / (2 * res_file['Nref'])
res_file['me21_r'] = res_file['me21'] / (2 * res_file['Nref'])


res_tab_con = pd.DataFrame(
        {'Pop-pair': res_file['Comparisson'],
         'Chr': res_file['Chr'],
         'Model': res_file['Model'],
         'Opt': res_file['Opt'],
         'MLE': res_file['MLE'],
         'AIC': res_file['AIC'],
         'Theta': res_file['Theta'],
         'Size Pop1': res_file['nu1_r'],
         'Size Pop2': res_file['nu2_r'],
         'b1': res_file['b1_r'],
         'b2': res_file['b2_r'],
         'hrf': res_file['hrf'],
         'M12': res_file['m12_r'],
         'M21': res_file['m21_r'],
         'Me12': res_file['me12_r'],
         'Me21': res_file['me21_r'],
         'T_split_y': res_file['T_r_split'],
         'T_post-split_y': res_file['T_r_post-split'],
         'P': res_file['P'],
         'Q': res_file['Q'],
         'O': res_file['O']} , columns=['Pop-pair','Chr','Model','Opt','MLE','AIC',
         'Theta','Size Pop1','Size Pop2','b1','b2','hrf','M12','M21','Me12','Me21',
         'T_split_y','T_post-split_y','P','Q','O'])

res_tab_con.to_csv(out_name+ '.tsv', sep='\t', index=False)

