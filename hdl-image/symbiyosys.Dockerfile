##################################################################################
# Base image of symbiyosys
# Reference: https://github.com/ghdl/docker
##################################################################################
FROM debian:buster-slim

# Get dependencies
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    ca-certificates \
    gcc \
    g++ \
    make \
    bison \
    flex \
    libreadline-dev \
    gawk \
    tcl-dev \
    libffi-dev \
    graphviz \
    xdot \
    pkg-config \
    python3 \
    libboost-system-dev \
    libboost-python-dev \
    libboost-filesystem-dev \
    clang \
    curl \
    git \
    gperf  \
    cmake \
    libgmp-dev \
    ninja-build \
    python-setuptools \
    python-pip \
    python-wheel \
    mercurial \
    autoconf

# Clean up
RUN apt-get autoclean && apt-get clean && apt-get -y autoremove \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------
# Download: https://github.com/YosysHQ/yosys/releases
COPY yosys-0.51.tar.gz /tmp/yosys-0.51.tar.gz

RUN cd /tmp \
    && mkdir /tmp/yosys-0.51 \
    && tar xfvz yosys-0.51.tar.gz -C /tmp/yosys-0.51
RUN mkdir /opt/yosys/ \
    && cd /tmp/yosys-0.51 \
    && make -j$(nproc) PREFIX=/opt/yosys \
    && make install PREFIX=/opt/yosys
RUN rm /tmp/yosys-0.51.tar.gz \
    && rm -rf /tmp/yosys-0.51

# ------------------------------------------------------
# Download: https://github.com/YosysHQ/sby/tags
COPY sby-0.51.tar.gz /tmp/sby-0.51.tar.gz

RUN cd /tmp \
    && tar xfvz sby-0.51.tar.gz
RUN cd /tmp/sby-0.51 \
    && make install PREFIX=/opt/symbiyosys
RUN rm /tmp/sby-0.51.tar.gz \
    && rm -rf /tmp/sby-0.51

# ------------------------------------------------------
# Download: https://github.com/SRI-CSL/yices2/releases
COPY yices2-Yices-2.6.5.tar.gz /tmp/yices2-Yices-2.6.5.tar.gz

RUN cd /tmp \
    && tar xfvz yices2-Yices-2.6.5.tar.gz
RUN cd /tmp/yices2-Yices-2.6.5 \
    && autoconf \
    && ./configure --prefix=/opt/yices2 \
    && make -j$(nproc) \
    && make install
RUN rm /tmp/yices2-Yices-2.6.5.tar.gz \
    && rm -rf /tmp/yices2-Yices-2.6.5
