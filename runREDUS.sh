#!/bin/sh

# Build and run docker container
docker build --pull --rm -t stage1-redus .
docker run --name stage2-redus -p 8888:8888 -dit stage1-redus

echo "# Redus Portable is now active, open terminal using this address: http://localhost:8888/terminal"
echo "# in your browser and File Manager (to upload and download Workspace files) using your browser at"
echo "# http://localhost:8888/workspace"
echo "# Now wait until the processing finished..."
echo "#"
echo "# IU"

