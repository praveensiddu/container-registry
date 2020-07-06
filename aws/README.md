
# Instructions to setup a container registry on ubuntu EC2 instance

### Setup:

Instructions to setup docker and registry
This is how I set up my environment:

#### Installing through userdata
1. Create an ubuntu EC2. Provide the below commands as user-data so that the machine comes initialized
2. Provide roles to the EC2 instance for S3 full access( TBD this should be only to the bucket)
3. Create a bucket in S3
4. Test by copying a dummy file 
aws s3 cp registry.sh s3://praveen-container-registry/
5. start registry 
bash registry.sh

#! /bin/bash
sudo apt-get update && sudo apt-get install docker.io -y
docker ps
docker pull busybox
docker tag busybox localhost:5000/busybox
docker push localhost:5000/busybox
   
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt install unzip
unzip awscliv2.zip
sudo ./aws/install
aws --version
https://raw.githubusercontent.com/praveensiddu/container-registry/master/aws/registry.sh


   
