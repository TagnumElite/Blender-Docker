FROM ubuntu:latest
LABEL authors="TagnumElite"

RUN apt-get update && \
    apt-get install -y \
        jq git curl bzip2 \
		libfreetype6 \
		libgl1-mesa-dev \
		libglu1-mesa \
		libxi6 \
		libxrender1 && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

ENV BLENDER_VERSION 2.81
ENV BLENDER_HOME /usr/local/blender

RUN export BLENDER_SHA=$(curl -sSL "https://builder.blender.org/admin/api/v2/builders/16/builds?order=-number&results__eq=0&limit=1&property=got_revision" \
    | jq ".builds[0].properties.got_revision[0].blender" | cut -c2-13 ) && \
    mkdir $BLENDER_HOME && \
    curl -SL "https://builder.blender.org/download/blender-$BLENDER_VERSION-$BLENDER_SHA-linux-glibc217-x86_64.tar.bz2" -o blender.tar.bz2 && \
    tar -jxvf blender.tar.bz2 -C $BLENDER_HOME --strip-components=1 && \
    rm blender.tar.bz2 && \
    apt-get -y remove bzip2 curl git jq && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT $BLENDER_HOME/blender -b
