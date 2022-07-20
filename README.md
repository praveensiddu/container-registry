# container-registry
Step by step instructions to setup a container registry
edit
1. Execute the commands in https://github.com/praveensiddu/container-registry/blob/master/aws/ec2-userdata either during creation of ubuntu instance or later on command line
1. Run docker registry with AWS S3 as backend. 
   1. Make sure to attach the s3 access role to your instance https://icicimov.github.io/blog/docker/Docker-Private-Registry-with-S3-backend-on-AWS/
   1. sudo ./registry.sh
   1. Test your registy https://docs.docker.com/registry/deploying/#copy-an-image-from-docker-hub-to-your-registry
  

# Setup TLS
```
sudo docker container stop registry
export MYDOMAIN=registry.swarchpoc.com
export REGISTRY_STORAGE_S3_REGION=us-east-1
export REGISTRY_STORAGE_S3_BUCKET=praveen-container-registry

sudo snap install core; sudo snap refresh core
sudo apt-get remove certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --apache
sudo ls /etc/letsencrypt/live/registry.swarchpoc.com


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



