FROM ubuntu:xenial

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    software-properties-common

RUN wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN add-apt-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main" -y

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    gcc \
    g++ \
    clang-3.9 \
    lldb-3.9 \
    perl \
    python \
    python-dev \
    python-setuptools \
    libgmp10 \
    libgmp-dev \
    bash \
    make \
    mawk \
    && rm -rf /var/lib/apt/lists/*

ENV CHPL_VERSION       1.15.0
ENV CHPL_HOME          /opt/chapel/$CHPL_VERSION
ENV CHPL_GMP           system
ENV CHPL_LLVM          llvm
ENV CHPL_WIDE_POINTERS node16

RUN mkdir -p /opt/chapel \
    && wget -q -O - https://github.com/chapel-lang/chapel/releases/download/$CHPL_VERSION/chapel-$CHPL_VERSION.tar.gz | tar -xzC /opt/chapel --transform 's/chapel-//' \
    && make -C $CHPL_HOME \
    && make -C $CHPL_HOME chpldoc

ENV PATH $PATH:$CHPL_HOME/bin/linux64:$CHPL_HOME/util
