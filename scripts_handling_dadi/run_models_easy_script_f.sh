###Final jobs for results

#run_opt=/home/s3536319/DADI_modified/Dadi_v1.6.3_modif/Dadi_studied_model/00_inference/script_inference_anneal2_newton_mis_new_models_w2.py

#file=ang_m_VS_uga_s.3L-R_X.out_merus.fs
#inp_path=/data/s3536319/2_final_ana/emp_spectra_3-X_merus
 ###########use###############

 #bash run_models_easy_script_f.sh file inp_path attempt
file=$1
inp_path=$2
attempt=$3
run_opt=/home/s3536319/DADI_modified/Dadi_v1.6.3_modif/Dadi_studied_model/00_inference/script_inference_anneal2_newton_mis_new_models_w1.py

pop1=${file:0:5}
pop2=${file:9:5}
prefix=${file:15:6}_${file:26:5}
txt_file=run_$prefix-$pop1-$pop2-$attempt.txt

if [ -e $(echo "$txt_file") ]; then
  rm $(echo "$txt_file"); fi

for i in $(seq 1 10)
do
  outname=$i-$prefix-$pop1-$pop2

  echo "python $run_opt \
  -f $inp_path/$1 \
  -o $outname \
  -y $pop1 -x $pop2 \
  -m SI,SIG,SI2N,SI2NG,IM,IMG,IM2N,IM2m,IM2NG,IM2mG,AM,AMG,AM2N,AM2m,AM2N2m,AM2NG,AM2mG,AM2N2mG,SC,SCG,SC2N,SC2m,SC2N2m,SC2NG,SC2mG,SC2N2mG \
  -z -l -v" >> $txt_file
  done

for i in $(seq 11 20)
do
  outname=$i-$prefix-$pop1-$pop2

  echo "python $run_opt \
  -f $inp_path/$1 \
  -o $outname \
  -y $pop1 -x $pop2 \
  -m SC2N2mG,SC2mG,SC2NG,SC2N2m,SC2m,SC2N,SCG,SC,AM2N2mG,AM2mG,AM2NG,AM2N2m,AM2m,AM2N,AMG,AM,IM2mG,IM2NG,IM2m,IM2N,IMG,IM,SI2NG,SI2N,SIG,SI \
  -z -l -v" >> $txt_file
done


run_file=4_run_$prefix-$pop1-$pop2-$attempt.sh

if [ -e $(echo "$run_file") ]; then
  rm $(echo "$run_file"); fi

echo "#!/bin/bash" >> $run_file
echo "#SBATCH --job-name=$attempt-$prefix-$pop1-$pop2" >> $run_file
echo "#SBATCH --time=238:00:00" >> $run_file
echo "#SBATCH --nodes=1" >> $run_file
echo "#SBATCH --ntasks-per-node=20" >> $run_file
echo "#SBATCH --mem=120GB" >> $run_file
echo "#SBATCH --mail-type FAIL" >> $run_file
echo "#SBATCH --mail-user=valenaturaa@gmail.com" >> $run_file
echo "#SBATCH --output=job-%j.log" >> $run_file
echo "#SBATCH --partition=gelifes" >> $run_file

echo " " >> $run_file
echo " " >> $run_file

echo "module load Python/2.7.11-foss-2016a" >> $run_file
echo "module load parallel/20160622-foss-2016a" >> $run_file

echo " " >> $run_file

echo "cd $inp_path" >> $run_file

echo " " >> $run_file
echo " " >> $run_file

echo "cat $(echo "$txt_file") | parallel --verbose -j 20 "{}"" >> $run_file
