#!/bin/bash
#SBATCH --time=0:30:00
# walltime
#SBATCH --ntasks=4 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1
# number of nodes
#SBATCH --mem-per-cpu=4G # memory per CPU core
# LOAD ENVIRONMENTAL VARIABLES
username=`id -un`

3dTproject -prefix denoising_B0/sub-"$1"/sub-"$1"_denoised_passband_36p_spikereg.nii.gz \
-input derivs_B0/fmriprep/sub-"$1"/func/sub-"$1"_task-rest_space-MNIPediatricAsym_cohort-5_res-2_desc-preproc_bold.nii.gz \
-ort denoising_B0/sub-"$1"/sub-"$1"_final_regressors_36p_detrended.txt \
-ort denoising_B0/sub-"$1"/sub-"$1"_outliers_thr2p5.txt \
-censor cens_first_4_vols_240.txt \
-polort 2 \
-passband 0.01 0.08 \
-mask derivs_B0/fmriprep/sub-"$1"/func/sub-"$1"_task-rest_space-MNIPediatricAsym_cohort-5_res-2_desc-brain_mask.nii.gz \
&>> denoising_B0/sub-"$1"/sub-"$1"_denoised_passband_36p_spikereg.log
