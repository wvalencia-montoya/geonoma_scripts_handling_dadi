# coding: utf8
#!/bin/env python


###Function that takes a .data file and gets empirical espectra for all possible comparissons of the populations
###use:
#python emp_spectra.py 'cons_all_ag_merus_split_X.cons_alle_fin.data' '/data/s3536319/filtered_vcfs/final_bg_vcfs/cons_alle' 'X' 'merus' 'project'
import os
import sys
sys.path.append('/n/home06/wvalenciamontoya/programs/Dadi_v1.6.3_modif')
#dadi_path='/home/s3536319/Dadi'
#os.chdir(dadi_path)
import dadi
import matplotlib
import pylab
import pandas as pd

###commenting out in atom :cmd +flecha arriba + 7
# filename='cons_all_ag_merus_split_X.cons_alle_fin.data'
# path_file='/data/s3536319/filtered_vcfs/final_bg_vcfs/cons_alle'
# chr_inp='X'
# out_group='merus'

filename= sys.argv[1]
print('Data file file : ' + filename)
path_file= sys.argv[2]
print('Path: ' + path_file)
chr_inp = sys.argv[3]
print('Chromosomes: ' + chr_inp)
out_group = sys.argv[4]
print('Name: ' + out_group)
chrm_proj = int(sys.argv[5])
print('Projected to : ' + str(chrm_proj) + 'chromosomes')

os.chdir(path_file)


# Parse the data file to generate the data dictionary
#dd = dadi.Misc.make_data_dict('ag1000g.phase1.ar3.pass.20-25bp.X.vcf.gz.data')
dd = dadi.Misc.make_data_dict(filename)

pop= ['lid',
'con',
'lie',
'hir']

temp_path = path_file + '/' + 'emp_fs_' + chr_inp + '_out_' + out_group
if not os.path.exists(temp_path):
    os.mkdir(temp_path)
else:
    print('The directory already exist!!')

#
os.chdir(temp_path)

for i in range(len(pop)):
    for j in range(len(pop)):
        if pop[i] != pop[j]:
            fs = dadi.Spectrum.from_data_dict(dd, [pop[i],pop[j]], [chrm_proj,chrm_proj])
            filename = pop[i] + '_VS_' + pop[j] + '.' +  chr_inp + '.' + 'out_' + out_group + '.fs'
            fs.to_file(filename)
        else:
            print("Next population is " + pop[i])


