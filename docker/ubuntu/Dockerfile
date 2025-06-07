# Reference image
FROM ubuntu:jammy-20250530

# Metadata
LABEL org.opencontainers.image.authors="Daniel Wydler"

# Package lists reread and updated
RUN apt update

# Install package(s)
RUN apt install -y uwsgi uwsgi-plugin-python3 python3-flask python3-dnspython
RUN apt install -y net-tools iputils-ping

RUN apt install -y python3-pip
RUN pip3 install setuptools wheel
RUN pip3 install uwsgitop
RUN pip3 install Flask-Limiter

# Deletes the already downloaded installation files from the package cache
RUN apt clean

# Remove the package lists
RUN rm -r /var/lib/apt/lists/*

#
RUN mkdir -p /etc/uwsgi/vassals
RUN chmod 755 /etc/uwsgi/vassals

#
RUN mkdir -p /etc/uwsgi/apps-enabled


CMD ["/usr/bin/uwsgi", "--ini", "/etc/uwsgi/vassals/mta-sts.ini"]
