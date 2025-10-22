FROM --platform=$BUILDPLATFORM tonistiigi/xx AS xx

FROM --platform=$BUILDPLATFORM python:3.9-slim-bookworm

# copy xx scripts to your build stage
COPY --from=xx / /
RUN xx-info env

RUN xx-apt update -y

# Fetch proj
RUN xx-apt -y install git
RUN git clone https://github.com/OSGeo/PROJ.git /proj

# Install project dependencies
RUN xx-apt -y install sqlite3 libsqlite3-dev libtiff-dev libcurl4 libcurl4-openssl-dev
RUN python -m pip install pyyaml pytest importlib-metadata

# Install build dependencies
RUN xx-apt -y install build-essential
RUN xx-apt -y install g++ gcc clang lld libc6-dev
RUN xx-apt -y install cmake make git

WORKDIR /proj
RUN mkdir build dist
WORKDIR /proj/build

COPY src/ /proj/src/
COPY command.sh /usr/local/bin/command.sh
RUN . command.sh
WORKDIR /proj/build/bin