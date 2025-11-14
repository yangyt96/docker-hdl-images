# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    wget \
    git \
    curl \
    sudo \
    pkg-config \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3-pip \
    make \
    autoconf \
    g++ \
    flex \
    bison \
    libfl2 \
    libfl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Make python3.11 the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Upgrade pip
RUN python3 -m pip install --upgrade pip setuptools wheel

# Install cocotb version 2.0.x
RUN pip install "cocotb~=2.0"

# Install Verilator (latest stable)
RUN apt-get update && apt-get install -y \
    git \
    autoconf \
    g++ \
    flex \
    bison \
    pkg-config \
    && git clone https://github.com/verilator/verilator.git /opt/verilator \
    && cd /opt/verilator \
    && git pull \
    && autoconf \
    && ./configure \
    && make -j$(nproc) \
    && make install \
    && cd / \
    && rm -rf /opt/verilator \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PATH="/usr/local/share/verilator/bin:${PATH}"

# Set work directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
