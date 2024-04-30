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
    cmake \
    make \
    zlib1g-dev

#vector_blf
WORKDIR /tmp/
RUN git clone https://bitbucket.org/tobylorenz/vector_blf.git # TODO include as submodule and copy inside
WORKDIR /tmp/vector_blf/build
RUN cmake -DOPTION_RUN_DOXYGEN=OFF ..
RUN make install

RUN export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# bastis vector blf
RUN apt-get install doxygen -y
RUN git clone https://github.com/Technica-Engineering/vector_blf.git &&\
    cd vector_blf &&\
    mkdir build &&\
    cd build &&\
    cmake -DOPTION_RUN_DOXYGEN=OFF .. &&\
    make &&\
    make install

WORKDIR /
CMD ["bash"]
