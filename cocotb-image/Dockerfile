# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Re-synchronize the OS package index
RUN sudo apt-get update

# Install all needed packages for all simulators
RUN sudo apt-get install -y \
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
    python-setuptools \
    python3-venv\
    help2man
RUN sudo rm -rf /var/lib/apt/lists/*

# Install Python with --enable-shared
ARG PYTHON_VERSION=3.9.2
RUN rm -rf ${HOME}/.pyenv/versions/${PYTHON_VERSION}
RUN PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}

RUN pip3 install --upgrade pip

# Install extra packages
RUN pip3 install -U pytest flake8 pylint pytype mypy gcovr cherrypy dowser

# -------------------------------------------------------------------
# Install Icarus Verilog
# RUN brew install icarus-verilog

# -------------------------------------------------------------------
# make full access of the directory /tmp
RUN sudo chmod 777 /tmp -R

# -------------------------------------------------------------------
# Install Verilator
# Download: https://github.com/verilator/verilator/tags

# COPY verilator-5.022.tar.gz /tmp/verilator-5.022.tar.gz

# RUN cd /tmp \
#     && tar xfvz verilator-5.022.tar.gz
# RUN cd /tmp/verilator-5.022 \
#     && unset VERILATOR_ROOT \
#     && autoconf \
#     && ./configure \
#     && make --silent \
#     && sudo make --silent install
# RUN rm -rf /tmp/verilator-5.022 \
#     rm /tmp/verilator-5.022.tar.gz

# -------------------------------------------------------------------
# Install GHDL
# Download: https://github.com/ghdl/ghdl/releases

# COPY ghdl-4.1.0.tar.gz /tmp/ghdl-4.1.0.tar.gz

# RUN cd /tmp \
#     && tar xfvz ghdl-4.1.0.tar.gz
# RUN cd /tmp/ghdl-4.1.0 \
#     && ./configure \
#     && make --silent \
#     && sudo make --silent install
# RUN rm /tmp/ghdl-4.1.0.tar.gz \
#     && rm -rf /tmp/ghdl-4.1.0

# -------------------------------------------------------------------
# # Install cvc

# RUN git clone https://github.com/cambridgehackers/open-src-cvc.git --depth=1 cvc \
#     && cd cvc/src \
#     && make -f makefile.cvc64 --silent \
#     && sudo cp cvc64 /usr/local/bin \
#     && cd ../.. \
#     && rm -rf cvc

# -------------------------------------------------------------------
# # Download cocotb
# ENV VIRTUAL_ENV=/opt/venv
# ENV PATH="$VIRTUAL_ENV/bin:$PATH"
# RUN sudo chmod 777 /opt -R
# RUN python3 -m venv $VIRTUAL_ENV
# RUN cd /opt \
#     && git clone https://github.com/cocotb/cocotb.git --depth 1 --branch v1.8.0

