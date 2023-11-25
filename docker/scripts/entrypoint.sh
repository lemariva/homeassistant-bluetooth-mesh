#!/bin/bash

service dbus start
/usr/libexec/bluetooth/bluetooth-meshd -d --debug &
#/usr/libexec/bluetooth/bluetoothd -d &


python3 gateway.py --reload &
/bin/bash
