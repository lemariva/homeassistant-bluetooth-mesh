FROM balenalib/raspberrypi3-python:3.10-sid
RUN [ "cross-build-start" ]

RUN apt-get -y update && apt-get -y upgrade && apt-get -y install \
    build-essential \
    wget \
    git \
    libglib2.0-dev \
    python3-docutils \
    python3-dev \
    cargo \ 
    pkg-config \
    udev \
    systemd \
    cmake \
    autoconf \
    libtool \
    dbus \
    libdbus-1-dev \
    libudev-dev \
    libical-dev \
    libreadline-dev \
    libssl-dev \
    libusb-dev \
    libffi-dev \
    autoconf \
    automake \
    libbluetooth-dev \
    libreadline-dev


# install BlueZ with mesh support
WORKDIR /opt/build
COPY ./docker/scripts/install-ell.sh .
RUN sh ./install-ell.sh

WORKDIR /opt/build
COPY ./docker/scripts/install-json-c.sh .
RUN sh ./install-json-c.sh

WORKDIR /opt/build
COPY ./docker/scripts/install-bluez.sh .
RUN sh ./install-bluez.sh

# install bridge
WORKDIR /opt/hass-ble-mesh
COPY ./gateway/* .
COPY ./requirements.txt .
RUN pip3 install -r requirements.txt 

# mount config
WORKDIR /config
VOLUME /config

# run bluetooth service and bridge
WORKDIR /opt/hass-ble-mesh/gateway
COPY ./docker/scripts/entrypoint.sh .


ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]

RUN [ "cross-build-end" ]