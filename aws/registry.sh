#!/bin/bash

if [ -z "$REGISTRY_STORAGE_S3_REGION" ]
then
      echo "REGISTRY_STORAGE_S3_REGION env must be set. Example us-east-1"
      exit 1
fi

if [ -z "$REGISTRY_STORAGE_S3_BUCKET" ]
then
      echo "REGISTRY_STORAGE_S3_BUCKET env must be set."
      exit 1
fi

# Use this if you do not have S3
#-e "REGISTRY_STORAGE_CACHE_BLOBDESCRIPTOR=inmemory" \
sudo docker run -d -p 5000:5000 --restart=always --name registry \
-e "REGISTRY_LOG_LEVEL=debug" \
-e "REGISTRY_STORAGE=s3" \
-e "REGISTRY_STORAGE_S3_REGION=$REGISTRY_STORAGE_S3_REGION" \
-e "REGISTRY_STORAGE_S3_BUCKET=$REGISTRY_STORAGE_S3_BUCKET" \
registry:2
