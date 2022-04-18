#!/bin/bash
#SBATCH --time=10:30:00   # walltime
#SBATCH --ntasks=8  # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=8G  # memory per CPU core

# LOAD ENVIRONMENTAL VARIABLES
curTime=`date +"%Y%m%d-%H%M%S"`
username=`id -un`
module load ants
antsRegistrationSyN.sh -d 3 -t s -f tpl-MNIPediatricAsym_cohort-5_res-2_T1w.nii.gz \
-m tpl-MNI152Lin_res-02_T1w.nii.gz \
-o MNI152Lin2PedAsym
