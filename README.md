# container-registry
Step by step instructions to setup a container registry
edit
1. Execute the commands in aws/ec2-userdata either during creation of ubuntu instance or later on command line
1. Run docker registry with AWS S3 as backend. 
1. Make sure to attach the s3 access role to your instance https://icicimov.github.io/blog/docker/Docker-Private-Registry-with-S3-backend-on-AWS/
1. sudo ./registry.sh
1. Test your registy https://docs.docker.com/registry/deploying/#copy-an-image-from-docker-hub-to-your-registry
1. 
