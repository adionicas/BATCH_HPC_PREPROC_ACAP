#!/bin/bash
#SBATCH --time=5:30:00   # walltime
#SBATCH --ntasks=8  # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=8G  # memory per CPU core

# LOAD ENVIRONMENTAL VARIABLES
username=`id -un`

module load singularity/3.4.1

# INSERT CODE, AND RUN YOUR PROGRAMS HERE
img="./my_images/fmriprep-20.0.7.simg"

singularity run --cleanenv ${img} \
BIDS_FMRIPREP_FILES/B0 \
BIDS_FMRIPREP_FILES/derivs_B0 \
participant --participant-label ${1} \
--fs-license-file freesurfer.txt \
--force-no-bbr \
--use-syn-sdc \
--fs-no-reconall \
--fd-spike-threshold 0.2 \
--output-spaces MNIPediatricAsym:res-2:cohort-5
