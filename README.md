# Online MTA-STS testing tool

This tool verifies whether a give host correctly implements the new in-development <a href="https://github.com/mrisher/smtp-sts">MTA-STS standard</a> for downgrade-resistant secure email. It is very new and not very well tested so don't rely on it's result too much.

Online version: https://mta-sts-tester.n01.cl01.daniel.wydler.eu/

License: BSD 2-clause license (see LICENSE.txt).


## Requirements

* Docker & Docker Compose V2
* SSH/Terminal access (able to install commands/functions if non-existent)


## Install / Update
1. Clone the repository to the correct folder for docker containers
2. For IPv6 support, edit the Docker daemon configuration file, located at /etc/docker/daemon.json. Configure the following parameters and run `systemctl restart docker.service` to restart docker:
  ```
  {
    "experimental": true,
    "ip6tables": true
  }
  ```
3. Navigate to into the application folder (e.g. /opt/containers/mta-sts/)
4. Starting application with `docker compose -f docker-compose.yml up -d`
5. Don't forget to test, that the applcation works sucessully (e.g. http(s)://IP-Addresse or FQDN/).		

