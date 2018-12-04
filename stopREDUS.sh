#!/bin/sh

# Copy the result archive
rm -fr ./results/*
docker cp stage2-redus:/root/workspace/projects/results.tar.gz ./results/

# Extract the results
tar -zxvf ./results/results.tar.gz -C ./results/

# Cleaning up
docker stop stage2-redus
docker container rm stage2-redus

