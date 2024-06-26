# Online MTA-STS testing tool

This tool verifies whether a give host correctly implements the new in-development <a href="https://github.com/mrisher/smtp-sts">MTA-STS standard</a> for downgrade-resistant secure email. It is very new and not very well tested so don't rely on it's result too much.

Online version: https://mta-sts-tester.cl01.daniel.wydler.eu/

License: BSD 2-clause license (see LICENSE.txt).


## Requirements

* Docker & Docker Compose V2
* SSH/Terminal access (able to install commands/functions if non-existent)


## Install
1. Install docker and containerd using the script
  ```
    curl https://raw.githubusercontent.com/dwydler/mta-sts-docker/master/docker/misc/02-docker.io-installation.sh | bash
  ```
2. Clone the repository to the correct folder for docker container:
  ```
   git clone https://github.com/dwydler/mta-sts-docker.git /opt/containers/mta-sts
   git -C /opt/containers/mta-sts checkout $(git -C /opt/containers/mta-sts tag | tail -1)
  ```
3. Download dependencies:
  ```
   git -C /opt/containers/mta-sts submodule update --init --recursive
  ```
4. For IPv6 support, edit the Docker daemon configuration file, located at /etc/docker/daemon.json. Configure the following parameters and run `systemctl restart docker.service` to restart docker:
  ```
  {
    "experimental": true,
    "ip6tables": true
  }
  ```
5. Starting application with `docker compose -f /opt/containers/mta-sts/docker-compose.yml up -d`
6. Don't forget to test, that the applcation works sucessully (e.g. http(s)://IP-Addresse or FQDN/).
