
# Instructions to setup a container registry on ubuntu EC2 instance

### Setup:

Instructions to setup docker and registry
This is how I set up my environment:

#### Installing through userdata
1. Create an ubuntu EC2. Provide the commands in file https://raw.githubusercontent.com/praveensiddu/container-registry/master/aws/ec2-userdata so that the machine comes initialized
2. Provide roles to the EC2 instance for S3 full access( TBD this should be only to the bucket)
3. Create a bucket in S3
4. Test by copying a dummy file 
aws s3 cp registry.sh s3://praveen-container-registry/
5. start registry 
bash registry.sh




   
