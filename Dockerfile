FROM ubuntu:20.04
WORKDIR /code
RUN apt-get update -y
ARG DEBIAN_FRONTEND=noninteractive
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install build-essential -y
RUN apt-get install cmake -y
RUN apt-get install git -y
RUN apt-get install ninja-build -y
RUN git clone https://github.com/bollu/lean4
# ADD llvm-project /code/llvm-project
RUN echo "git-clone-force-a"
RUN git clone --depth 1 https://github.com/bollu/llvm-project.git  -b cgo-2021
RUN cd /code/llvm-project && git checkout cgo-2021
RUN apt-get install -y python3.7  python3-pip
RUN apt-get install -y lld
RUN mkdir -p /code/llvm-project/build && \
    cd /code/llvm-project/build &&  \
    cmake -GNinja ../llvm/ \
          -DLLVM_ENABLE_PROJECTS=mlir  \
          -DBUILD_SHARED_LIBS=ON \
          -DCMAKE_BUILD_TYPE=Release  \
          -DLLVM_TARGETS_TO_BUILD="host"
RUN cd /code/llvm-project/build && ninja mlir-opt
RUN apt-get install -y libgmp3-dev
RUN mkdir -p /code/lean4/build/release &&  \
    cd /code/lean4/build/release && \
    git checkout 2021-cgo-artifact && \
    cmake /code/lean4/ && \
    make -j 
RUN git clone https://github.com/bollu/lz && cd lz && git checkout -b cgo-2021-artifact
RUN cd /code/llvm-project/build && ninja install mlir-opt
RUN mkdir -p /code/lz/build
RUN cd /code/lz/build && CMAKE_PREFIX_PATH=/code/llvm-project/build/ cmake -GNinja ../ && ninja
RUN apt-get install vim -y
RUN apt-get install clang -y
RUN pip install matplotlib scipy
RUN echo "bump-git-1"
RUN echo "bump-git-2"
RUN echo "bump-git-3"
RUN echo "bump-git-11"
RUN cd /code/lean4 && git remote update && git checkout origin/2021-cgo-artifact
RUN cd /code/lz && git remote update && git checkout origin/cgo-2021-artifact && cd build && ninja
ENV PATH /code/lean4/build/release/stage1/bin:$PATH
ENV LD_LIBRARY_PATH /code/lean4/build/release/stage1/lib:$LD_LIBRARY_PATH
ENV PATH /code/lz/build/bin:$PATH
RUN cd /code/lz/lean-linking-incantations && make
RUN cd /code/lz/lean-linking-incantations/lib-includes && make
RUN cd /code/lean4/tests/compiler/ && ./test_single.sh float.lean
RUN apt-get install clang-12 -y
RUN cd /code/lean4/src/runtime/ && ./mk-runtime.sh
RUN ls /code/
RUN cd /code/lean4/build/release/ && make -j
RUN git clone https://github.com/bollu/lean4 lean4-baseline
RUN mkdir -p /code/lean4-baseline/build/release
RUN mkdir -p /code/lean4-baseline/build/release &&  \
    cd /code/lean4-baseline/build/release && \
    git checkout master  && \
    cmake /code/lean4-baseline/ && \
    make -j 
RUN echo "bump-git-13"
RUN cd /code/lz && git remote update && git reset --hard origin/cgo-2021-artifact && cd build && ninja
RUN cd /code/lean4/src/runtime/ && ./mk-runtime.sh
RUN cd /code/lz/lean-linking-incantations && make clean && make && cd lib-includes && make clean && make
RUN echo "bump-git-18"
RUN cd /code/lz && git remote update && git reset --hard origin/cgo-2021-artifact && cd build && ninja
RUN cd /code/lean4-baseline/ && \
    git remote update && \
    git reset --hard origin/2021-cgo-artifact && \
    (patch -f -p1 < simpcase.patch || echo "some hunks for EmitMLIR can indeed fail, it's fine! As long as we patch simpCase.lean")
RUN cd /code/lean4-baseline && \
    rm -rf build && \
    mkdir -p build/release/ && \
    cd build/release && CC=gcc-9 CXX=g++-9 cmake ../../ && \
    make -j
RUN echo "bump-git-24"
RUN cd /code/lean4 && \
    git remote update && \
    git reset --hard origin/2021-cgo-artifact && \
    rm -rf /code/lean4/build/release && \
    mkdir -p /code/lean4/build/release && \
    cd /code/lean4/build/release &&  \
    cmake ../../ -DCMAKE_POSITION_INDEPENDENT_CODE=ON && \
    make -j
RUN useradd -ms /bin/bash nonroot
RUN chown nonroot /code/lz -R
RUN chown nonroot /code/lean4 -R
RUN chown nonroot /code/llvm-project/build/ -R
RUN apt-get install gdb curl wget -y
USER nonroot
ENV PATH /code/llvm-project/build/bin:$PATH
ENV PATH /code/lean4/build/release/stage1/bin:$PATH
ENV LD_LIBRARY_PATH /code/lean4/build/release/stage1/lib:$LD_LIBRARY_PATH
ENV PATH /code/lz/build/bin:$PATH
RUN echo "bump-git-26"
RUN cd /code/lz && git remote update && git checkout origin/cgo-2021-artifact && cd build && ninja
USER root

# ENV FLASK_APP=app.py
# ENV FLASK_RUN_HOST=0.0.0.0
# RUN apk add --no-cache gcc musl-dev linux-headers
# COPY requirements.txt requirements.txt
# RUN pip install -r requirements.txt
# EXPOSE 5000
# COPY . .
# CMD ["flask", "run"]

