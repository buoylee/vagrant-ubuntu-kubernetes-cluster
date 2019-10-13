#!/bin/bash
# Install Docker CE
## Set up the repository:
### Install packages to allow apt to use a repository over HTTPS

export http_proxy='http://192.168.99.1:1087' && export https_proxy='http://192.168.99.1:1087' && export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24

apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common

### Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

### Add Docker apt repository.
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

## Install Docker CE.
apt-get update && apt-get install -y docker-ce=18.06.2~ce~3-0~ubuntu

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d
cat /root/install/http-proxy.conf > /etc/systemd/system/docker.service.d/http-proxy.conf
# Restart docker.
systemctl daemon-reload
systemctl restart docker

unset http_proxy && unset https_proxy && unset NO_PROXY
