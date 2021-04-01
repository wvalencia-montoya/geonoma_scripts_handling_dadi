# coding: utf8
#!/bin/env python

###use
#python gim_uncertainty.py fs_emp par_file fs_file path_to_file best_model outname

###example
#python gim_uncertainty.py 'ang_m_VS_bur_m.3L-R_X.out_merus.fs' 'par_list_AM2N2mG-2-ang_m-bur_m.txt' \
#fs_list_ang_m-bur_m.txt' "$(pwd)" 'AM2N2mG' 'uncert-AM2N2mG-2-ang_m-bur_m.txt'

###the par_file is a file with one parameter value in each file that you can get with the par_2_list.sh script
### the fs_file is a file with one bootstrapped spectrum file per line

# module load Python/2.7.11-foss-2016a
# Library importation
import os
import sys
sys.path.append('/n/home06/wvalenciamontoya/programs/DADI_modified/Dadi_v1.6.3_modif/')
sys.path.append('/n/home06/wvalenciamontoya/programs/DADI_modified/Dadi_v1.6.3_modif/Dadi_studied_model/00_inference')
#dadi_path='/home/s3536319/Dadi'
#os.chdir(dadi_path)
import dadi
import modeledemo_mis_new_models
import Godambe

#import matplotlib
#import pylab
import numpy as np
import pandas as pd

fs_emp=sys.argv[1]
print('Empirical spectra : ' + fs_emp)
par_file= sys.argv[2]
print('Parameters File : ' + par_file)
fs_file= sys.argv[3]
print('Spectra file : ' + fs_file)
path_file= sys.argv[4]
print('Path: ' + path_file)
best_model= sys.argv[5]
print('Best model: ' + best_model)
outname = sys.argv[6]
print('File Name: ' + outname)
chr_proj = int(sys.argv[7])
print('Projected to: ' + str(chr_proj))


# Global variables
# Best fit params:

# boot_dir = '/data/s3536319/filtered_vcfs/final_bg_vcfs/cons_alle/non_par_boot/boot_samples/boot_samples_2/boot_fs_ang_m-bur_m'
# fs_emp= 'ang_m_VS_bur_m.3L-R_X.out_merus.fs'
# par_file = 'par_list_AM2N2mG-2-ang_m-bur_m.txt'
# fs_file = 'fs_list_ang_m-bur_m.txt'
# best_model = 'AM2N2mG'
# outname = 'uncert-AM2N2mG-2-ang_m-bur_m.txt'

###Parameters of bur_m gab_s IMG
#nu1, nu2, b1, b2, m12, m21, Ts, O
# p0= [ 2.35648165, 11.04651393,  4.46716113,  0.09675936,  0.31845619,
#         1.89526237,  0.90255406,  0.97696238]
#
# list_spectra=['bur_m_VS_gab_s_3-X_boot0.out_merus.fs','bur_m_VS_gab_s_3-X_boot1.out_merus.fs','bur_m_VS_gab_s_3-X_boot2.out_merus.fs',
#                'bur_m_VS_gab_s_3-X_boot3.out_merus.fs','bur_m_VS_gab_s_3-X_boot4.out_merus.fs','bur_m_VS_gab_s_3-X_boot5.out_merus.fs',
#                'bur_m_VS_gab_s_3-X_boot6.out_merus.fs','bur_m_VS_gab_s_3-X_boot7.out_merus.fs']

#func = modeledemo_mis_new_models.IMG

os.chdir(path_file)

print("Reading parameters\n")

p0 = [float(line.rstrip('\n')) for line in open(par_file)]

print("Reading the list of spectra\n")

list_spectra = [line.rstrip('\n') for line in open(fs_file)]

all_boot = [dadi.Spectrum.from_file(fname) for fname in list_spectra]



func_model='modeledemo_mis_new_models.' + best_model

func = eval(func_model)

# Make the extrapolating version of our demographic model function.
func_ex = dadi.Numerics.make_extrap_log_func(func)

grid_pts = chr_proj + 10, chr_proj + 20, chr_proj + 30

data = dadi.Spectrum.from_file(fs_emp)

# mask singletons
data.mask[1, 0] = True
data.mask[0, 1] = True

# eps is the step size for derivative calculation
eps=0.01

# The final entry of the returned uncertainties will correspond to Theta
multinom = True

# uncert is a numpy array equal in length to p0
print("Running Godambe")
uncert = Godambe.GIM_uncert(func_ex, grid_pts, all_boot, p0, data, multinom, eps)

# Write to file

with open(outname, "w") as out_file_opt:
            out_file_opt.write(str(uncert) + '\n')
            out_file_opt.close()

print("Done.")

