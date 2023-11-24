#!/bin/bash

echo "--------------------"
echo "/home/dnanexus/run_manta.sh running..."
echo "--------------------"

# arguments
bam=$1
ref=$2
sample=$3

# download samplot docker tar
echo "Downloading docker tar file..."
dx download project-G729Kkj4fq4Q9X1BPy0807bK:file-GbP2gb04fq4f74z772KYZGBB

# load docker image
echo "Loading docker image..."
docker load -i manta.1.6.0.tar

# print parameters
echo "--------------------"
echo "Bash parameters..."
echo "--------------------"
echo "bam=$bam"
echo "ref=$ref"
echo "sample=$sample"

# make output folder
mkdir -p /home/dnanexus/out

# run docker
echo "Starting docker..."
docker run -it --name manta -v $(pwd):/data --workdir /data -d swglh/manta:1.6.0

# run manta config file
echo "Running Manta config..."
docker exec manta /manta-1.6.0.centos6_x86_64/bin/configManta.py \
    --bam $bam \
    --referenceFasta $ref \
    --runDir /data/out \

# run manta workflow
echo "Running Manta workflow..."
docker exec manta /data/out/runWorkflow.py

# complete
echo "Manta is complete..."

# add prefix to output files
echo "Adding prefix to output files..."
find /home/dnanexus/out/. -type f -exec sh -c 'mv -- "$0" "$(dirname "$0")/'"$sample"'.$(basename "$0")"' {} \;
