#!/bin/bash

# export http_proxy='http://192.168.99.1:1087' && export https_proxy='http://192.168.99.1:1087' && export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24

eval $(cat /root/install/proxy.sh)

export MASTER_NODE_IP_FOR_KUBEADM=$(ifconfig enp0s8 |grep "inet addr" | awk '{print $2}' |awk -F: '{print $2}')

kubeadm init --v=5 --pod-network-cidr=10.244.0.0/16  --apiserver-advertise-address=$MASTER_NODE_IP_FOR_KUBEADM 

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubeadm token create --print-join-command > /root/install/kubeadm_join_cmd.sh
chmod +x /root/install/kubeadm_join_cmd.sh

kubectl apply -f kube-flannel.yml

unset http_proxy && unset https_proxy && unset NO_PROXY

echo 'alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kn="kubectl --namespace"
alias kgn="kubectl get --namespace"
alias kdn="kubectl describe --namespace"
alias kga="kubectl get -A"' >> ~/.bashrc
