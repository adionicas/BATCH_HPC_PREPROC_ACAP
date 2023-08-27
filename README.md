# BATCH_HPC_PREPROC_ACAP
A collection of batch scripts that can be used to run fMRI data preprocessing with singularity on a HCP.

## Convert data from dicom to nifti

dcm2niix takes as input the dicom images, and turns them into a nifti image; adding -b y also includes the .json file that is needed according to the BIDS specifications

```
for sub in $subs; do
dcm2niix -o ./"$sub"/T1w/ses-01/ -b y -z y ./"$sub"/T1w/ses-01/*
dcm2niix -o ./"$sub"/T1w/ses-02/ -b y -z y ./"$sub"/T1w/ses-02/*

dcm2niix -o $sub/func/ses-01/ -b y -z y $sub/func/ses-01/*
dcm2niix -o $sub/func/ses-02/ -b y -z y $sub/func/ses-02/*

mkdir -p BIDS/sub-"$sub"/ses-01/anat
cp $sub/T1w/ses-01/*.nii.gz BIDS/sub-"$sub"/ses-01/anat/sub-"$sub"_ses-01_T1w.nii.gz
cp $sub/T1w/ses-01/*.json BIDS/sub-"$sub"/ses-01/anat/sub-"$sub"_ses-01_T1w.json
mkdir -p BIDS/sub-"$sub"/ses-02/anat
cp $sub/T1w/ses-02/*.nii.gz BIDS/sub-"$sub"/ses-02/anat/sub-"$sub"_ses-02_T1w.nii.gz
cp $sub/T1w/ses-02/*.json BIDS/sub-"$sub"/ses-02/anat/sub-"$sub"_ses-02_T1w.json

mkdir -p BIDS/sub-"$sub"/ses-01/func
cp $sub/func/ses-01/*.nii.gz BIDS/sub-"$sub"/ses-01/func/sub-"$sub"_ses-01_task-rest_bold.nii.gz
cp $sub/func/ses-01/*.json BIDS/sub-"$sub"/ses-01/func/sub-"$sub"_ses-01_task-rest_bold.json
mkdir -p BIDS/sub-"$sub"/ses-02/func
cp $sub/func/ses-02/*.nii.gz BIDS/sub-"$sub"/ses-02/func/sub-"$sub"_ses-02_task-rest_bold.nii.gz
cp $sub/func/ses-02/*.json BIDS/sub-"$sub"/ses-02/func/sub-"$sub"_ses-02_task-rest_bold.json
done
```

## Prepare sigularity image

List available modules (e.g., singularity, FSL, ANTS)

```
module avail
```

Load singuarity and export path

```
module load singularity/3.4.1
export PATH=/usr/sbin:$PATH
```

Convert docker to singularity image (1st arg is outout, second is docker image name)

```
mkdir my_images
singularity build ./my_images/fmriprep-20.0.7.simg docker://poldracklab/fmriprep:20.0.7
```

Run preproc -> run_preproc.sh will submit jobs from job_sigularity_preproc.sh in parallel and save log files

```
sbatch run_preproc.sh
```

## Run the other scripts

Always load relevant modules used in the script (if not already done in the .sh file), such as:

```
module load fsl/6.0.0
```

Submit all images/subs

```bash
subs=`cat sublist.txt`
for sub in $subs; do
sbatch job.sh $sub
done
```

Check if jobs submitted and running:

```
squeue -u <username>
```

Cancel one of the jobs according to the id from the squeue:

```
scancel <jobid>
```

Cancel all jobs submitted by user

```
scancel -u <username>
```
  
  
