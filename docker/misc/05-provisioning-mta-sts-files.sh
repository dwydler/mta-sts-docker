#!/bin/bash

# Create folder for docker containers
mkdir -p /opt/containers/

# Clone repository to local folder
git clone https://codeberg.org/wd/mta-sts-docker.git /opt/containers/mta-sts/

# Display content of the folder
ls -lisa /opt/containers/mta-sts/
