# Reference image
FROM nginx:1.25.5

# Metadata
LABEL org.opencontainers.image.authors="Daniel Wydler"

# Package lists reread and updated 
RUN apt update

# Deletes the already downloaded installation files from the package cache
RUN apt clean

# Remove the package lists
RUN rm -r /var/lib/apt/lists/*

#
CMD ["nginx", "-g", "daemon off;"]


