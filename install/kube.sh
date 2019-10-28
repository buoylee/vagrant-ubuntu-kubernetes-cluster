#!/bin/bash
# export http_proxy='http://192.168.99.1:1087' && export https_proxy='http://192.168.99.1:1087' && export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24

eval $(cat /root/install/proxy.sh)

apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y --allow-change-held-packages kubelet kubeadm kubectl

# export INTERNAL_IP_FOR_CLUSTER=$(ifconfig enp0s8 |grep "inet addr" | awk '{print $2}' |awk -F: '{print $2}')
# echo KUBELET_EXTRA_ARGS=--node-ip="$INTERNAL_IP_FOR_CLUSTER" >> /var/lib/kubelet/kubeadm-flags.env
# systemctl daemon-reload
# systemctl restart kubelet

apt-mark hold kubelet kubeadm kubectl
# unset http_proxy && unset https_proxy && unset NO_PROXY
