#!/bin/sh
CURL="curl-7.21.0"

cd $(dirname $0)
curl -O "http://curl.haxx.se/download/${CURL}.tar.gz"
tar zxvf ${CURL}.tar.gz

cd ${CURL}
./configure --prefix=${PWD}/../extlib --disable-shared --with-random=/dev/urandom CC=/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/gcc CFLAGS="-arch i386 -isysroot /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.0.sdk" CPP=/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/cpp AR=/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/ar
make
make install
