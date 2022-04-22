#!/bin/sh

echo "Waiting for the node token to appear"
while [ ! -f /vagrant/node-token ]; do echo "    still not there..."; sleep 1; done

NODE_TOKEN=$(cat /vagrant/node-token)
# Run the installer
INSTALL_K3S_SKIP_DOWNLOAD=true K3S_TOKEN=${NODE_TOKEN} K3S_URL=https://172.16.8.10:6443 /vagrant/get_k3s_official.sh
