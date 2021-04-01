#!/bin/bash
###########use###############

#bash run_ind_mod.sh file inp_path attempt chrm partition

##Chromosome must be 3L-R-X or 3L-R or X 

######Running each model in parallel

##Chromosome must be 3L-R-X or 3L-R or X
file=$1
inp_path=$2
attempt=$3
chrm=$4
partition=$5

# file=bur_m_VS_bur_s.3L-R_X.out_merus.fs
# inp_path=/data/s3536319/2_final_ana/3rd_run/emp_real
# attempt=01
# chrm=3L-R-X

run_opt=/home/s3536319/DADI_modified/Dadi_v1.6.3_modif/Dadi_studied_model/00_inference/script_inference_anneal2_newton_mis_new_models_w1.py

pop1=${file:0:5}
pop2=${file:9:5}
#prefix=${file:15:6}_${file:26:5}

if [ "$chrm" = "3L-R-X" ]; then
 prefix=${file:15:6}_${file:26:5}
elif [ "$chrm" = "3L-R" ]; then
 prefix=${file:15:4}_${file:24:5}
elif [ "$chrm" = "X" ]; then
 prefix=${file:15:1}_${file:21:5}
fi

array=(IM2mG AM AMG AM2N AM2m AM2N2m AM2NG AM2mG AM2N2mG SC SCG SC2N SC2m SC2N2m SC2NG SC2mG SC2N2mG)
#array2=(anneal_hot anneal_cold BFGS)

for m in "${array[@]}"
do

txt_file=run_$m-$prefix-$pop1-$pop2-$attempt.txt

if [ -e $(echo "$txt_file") ]; then
 rm $(echo "$txt_file"); fi

  for i in $(seq 1 10)
  do
   outname=$m-$i-$prefix-$pop1-$pop2

   echo "python $run_opt \
   -f $inp_path/$file \
   -o $outname \
   -y $pop1 -x $pop2 \
   -m  $m \
   -z -l -v" >> $txt_file
   done

   run_file=4_run_$m-$prefix-$pop1-$pop2-$attempt.sh

   if [ -e $(echo "$run_file") ]; then
     rm $(echo "$run_file"); fi

   echo "#!/bin/bash" >> $run_file
   echo "#SBATCH --job-name=$m-$attempt-$prefix-$pop1-$pop2" >> $run_file
   echo "#SBATCH --time=70:00:00" >> $run_file
   echo "#SBATCH --nodes=1" >> $run_file
   echo "#SBATCH --ntasks-per-node=10" >> $run_file
   echo "#SBATCH --mem=120GB" >> $run_file
   echo "#SBATCH --mail-type FAIL" >> $run_file
   echo "#SBATCH --mail-user=valenaturaa@gmail.com" >> $run_file
   echo "#SBATCH --output=job-%j.log" >> $run_file
   echo "#SBATCH --partition=$partition" >> $run_file

   echo " " >> $run_file
   echo " " >> $run_file

   echo "module load Python/2.7.11-foss-2016a" >> $run_file
   echo "module load parallel/20160622-foss-2016a" >> $run_file

   echo " " >> $run_file

   echo "cd $inp_path" >> $run_file

   echo " " >> $run_file
   echo " " >> $run_file

   echo "cat $(echo "$txt_file") | parallel --verbose -j 10 "{}"" >> $run_file
   
done
