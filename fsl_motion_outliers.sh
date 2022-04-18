#!/bin/bash
#SBATCH --time=0:30:00   # walltime
#SBATCH --ntasks=4  # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4G  # memory per CPU core

username=`id -un`

module load fsl/6.0.0
fsl_motion_outliers -i ./multirun_FD_check/${1}/${2}/sub-${1}_ses-${2}_task-rest_${3}_bold.nii.gz \
-o ./multirun_FD_check/sub-${1}_ses-${2}_${3}_outliers.txt -s ./multirun_FD_check/sub-${1}_ses-${2}_${3}_FD_RMS.txt -p ./multirun_FD_check/sub-${1}_ses-${2}_${3}_plot --fdrms --thresh=0.2 -v
