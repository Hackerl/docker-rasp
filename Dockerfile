FROM hackerl/centos-cpp:latest

RUN yum install -y xz unzip openssl-devel bzip2-devel vim-common libtool automake gettext && yum clean all

RUN curl -fsSL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz | tar -xz -C /tmp && cd /tmp/Python-2.7.18 && ./configure && make -j$(nproc) && make install && rm -rf /tmp/Python-2.7.18
RUN curl -fsSL https://www.python.org/ftp/python/3.6.15/Python-3.6.15.tgz | tar -xz -C /tmp && cd /tmp/Python-3.6.15 && ./configure && make -j$(nproc) && make install && pip3 install wheel && rm -rf /tmp/Python-3.6.15
RUN curl -fsSL https://ftp.gnu.org/gnu/bison/bison-3.8.tar.xz | tar -xJ -C /tmp && cd /tmp/bison-3.8 && ./configure && make -j$(nproc) && make install && rm -rf /tmp/bison-3.8
RUN curl -fsSL https://ftp.gnu.org/gnu/texinfo/texinfo-7.0.tar.xz | tar -xJ -C /tmp && cd /tmp/texinfo-7.0 && ./configure && make -j$(nproc) && make install && rm -rf /tmp/texinfo-7.0
RUN curl -fsSL https://ftp.gnu.org/gnu/binutils/binutils-2.39.tar.xz | tar -xJ -C /tmp && cd /tmp/binutils-2.39 && ./configure && make -j$(nproc) && make install && rm -rf /tmp/binutils-2.39
RUN curl -fsSL https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-15.0.6.tar.gz | tar -xz -C /tmp && cd /tmp/llvm-project-llvmorg-15.0.6 && mkdir build && cmake -B build --install-prefix=/opt/llvm-15.0.6 -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release llvm && cmake --build build -j$(nproc) && cmake --install build && rm -rf /tmp/llvm-project-llvmorg-15.0.6
RUN curl -fsSL https://nodejs.org/dist/v14.18.0/node-v14.18.0.tar.gz | tar -xz -C /tmp && cd /tmp/node-v14.18.0 && ./configure --openssl-no-asm && LDFLAGS=-lrt make -j$(nproc) install && rm -rf /tmp/node-v14.18.0
RUN curl -fsSL http://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz | tar -xz -C /tmp && cd /tmp/autoconf-2.71 && ./configure && make -j$(nproc) && make install && rm -rf /tmp/autoconf-2.71
RUN curl -fsSL https://sf1-cdn-tos.douyinstatic.com/obj/eden-cn/laahweh7uhwbps/x86_64-linux-musl-1.2.2.tar.gz | tar -xz -C /opt
RUN curl -fsSL https://download.java.net/java/GA/jdk14.0.2/205943a0976c4ed48cb16f1043c5c647/12/GPL/openjdk-14.0.2_linux-x64_bin.tar.gz | tar -xz -C /opt
RUN curl -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain=1.63.0 -t x86_64-unknown-linux-musl

ENV PATH=/root/.cargo/bin:$PATH
ENV PATH=/opt/jdk-14.0.2/bin:$PATH
ENV PATH=/opt/llvm-15.0.6/bin:$PATH