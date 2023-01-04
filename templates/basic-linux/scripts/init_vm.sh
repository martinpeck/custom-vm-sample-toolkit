#!/bin/bash

echo "init_vm.sh: START"
sudo apt update
sudo apt upgrade -y
sudo apt install -y cowsay --no-install-recommends

## Cleanup
echo "init_vm.sh: Cleanup"
rm /tmp/init_vm.sh
