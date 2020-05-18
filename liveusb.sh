#!/bin/bash

lsblk

echo ""
echo "input usb location: "
read usb

echo ""
echo "input iso file location: "
read isofile

sudo dd bs=4M if=$isofile of=$usb && sync