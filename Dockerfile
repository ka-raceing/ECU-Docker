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
    git \
    gcc \
    g++ \
    gdb \
    gcc-arm-linux-gnueabihf \
    g++-arm-linux-gnueabihf \
    crossbuild-essential-arm64 \
    cmake \
    make \
    python3 \
    python3-pip \
    zlib1g-dev

RUN python3 -m pip install --break-system-packages cantools

RUN alias python=python3

# vector_blf
WORKDIR /tmp/
RUN git clone https://bitbucket.org/tobylorenz/vector_blf.git # TODO include as submodule and copy inside
WORKDIR /tmp/vector_blf/build
RUN cmake -DOPTION_RUN_DOXYGEN=OFF ..
RUN make install

RUN export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

WORKDIR /
CMD ["bash"]
