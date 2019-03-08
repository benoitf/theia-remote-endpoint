### Dockerfile used to build nodejs with pkg patch but also making it fully static so it can run on a plain alpine container

FROM alpine:3.9.2 as builder
RUN apk add --no-cache git make gcc g++ python linux-headers clang
RUN git clone  -b 'v8.11.3' --single-branch --depth 1 https://github.com/nodejs/node
WORKDIR node
RUN wget https://raw.githubusercontent.com/zeit/pkg-fetch/master/patches/node.v8.11.3.cpp.patch
RUN patch -p1 < node.v8.11.3.cpp.patch
RUN ./configure --fully-static
RUN make -j8
RUN pwd
RUN ls -lah out/Release/node
