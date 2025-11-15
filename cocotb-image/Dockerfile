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
# Install Icarus Verilog
# RUN brew install icarus-verilog

# -------------------------------------------------------------------
# make full access of the directory /tmp
RUN chmod 777 /tmp -R

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
# Install GHDL
# Download: https://github.com/ghdl/ghdl/releases

# COPY ghdl-4.1.0.tar.gz /tmp/ghdl-4.1.0.tar.gz

# RUN cd /tmp \
#     && tar xfvz ghdl-4.1.0.tar.gz
# RUN cd /tmp/ghdl-4.1.0 \
#     && ./configure \
#     && make --silent \
#     && make --silent install
# RUN rm /tmp/ghdl-4.1.0.tar.gz \
#     && rm -rf /tmp/ghdl-4.1.0

# -------------------------------------------------------------------
# # Install cvc

# RUN git clone https://github.com/cambridgehackers/open-src-cvc.git --depth=1 cvc \
#     && cd cvc/src \
#     && make -f makefile.cvc64 --silent \
#     && cp cvc64 /usr/local/bin \
#     && cd ../.. \
#     && rm -rf cvc

# -------------------------------------------------------------------
# # Download cocotb
# 

RUN pip install cocotb cocotbext-spi cocotbext-uart cocotbext-axi

