#!/bin/bash

# This script is used to build all of the modules in SDXL Pipeline.
# It requires *quite a lot* of disk space - be warned!

### VERSIONS ###

### NOTE ###
# Specify the versions of the Docker and Lilypad modules in VERSIONS.env

# Change to the directory that this script is in.
cd "$(dirname "$0")"

# Load the versions
source VERSIONS.env

# Check that the Docker versions are set
if [[ -z $VLLAMA3_8B ]]; then
    echo "Please set the Docker versions in VERSIONS.env before building."
    exit 1
fi

# Build the Docker containers for each model
echo "Building Docker containers..."

# Turn on Docker BuildKit and cd to the docker directory
cd ../docker/
export DOCKER_BUILDKIT=1

# Login to the ECR public repository
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/lilypad-network

# Build the llama3 8b module
docker build -f Dockerfile-llama3-8b -t ollama:llama3-8b-lilypad$VLLAMA3_8B --target runner .

# Tag the Docker image
docker tag ollama:llama3-8b-lilypad$VLLAMA3_8B public.ecr.aws/lilypad-network/ollama:llama3-8b-lilypad$VLLAMA3_8B

# Publish the Docker containers
echo "Publishing Docker containers..."
docker push public.ecr.aws/lilypad-network/ollama:llama3-8b-lilypad$VLLAMA3_8B

echo "Done!"
