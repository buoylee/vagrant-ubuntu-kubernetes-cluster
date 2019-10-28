# -*- mode: ruby -*-
# vi: set ft=ruby :

$proxyServer = "http://192.168.99.1:1087"
$noProxy = "localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,10.0.0.0/8"
$node1IP = "192.168.99.36"
$node2IP = "192.168.99.37"
$node3IP = "192.168.99.38"

$configureBox = <<-SCRIPT
echo "configure Base: "
cd /root/install

chmod 777 docker.sh
chmod 777 kube.sh
./docker.sh
./kube.sh
SCRIPT

$configureMaster = <<-SCRIPT
echo "configure Master: "
cd /root/install
chmod 777 master.sh
./master.sh
SCRIPT

$configureNode = <<-SCRIPT
echo "configure Node: "
cd /root/install
chmod 777 node.sh
./node.sh
SCRIPT

$configureProxy = <<-SCRIPT
echo "configure Proxy: "
cd /root/install

cat > /root/install/proxy.sh <<EOF
export http_proxy=$1 && export https_proxy=$1 && export NO_PROXY=$2
EOF

cat > /root/install/http-proxy.conf <<EOF
[Service]
Environment="HTTPS_PROXY=$1" "NO_PROXY=$2"
EOF

chmod 777 proxy.sh
SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.define :node1 do |node|
      node.vm.hostname = "node1"
      node.vm.network "private_network", ip: $node1IP
      node.vm.synced_folder "install/", "/root/install"
      node.vm.provider "virtualbox" do |v|
        v.name = "node1"
        v.memory = "1024"
        v.cpus = "2"
      end
      node.vm.provision "shell", inline: $configureProxy, args: [$proxyServer, $noProxy]
      node.vm.provision "shell", inline: $configureBox
      node.vm.provision "shell", inline: $configureMaster
  end
  config.vm.define :node2 do |node|
      node.vm.hostname = "node2"
      node.vm.network "private_network", ip: $node2IP
      node.vm.synced_folder "install/", "/root/install"
      node.vm.provider "virtualbox" do |v|
        v.name = "node2"
        v.memory = "2046"
        v.cpus = "2"
      end
      node.vm.provision "shell", inline: $configureBox
      node.vm.provision "shell", inline: $configureNode
  end
  config.vm.define :node3 do |node|
      node.vm.hostname = "node3"
      node.vm.network "private_network", ip: $node3IP
      node.vm.synced_folder "install/", "/root/install"
      node.vm.provider "virtualbox" do |v|
        v.name = "node3"
        v.memory = "2046"
        v.cpus = "2"
      end
      node.vm.provision "shell", inline: $configureBox
      node.vm.provision "shell", inline: $configureNode
  end
end
