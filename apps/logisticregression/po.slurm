#!/bin/bash
#SBATCH --job-name=lr
#SBATCH --partition=commons
#SBATCH -N 1
#SBATCH --time=00:15:00
#SBATCH --gres=gpu
#SBATCH --output=slurm.out
#SBATCH --error=slurm.error
#SBATCH --mail-user=ahayashi@rice.edu
#SBATCH --mail-type=ALL

cd $SLURM_SUBMIT_DIR
export CHPL_LAUNCHER=slurm-gasnetrun_ibv
export GASNET_PHYSMEM_MAX=1G
export CHPL_LAUNCHER_WALLTIME=00:15:00

./lr.baseline -nl 1 --nFeatures=65536 --nSamples=32 --nIters=1 --numTrials=10
./lr.gpu -nl 1 --nFeatures=65536 --nSamples=32 --nIters=1 --numTrials=10
for ratio in 0 25 50 75 100;
do
    ./lr.hybrid -nl 1 --nFeatures=65536 --nSamples=32 --nIters=1 --numTrials=10
done