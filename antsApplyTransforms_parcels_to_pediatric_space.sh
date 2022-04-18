#!/bin/bash
#SBATCH --time=1:30:00   # walltime
#SBATCH --ntasks=8  # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=8G  # memory per CPU core

# LOAD ENVIRONMENTAL VARIABLES
curTime=`date +"%Y%m%d-%H%M%S"`
username=`id -un`
module load ants

parcellations="MIST_197 MIST_36  MIST_7.nii.gz
MIST_122 MIST_20  MIST_444 MIST_ATOM.nii.gz
MIST_12  MIST_325 MIST_64  MIST_ROI.nii.gz"

for parc in $parcellations
do
antsApplyTransforms -d 3 -n MultiLabel \
-r register_templates/tpl-MNIPediatricAsym_cohort-5_res-2_T1w.nii.gz \
-i MIST/Release/Parcellations/"$parc".nii.gz \
-t register_templates/MNI152Lin2PedAsym1Warp.nii.gz \
-t register_templates/MNI152Lin2PedAsym0GenericAffine.mat \
-o MIST/"$parc"_MNIPediatricAsym_cohort-5_res-2.nii.gz
done

antsApplyTransforms -d 3 -n MultiLabel \
-r register_templates/tpl-MNIPediatricAsym_cohort-5_res-2_T1w.nii.gz \
-i AALv2/aal/aal2.nii.gz \
-t register_templates/MNI152Lin2PedAsym1Warp.nii.gz \
-t register_templates/MNI152Lin2PedAsym0GenericAffine.mat \
-o AALv2/AALv2_MNIPediatricAsym_cohort-5_res-2.nii.gz

parcellations="222"
for parc in $parcellations
do
antsApplyTransforms -d 3 -n NearestNeighbor \
-r register_templates/tpl-MNIPediatricAsym_cohort-5_res-2_T1w.nii.gz \
-i Gordon/Parcels_MNI_"$parc".nii \
-t register_templates/MNI152Lin2PedAsym1Warp.nii.gz \
-t register_templates/MNI152Lin2PedAsym0GenericAffine.mat \
-o Gordon/Gordon_"$parc"_MNIPediatricAsym_cohort-5_res-2.nii.gz
done
