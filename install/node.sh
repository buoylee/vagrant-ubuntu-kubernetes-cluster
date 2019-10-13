#!/bin/bash

# export http_proxy='http://192.168.99.1:1087' && export https_proxy='http://192.168.99.1:1087' && export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24

eval $(cat /root/install/proxy.sh)

sh /root/install/kubeadm_join_cmd.sh

unset http_proxy && unset https_proxy && unset NO_PROXY
