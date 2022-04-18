# BATCH_HPC_PREPROC_ACAP
A collection of batch scripts that can be used to run fMRI data preprocessing with singularity on a HCP.

## Prepare sigularity image

Load singuarity and export path

```
module load singularity/3.4.1
export PATH=/usr/sbin:$PATH
```

It is a wise idea to check the last ver of fmriprep and replace 2.0.7 accordingly

```
mkdir my_images
singularity build ./my_images/fmriprep-20.0.7.simg docker://poldracklab/fmriprep:20.0.7
```


## Run the other scripts

Always load relevant module used in the script, such as:

```
module load fsl/6.0.0
```

Submit all images/subs

```
subs=`cat sublist.txt`
for sub in $subs; do
sbatch job.sh $sub
done
```
