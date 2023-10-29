FROM debian:latest

# avoid config interfaces
ARG DEBIAN_FRONTEND=noninteractive

# initial update and upgrade
RUN apt-get update && apt-get upgrade -y

#--------------------------------------------------
# build tools & base dependencies
#--------------------------------------------------
RUN apt-get update && apt-get install --install-recommends -y \
    clang-format \
    clang-tidy \
    gcc \
    g++ \
    gcc-arm-linux-gnueabihf \
    g++-arm-linux-gnueabihf \
    cmake \
    make
