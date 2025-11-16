# ============================
# Stage 1: Builder
# ============================
FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    perl make flex gnat swig autoconf g++ bison libfl2 libfl-dev \
    libgoogle-perftools-dev numactl python3-dev python3-pip python3-venv \
    git help2man pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Build Verilator
RUN cd /tmp \
    && git clone https://github.com/verilator/verilator.git \
    && cd verilator \
    && git checkout v5.042 \
    && autoconf \
    && ./configure \
    && make -j"$(nproc)" \
    && make install DESTDIR=/tmp/verilator-install

# Install Python packages (inside builder)
RUN pip3 install --prefix=/tmp/python-packages \
    pytest flake8 pylint pytype mypy gcovr cherrypy dowser \
    cocotb cocotbext-spi cocotbext-uart cocotbext-axi


# ============================
# Stage 2: Runtime (minimal)
# ============================

FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install runtime-only dependencies
RUN apt-get update && apt-get install -y \
    perl python3 python3-pip libfl2 numactl gtkwave \
    && rm -rf /var/lib/apt/lists/*

# Copy Verilator runtime files
COPY --from=builder /tmp/verilator-install/usr/local/ /usr/local/

# Copy python packages installed with --prefix
COPY --from=builder /tmp/python-packages /usr/local/

# Ensure python sees local prefix
ENV PYTHONPATH=/usr/local/lib/python3.10/dist-packages:$PYTHONPATH

RUN chmod 777 /tmp -R

WORKDIR /workspace
ENTRYPOINT ["/bin/bash"]

