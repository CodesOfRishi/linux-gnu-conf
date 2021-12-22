#!/usr/bin/env bash

echo -n "Kernel name: "
echo `uname -s`

echo -n "Network node hostname: ";
echo `uname -n`

echo -n "Kernel releas: ";
echo `uname -r`

echo -n "Kernel version: ";
echo `uname -v`

echo -n "Machine hardware name: ";
echo `uname -m`

echo -n "Processor type: "
echo `uname -p`

echo -n "Hardware platform (non-portable): "
echo `uname -i`

echo -n "Operating system: "
echo `uname -o`
