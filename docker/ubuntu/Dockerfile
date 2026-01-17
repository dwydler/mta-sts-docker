# Reference image
FROM ubuntu:jammy-20260109

# Metadata
LABEL org.opencontainers.image.authors="Daniel Wydler"

# Package lists reread and updated
# Install package(s)
# Remove the package lists
RUN apt-get update && \
    apt-get install -y \
    uwsgi \
    uwsgi-plugin-python3 \
    python3-dnspython \
    net-tools \
    iputils-ping \
    python3-pip \
    && rm -r /var/lib/apt/lists/*

#
RUN pip3 --no-cache-dir install \
    setuptools \
    wheel \
    uwsgitop \
    Flask-Limiter

#
RUN mkdir -p /etc/uwsgi/vassals \
    && chmod 755 /etc/uwsgi/vassals

#
RUN mkdir -p /etc/uwsgi/apps-enabled

#
CMD ["/usr/bin/uwsgi", "--ini", "/etc/uwsgi/vassals/mta-sts.ini"]
