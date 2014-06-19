################################################################################
################################################################################
################################################################################
#run this first
#chmod x+a deploy.sh
#sh deploy.sh
#!/usr/bin/env bash
set -e

#possible to have 2 containers on 2 dif ports making illusion of 2 servers
echo '>>> Get old container id'
CID=$(sudo docker ps | grep "thecaddy/qarth" | awk '{print $1}')
echo $CID

echo '>>> Build new image'
sudo docker build -t thecaddy/qarth:master . # | tee /tmp/docker_build_result.log)
#RESULT=$(cat /tmp/docker_build_result.log | tail -n 1)
ID=$(sudo docker images | grep "thecaddy/qarth" | awk '{print $3}')
echo '>>> ID: ' $ID
if [ "$ID" == "0" ];
then
  exit -1$
fi

#gets the docker image id
#IMID=$(docker images | grep "thecaddy/qarth" | awk '{print $3}')

echo '>>> Stopping old container'
if [ "$CID" != "" ];
then
  sudo docker stop $CID
  sudo docker rm $CID
fi

echo '>>> Starting new container $ID'
sudo docker run -d -p 49160:8080 $ID

echo '>>> Cleaning up images'
#removes closed containers
sudo docker rm $(sudo docker ps -a -q)
#removes <none> images
sudo docker rmi $(sudo docker images | grep "^<none>" | awk '{print $3}')


################################################################################
################################################################################
################################################################################
