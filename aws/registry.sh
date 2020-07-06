#!/bin/sh

# Use this if you do not have S3
#-e "REGISTRY_STORAGE_CACHE_BLOBDESCRIPTOR=inmemory" \
docker run -d -p 5000:5000 --restart=always --name registry \
-e "REGISTRY_LOG_LEVEL=debug" \
-e "REGISTRY_STORAGE=s3" \
-e "REGISTRY_STORAGE_S3_REGION=us-east-1" \
-e "REGISTRY_STORAGE_S3_BUCKET=praveen-container-registry" \
registry:2
