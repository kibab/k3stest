#!/bin/sh

# Run the installer
echo "Installing k3s in server mode..."
INSTALL_K3S_SKIP_DOWNLOAD=true /vagrant/get_k3s_official.sh --disable=traefik

echo "Waiting for the node token to be created"
while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do echo "    still not there..."; sleep 1; done

# Copy the server token to the shared folder so that node boxes can connect
cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token

# Copy k3s config for using with kubectl
cp /etc/rancher/k3s/k3s.yaml /vagrant/k3s.kubeconfig
SERVER_IP=$(echo $SSH_CONNECTION | cut -f3 -d ' ')
sed -i'' s,127.0.0.1,$SERVER_IP,g /vagrant/k3s.kubeconfig
