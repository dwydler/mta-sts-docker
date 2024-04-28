#!/bin/bash

# Create folder for docker containers
mkdir -p /opt/containers/

# Clone repository to local folder
git clone https://github.com/dwydler/mta-sts-docker.git /opt/containers/mta-sts/

# Display content of the folder
ls -lisa /opt/containers/mta-sts/
