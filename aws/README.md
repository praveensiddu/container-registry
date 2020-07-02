sudo apt-get update && sudo apt-get install docker.io -y

docker ps
    6  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    7  cd ubuntu
    8  set -o vi
    9  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   10  unzip awscliv2.zip
   11  apt install unzip
   12  unzip awscliv2.zip
   13  ./aws/install
   14  aws --version
   15  cat registry.sh
   16  history
   17  vi registry.sh
   18  aws s3 cp registry.sh s3://praveen-container-registry/
   19  bash registry.sh
   20  docker pull busybox
   21  docker tag busybox localhost:5000/busybox
   22  docker push localhost:5000/busybox

   apt-get update &&     sudo apt-get install docker.io -y
    5  docker ps
    6  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    7  cd ubuntu
    8  set -o vi
    9  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   10  unzip awscliv2.zip
   11  apt install unzip
   12  unzip awscliv2.zip
   13  ./aws/install
   14  aws --version
   15  cat registry.sh
   16  history
vi registry.sh
aws s3 cp registry.sh s3://praveen-container-registry/
bash registry.sh
docker pull busybox
docker tag busybox localhost:5000/busybox
docker push localhost:5000/busybox
   
