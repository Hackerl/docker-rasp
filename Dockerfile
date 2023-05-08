FROM hackerl/centos-cpp:latest

RUN yum install -y python-devel python3-devel bison libtool automake gettext-devel vim-common && yum clean all

RUN pip3 install wheel
RUN curl -fsSL https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-15.0.6.tar.gz | tar -xz -C /tmp && cd /tmp/llvm-project-llvmorg-15.0.6 && mkdir build && cmake -B build --install-prefix=/opt/llvm-15.0.6 -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release llvm && cmake --build build -j$(nproc) && cmake --install build --strip && rm -rf /tmp/llvm-project-llvmorg-15.0.6
RUN curl -fsSL https://rpm.nodesource.com/setup_16.x | bash - && yum install -y nodejs
RUN curl -fsSL https://musl.cc/x86_64-linux-musl-native.tgz | tar -xz -C /opt
RUN curl -fsSL https://download.java.net/java/GA/jdk14.0.2/205943a0976c4ed48cb16f1043c5c647/12/GPL/openjdk-14.0.2_linux-x64_bin.tar.gz | tar -xz -C /opt
RUN curl -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path -t x86_64-unknown-linux-musl

ENV PATH=/root/.cargo/bin:$PATH
ENV PATH=/opt/jdk-14.0.2/bin:$PATH
ENV PATH=/opt/llvm-15.0.6/bin:$PATH
ENV JAVA_HOME=/opt/jdk-14.0.2