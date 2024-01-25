#!/bin/bash

echo "Check if credentials for docker hub existing."
if [[ -z $HOME/.docker/config.json ]]; then

	read -e -p "Enter your docker hub account: " USERNAME
	docker login -u $USERNAME
else
	docker login
fi

# Enter the tag for the container
read -e -p "Enter the tag for the container: " CONTAINERTAG

#
docker buildx create --name mta-sts

#
docker buildx use mta-sts


#
cd /opt/containers/mta-sts/docker/nginx/
docker buildx build \
       	--platform linux/arm64,linux/amd64 \
       	-t wydler/mta-sts-web:$CONTAINERTAG \
       	. \
	--push

cd /opt/containers/mta-sts/docker/ubuntu/
docker buildx build \
       	--platform linux/arm64,linux/amd64 \
       	-t wydler/mta-sts-uwsgi:$CONTAINERTAG \
       	. \
       	--push

