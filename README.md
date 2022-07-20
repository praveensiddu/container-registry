# container-registry
Step by step instructions to setup a container registry
edit
1. Execute the commands in https://github.com/praveensiddu/container-registry/blob/master/aws/ec2-userdata either during creation of ubuntu instance or later on command line
1. Run docker registry with AWS S3 as backend. 
   1. This EC2 instance needs to access aws s3. 
      1. Either attach AmazonS3FullAccess to your instance or 
      1. attach the limited s3 access role to your instance https://icicimov.github.io/blog/docker/Docker-Private-Registry-with-S3-backend-on-AWS/
   4. bash ./registry.sh
   5. Test your registy https://docs.docker.com/registry/deploying/#copy-an-image-from-docker-hub-to-your-registry
   6. Update security group to allow communication over port 5000
  

# Setup TLS
1. Update security group to allow communication over port 80 for apache and port 443 and 5000
1. Register a domain in Route 53. Example swarchpoc.com
1. Associate a elastic IP for your instance. This is required for lets encrypt to issue a certificate
1. Create a hosted zone records https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones# 
   * select the domain you have registered 
   * Create a A record under the domain you have registered. Example 
   * registry-qa.swarchpoc.com	A	Simple	-	67.202.25.114
```
sudo docker container stop registry
sudo docker container rm registry
export MYDOMAIN=registry.swarchpoc.com
export REGISTRY_STORAGE_S3_REGION=us-east-1
export REGISTRY_STORAGE_S3_BUCKET=praveen-container-registry

sudo apt install apache2
sudo snap install core; sudo snap refresh core
sudo apt-get remove certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --apache
sudo ls /etc/letsencrypt/live/$MYDOMAIN


mkdir certs
sudo cp /etc/letsencrypt/live/$MYDOMAIN/fullchain.pem certs
sudo cp /etc/letsencrypt/live/$MYDOMAIN/privkey.pem certs
sudo chown -R `id -u` certs
sudo service apache2 stop
sudo update-rc.d apache2 disable
```

# 
```
sudo docker run -d -p 443:443 --restart=always --name registry \
-e "REGISTRY_LOG_LEVEL=debug" \
-e "REGISTRY_STORAGE=s3" \
-e "REGISTRY_STORAGE_S3_REGION=$REGISTRY_STORAGE_S3_REGION" \
-e "REGISTRY_STORAGE_S3_BUCKET=$REGISTRY_STORAGE_S3_BUCKET" \
  -v "$(pwd)"/certs:/certs \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/fullchain.pem \
  -e REGISTRY_HTTP_TLS_KEY=/certs/privkey.pem  \
  registry:2
```
# Renew TLS
1. `sudo docker container stop registry`
1. `sudo certbot --apache`
1. 
   ```
   sudo cp /etc/letsencrypt/live/registry.swarchpoc.com/fullchain.pem certs
   sudo cp /etc/letsencrypt/live/registry.swarchpoc.com/privkey.pem certs
   ```
1.
   ```
   sudo docker run  -d -p 443:443 --restart=always --name registry -e "REGISTRY_LOG_LEVEL=debug" -e "REGISTRY_STORAGE=s3" -e "REGISTRY_STORAGE_S3_REGION=us-east-1" -e    "REGISTRY_STORAGE_S3_BUCKET=praveen-container-registry"   -v "$(pwd)"/certs:/certs   -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e     REGISTRY_HTTP_TLS_CERTIFICATE=/certs/fullchain.pem   -e REGISTRY_HTTP_TLS_KEY=/certs/privkey.pem    registry:2
   ```
## access the registry from another RHEL host
```
export MYDOMAIN=registry-qa.swarchpoc.com
podman pull ubuntu:16.04
podman tag ubuntu:16.04  $MYDOMAIN/my-ubuntu
podman push $MYDOMAIN/my-ubuntu
podman image rm ubuntu:16.04
podman image rm $MYDOMAIN/my-ubuntu
podman pull $MYDOMAIN/my-ubuntu

```


