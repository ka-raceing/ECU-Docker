FROM arm64v8/ubuntu

# avoid config interfaces
ARG DEBIAN_FRONTEND=noninteractive

# initial update and upgrade
RUN apt-get update && apt-get upgrade -y

#--------------------------------------------------
# build tools & base dependencies
#--------------------------------------------------
RUN apt-get update && apt-get install --install-recommends -y
RUN apt-get    clang-format -y
RUN apt-get    clang-tidy -y
RUN apt-get    git -y
RUN apt-get    gcc -y
RUN apt-get    g++ -y
RUN apt-get    gdb -y
RUN apt-get    gcc-arm-linux-gnueabihf -y
RUN apt-get    g++-arm-linux-gnueabihf -y
RUN apt-get    cmake -y
RUN apt-get    make -y
RUN apt-get    zlib1g-dev -y

#vector_blf
WORKDIR /tmp/
RUN git clone https://bitbucket.org/tobylorenz/vector_blf.git # TODO include as submodule and copy inside
WORKDIR /tmp/vector_blf/build
RUN cmake -DCMAKE_C_COMPILER="/usr/bin/arm-linux-gnueabihf-gcc" -DCMAKE_CXX_COMPILER="/usr/bin/arm-linux-gnueabihf-g++" ..
RUN make

RUN export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

WORKDIR /
CMD ["bash"]