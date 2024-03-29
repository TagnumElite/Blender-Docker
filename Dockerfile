FROM ubuntu:latest
LABEL authors="TagnumElite"

RUN apt-get update && \
    apt-get install -y \
        curl bzip2 \
        libfreetype6 \
        libgl1-mesa-dev \
        libglu1-mesa \
        libxi6 \
        libxrender1 && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

ENV BLENDER_MAJOR 2.80rc2
ENV BLENDER_VERSION 2.80
ENV BLENDER_HOME /usr/local/blender

RUN mkdir $BLENDER_HOME && \
    curl -SL "https://download.blender.org/release/Blender$BLENDER_VERSION/blender-$BLENDER_MAJOR-linux-glibc217-x86_64.tar.bz2" -o blender.tar.bz2 && \
    tar -jxvf blender.tar.bz2 -C $BLENDER_HOME --strip-components=1 && \
    rm blender.tar.bz2 && \
    apt-get remove -y curl bzip2 && \
    apt-get -y autoremove

ENTRYPOINT $BLENDER_HOME/blender -b