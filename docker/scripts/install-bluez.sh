#
# Docker helper script to install BlueZ with bluetooth mesh support
#
# https://www.bluetooth.com/wp-content/uploads/2020/04/Developer-Study-Guide-How-to-Deploy-BlueZ-on-a-Raspberry-Pi-Board-as-a-Bluetooth-Mesh-Provisioner.pdf

set -e
export BLUEZ_VERSION=5.66

# clone recent version
wget http://www.kernel.org/pub/linux/bluetooth/bluez-${BLUEZ_VERSION}.tar.gz
tar -xvf bluez-${BLUEZ_VERSION}.tar.gz 
cd bluez-${BLUEZ_VERSION}
        
./configure --prefix=/usr \
    --mandir=/usr/share/man \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --enable-mesh \
    --enable-testing \
    --enable-tools 

# build and install
make -j4
make -j4 install
