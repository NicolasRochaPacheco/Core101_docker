# A Dockerfile for Core101

# Uses Ubuntu 18 as source
FROM ubuntu:bionic


MAINTAINER Nicolas Rocha Pacheco (n.rocha11@uniandes.edu.co)

#--------------------------------------
# Prerrequisite installation
#--------------------------------------
# Update aptitude repositories
RUN apt-get update

# Installs prerrequisites
RUN apt-get install -y \
	autoconf\
	automake\
	autotools-dev\
	bc\
	bison\
  build-essential\
  curl\
  flex\
  gawk\
  git\
  gperf\
  libmpc-dev\
  libmpfr-dev\
  libgmp-dev\
  libtool\
  libexpat-dev\ 
  make\
  patchutils\
  python3\
  texinfo\
  verilator\
  zlib1g-dev

   
# -------------------------------------
# Installs RISC-V toolchain
# -------------------------------------
WORKDIR /opt/
RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
WORKDIR /opt/riscv-gnu-toolchain/
RUN ./configure --prefix=/opt/riscv --with-arch=rv32i --with-abi=ilp32
RUN make
ENV PATH="/opt/riscv/rv32i/bin:${PATH}"
WORKDIR /opt/
RUN rm -rf riscv-gnu-toolchain/

#--------------------------------------
# Source code download
#--------------------------------------
# Downloads Core101 repository on opt directory
WORKDIR /opt/
RUN mkdir L0G1C101
WORKDIR /opt/L0G1C101/
RUN git clone https://github.com/NicolasRochaPacheco/Core101.git

# Gets back to root folder
WORKDIR /
RUN echo 'Image built successfully'
