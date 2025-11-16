# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Re-synchronize the OS package index
RUN apt-get update

# Install all needed packages for all simulators
RUN apt-get install -y \
    perl \
    make \
    flex \
    gnat \
    gtkwave \
    swig \
    autoconf \
    g++ \
    bison \
    libfl2 \
    libfl-dev \
    ccache \
    libgoogle-perftools-dev \
    numactl \
    perl-doc \
    python3-dev \
    python3-pip \
    python3-venv \
    python-setuptools \
    git \
    help2man
RUN rm -rf /var/lib/apt/lists/*

# Install extra packages
RUN pip3 install -U pytest flake8 pylint pytype mypy gcovr cherrypy dowser

# -------------------------------------------------------------------
# make full access of the directory /tmp
RUN chmod 777 /tmp -R

# -------------------------------------------------------------------
## Install Icarus Verilog
RUN brew install icarus-verilog

# -------------------------------------------------------------------
# Install Verilator

RUN cd /tmp \
    && git clone https://github.com/verilator/verilator.git \
    && cd verilator \
    && git checkout v5.042 \
    && unset VERILATOR_ROOT \
    && autoconf \
    && ./configure \
    && make --silent \
    && make --silent install

RUN rm -rf /tmp/Verilator

# -------------------------------------------------------------------
# # Download cocotb
# 

RUN pip3 install cocotb cocotb-test cocotbext-axi

