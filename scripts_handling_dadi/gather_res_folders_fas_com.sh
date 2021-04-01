#!/bin/bash

####use 
#bash gather_res_folders.sh foldersfile path_to_folders outname 

folders_file=$1
path_folders=$2
out_global=$3
s=/n/home06/wvalenciamontoya/scripts_useful/scripts_use_dadi/resume_res_fas_com.sh
out_temp=tab_best_m_par_temp.txt

cd $path_folders

for i in $(cat $folders_file)
do
  cd ${i}
  bash $s ${i}.txt N $out_temp $(pwd)
  cat $out_temp >> ../$out_global
  rm $out_temp
  cd $path_folders
  printf "attempt\tcomparisson\tchr\tmodel\topt\tmle\taic\tthetha\n" > $out_global-f.txt
  grep -v '^attempt' $out_global >> $out_global-f.txt
done

rm $out_global
