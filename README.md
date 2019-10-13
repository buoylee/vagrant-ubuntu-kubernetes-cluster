# 单机 vagrant 使用 kubeadm 自动部署 kubernetes 3节点集群
***前提:需自备梯子***
## Vagrantfile配置点

- 3节点私网地址
```
$node1IP = "192.168.99.36"
$node2IP = "192.168.99.37"
$node3IP = "192.168.99.38"
```

- 梯子设置
```
$proxyServer = "http://192.168.99.1:1087"
$noProxy = "localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24"
```

- 使用vagrant创建vm,存在多块网卡,flannel需指定私网网卡对应ip, 具体查看 install/kube-flannel.yml 中 "- --iface=enp0s8"与虚机端口.

## startup
```
vagrant up
```
