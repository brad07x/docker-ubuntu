# Base - ubuntu:18.04 bionic
FROM ubuntu:18.04

# Image Metadata
LABEL org.opencontainers.image.authors="bstevens@havensight.net" \
      org.opencontainers.image.created="2022-01-02T18:12:34-05:00" \
      org.opencontainers.image.source="https://github.com/brad07x/docker-ubuntu" \
      org.opencontainers.image.documentation="https://github.com/brad07x/docker-ubuntu" \
      org.opencontainers.image.version="0.1.0-alpha" \
      org.opencontainers.image.title="Unofficial Ubuntu Bionic MultiArch Sismics Image" \
      org.opencontainers.image.description="Unofficial Ubuntu Bionic (18.04) MultiArch Sismics Image"

# Run Debian in non interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install Initial Packages and Sismics PGP Key
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates software-properties-common curl gnupg tzdata
RUN curl -fsSL https://www.sismics.com/pgp | apt-key add -

# OMIT Sismics Repo
# RUN add-apt-repository "deb [arch=amd64] https://nexus.sismics.com/repository/apt-bionic/ bionic main"

# Configure Locale Settings & Timezone
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

# Copy Configuration Files
COPY etc /etc

# .bashrc Setup
RUN echo "for f in \`ls /etc/bashrc.d/*\`; do . \$f; done;" >> ~/.bashrc

# Install Additional Packages & Cleanup
RUN apt-get -y -q install vim less procps unzip wget && \
    rm -rf /var/lib/apt/lists/*
