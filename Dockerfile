ARG DOCKER_BASE
FROM $DOCKER_BASE
ARG DEVICE

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get --no-install-recommends install -yq git cmake build-essential \
  libgl1-mesa-dev libsdl2-dev \
  libsdl2-image-dev libsdl2-ttf-dev libsdl2-gfx-dev libboost-all-dev \
  libdirectfb-dev libst-dev mesa-utils xvfb x11vnc \
  libsdl-sge-dev python3-pip clang

RUN python3 -m pip install --upgrade pip setuptools
RUN pip3 install --no-cache-dir tensorflow==1.15.* dm-sonnet==1.* psutil

RUN pip3 install --no-cache-dir git+https://github.com/openai/baselines.git@master
ENV CC=/usr/bin/clang
ENV CXX=/usr/bin/clang++
COPY . /gfootball
RUN cd /gfootball && pip3 install .
WORKDIR '/gfootball'
