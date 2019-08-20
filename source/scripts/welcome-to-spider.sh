#!/bin/bash

#--- Define the job requirements ---

#SBATCH -N 1			# number of nodes
#SBATCH -c 1			# number of cores; coupled to 8000 MB memory per core
#SBATCH -t 10:00		# maximum run time in [HH:MM:SS] or [MM:SS] or [minutes]
#SBATCH -p normal		# partition (queue); job can run up to 5 days

#--- Run your application ---

echo ""
echo "====================================================="
echo "     Dear" $USER "Welcome to Spider         "
echo "====================================================="

echo ""
PROJECT=$(echo $USER | cut -d '-' -f1)
echo "The project space for your project ${PROJECT} is located at"
ls -d /project/$PROJECT
echo "which consists of the following directories"
ls /project/$PROJECT

echo ""
echo "Create some random numbers in file 'randomlist':"
for i in {1..10}
do
    echo $RANDOM >> randomlist
done
cat $PWD/randomlist

echo ""
echo "You just executed your first job on "$HOSTNAME" with a job ID "$SLURM_JOBID
sleep 30s
