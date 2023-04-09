#!/bin/bash
#SBATCH --time=12:00:00
#SBATCH --account=rrg-swasland
#SBATCH --mail-user=changwon.lee@mail.utoronto.ca
#SBATCH --job-name=100_r1_st1_cu
#SBATCH --cpus-per-task=4               # CPU cores/threads (keep ratio of gpu:cpu to 1:2)
#SBATCH --gres=gpu:p100:2                 # Number of GPUs (per node)
#SBATCH --mem=64G                        # memory per node
#SBATCH --mail-type=ALL
#SBATCH --array=1-1%1
#SBATCH --output=./results/ddb/%x.out


workdir=/home/$USER/projects/rrg-swasland/$USER/csc413project
SING_IMG=$workdir/misc/csc413.sif
ctscapes_zip=/home/$USER/projects/rrg-swasland/Datasets/cityscapes
gta_zip=/home/$USER/projects/rrg-swasland/Datasets/gta/gta.zip
type=r1_st1_cu
comp=100

# Load Singularity
module load singularity/3.8
echo $CUDA_VISIBLE_DEVICES

#? Unzip dataset
unzip -qq ${ctscapes_zip}/'*.zip' -d $SLURM_TMPDIR
unzip -qq gta.zip -d $SLURM_TMPDIR

VOLUMES="--bind=${workdir}/src:/home/src
         --bind=${workdir}/misc:/home/misc
         --bind=${workdir}/results:/home/results
         --bind=${workdir}/submodules:/home/submodules
         --bind=${SLURM_TMPDIR}:/home/data
         --bind=${workdir}/DDB_${type}.bash:/home/run.bash"

#? Start singularity container
BASE_CMD="bash run.bash $comp"

CONTAINER_CMD="SINGULARITYENV_CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES \
singularity exec --writable-tmpfs --nv -c -e --pwd /home \
--env USER=$USER \
$VOLUMES \
$SING_IMG \
$BASE_CMD"

eval $CONTAINER_CMD

#********************************************
#*Basic commands for compute canada jobs
#squeue -A rrg-swasland_gpu
#sq
#sbatch <compute canada script>
#scancel <job id>
#scancel -u $USER
#scancel -t PENDING -u $USER