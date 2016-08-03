FROM ubuntu:14.04

MAINTAINER Hyungro Lee <hroe.lee@gmail.com>

# Instruction is based on http://docs.opencv.org/trunk/d7/d9f/tutorial_linux_install.html

# Compiler
RUN apt-get update && apt-get install -y build-essential

# required
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev

# optional
RUN apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

# Latest OpenCV from Github repository
RUN  git clone https://github.com/opencv/opencv.git && \
     git clone https://github.com/opencv/opencv_contrib.git && \
     cd opencv && \
     mkdir build && \
     cd build && \
     cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_C_EXAMPLES=ON \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON .. && \
     make -j$(nproc) && \
     make install

# libdc1394 error: Failed to initialize libdc1394
RUN sed -i -e 's/exit 0/ln \/dev\/null \/dev\/raw1394;exit 0/' /etc/rc.local
