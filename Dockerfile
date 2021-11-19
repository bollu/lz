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
RUN mkdir -p /code/llvm-project/build && \
    cd /code/llvm-project/build &&  \
    cmake -GNinja ../llvm/ \
          -DLLVM_ENABLE_PROJECTS=mlir  \
          -DCMAKE_BUILD_TYPE=RelWithDebInfo
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
RUN apt-get install linux-tools-common linux-tools-generic linux-tools-cloud-amd64 linux-cloud-tools-cloud-amd64 -y
# ENV FLASK_APP=app.py
# ENV FLASK_RUN_HOST=0.0.0.0
# RUN apk add --no-cache gcc musl-dev linux-headers
# COPY requirements.txt requirements.txt
# RUN pip install -r requirements.txt
# EXPOSE 5000
# COPY . .
# CMD ["flask", "run"]

