# coding: utf8
#!/bin/env python
###module load Python/2.7.11-foss-2016a

####use
#python model_scores_ret.py bfgs_results_file path_to_file outname save_file

import os
import sys
import numpy as np
import pandas as pd

bfgs_res= sys.argv[1]
print('Results bfgs file : ' + bfgs_res)
path_inp= sys.argv[2]
print('Path input: ' + path_inp)
out_name=sys.argv[3]
print('Outname: ' + out_name)
save_file=sys.argv[4]
print('Save file: ' + save_file)


# bfgs_res='best_runs_bfgs_bur_m_bur_s.txt'
# path_inp='/data/s3536319/2_final_ana/3rd_run/emp_real/bur_m_vs_bur_s'
# out_name='ensayis_python'
# save_file=True

def aic_res(filename, path_to_file, outname,savefile = True):
    #
    os.chdir(path_inp)
    #
    data_set = pd.read_table(filename, sep='\t')
    #
    comparisson=[outname]*len(data_set['AIC'])
    AIC_model_t =[]
    for i in range(len(data_set['AIC'])):
        AIC_model = data_set['AIC'][i]
        AIC_min = data_set['AIC'].min()
        delta_model = AIC_model - AIC_min
        AIC_model_t.append(delta_model)
        #print(delta_model)
        #
    delta_max = data_set['AIC'].max() - data_set['AIC'].min()
    #
    model_score_t=[]
    for i in range(len(AIC_model_t)):
        model_score= (delta_max - AIC_model_t[i])/(delta_max)
        model_score_t.append(model_score)
        #print(model_score)
        #
        #
    aic_results = pd.DataFrame(
            {'comparisson': comparisson,
             'model': data_set['model'],
             'AIC_deltamodel': AIC_model_t,
             'model_score': model_score_t,
              },columns=['comparisson','model','AIC_deltamodel','model_score'])
              #
              #
    aic_results.to_csv('scores_' + out_name + '.tsv', sep='\t',index=False)
    if savefile == True:
        aic_results.to_csv('scores_' + out_name + '.tsv', sep='\t',index=False)
        #
    #print(aic_results)
    return(aic_results)

aic_res(bfgs_res, path_inp, out_name, save_file)
