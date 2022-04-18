#!/bin/bash
#SBATCH --time=1:0:00
# walltime
#SBATCH --ntasks=4 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1
# number of nodes
#SBATCH --mem-per-cpu=4G # memory per CPU core
# LOAD ENVIRONMENTAL VARIABLES

username=`id -un`

fslmaths "$1"/anat/"$1"_space-MNIPediatricAsym_cohort-5_label-CSF_probseg.nii.gz -thrp 99 "$1"/anat/"$1"_space-MNIPediatricAsym_cohort-5_label-CSF_probseg_thr.nii.gz
fslmaths "$1"/anat/"$1"_space-MNIPediatricAsym_cohort-5_label-CSF_probseg_thr.nii.gz \
-bin "$1"/anat/"$1"_space-MNIPediatricAsym_cohort-5_label-CSF_probseg_thr-bin.nii.gz
fslmaths "$1"/anat/"$1"_space-MNIPediatricAsym_cohort-5_label-CSF_probseg_thr-bin.nii.gz \
-kernel gauss 3 -ero "$1"/anat/"$1"_space-MNIPediatricAsym_cohort-5_label-CSF_probseg_ERO.nii.gz
