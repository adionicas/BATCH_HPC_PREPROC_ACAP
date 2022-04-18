#!/bin/bash
curTime=`date +"%Y%m%d-%H%M%S"`
username=`id -un`
mkdir -p logfiles/${curTime}
subs=`cat BIDS_FMRIPREP_FILES/pronti_per_fMRIprep.txt | cut -d "_" -f 1`

for sub in ${subs}; do
sbatch \
-o logfiles/${curTime}/output-${sub}.txt \
-e logfiles/${curTime}/error-${sub}.txt \
job_B0_ses.sh \
${sub}
sleep 1
done
