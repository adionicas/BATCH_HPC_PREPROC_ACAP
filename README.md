# BATCH_HPC_PREPROC_ACAP
A collection of batch scripts that can be used to run fMRI data preprocessing with singularity on a HCP.

## Prepare sigularity image

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
  
  
