# -*- mode: ruby -*-
# vi: set ft=ruby :

$configureBox = <<-SCRIPT
echo "configure Base: "
echo "now User is: "
id
cd /root/install
./docker.sh
./kube.sh
SCRIPT

$configureMaster = <<-SCRIPT
echo "configure Master: "
cd /root/install
./master.sh
kubectl apply -f kube-flannel.yml
SCRIPT

$configureNode = <<-SCRIPT
echo "configure Node: "
cd /root/install
./node.sh
SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.define :autonode1 do |autonode1|
      autonode1.vm.hostname = "autonode1"
      autonode1.vm.network "private_network", ip: "192.168.99.236"
      autonode1.vm.synced_folder "install/", "/root/install"
      autonode1.vm.provider "virtualbox" do |v|
        v.name = "autonode1"
        #v.memory = "1024"
        v.cpus = "2"
      end
      autonode1.vm.provision "shell", inline: $configureBox
      autonode1.vm.provision "shell", inline: $configureMaster
  end
  config.vm.define :autonode2 do |autonode2|
      autonode2.vm.hostname = "autonode2"
      autonode2.vm.network "private_network", ip: "192.168.99.237"
      autonode2.vm.synced_folder "install/", "/root/install"
      autonode2.vm.provider "virtualbox" do |v|
        v.name = "autonode2"
        #v.memory = "1024"
        v.cpus = "2"
      end
      autonode2.vm.provision "shell", inline: $configureBox
      autonode2.vm.provision "shell", inline: $configureNode
  end
  config.vm.define :autonode3 do |autonode3|
      autonode3.vm.hostname = "autonode3"
      autonode3.vm.network "private_network", ip: "192.168.99.238"
      autonode3.vm.synced_folder "install/", "/root/install"
      autonode3.vm.provider "virtualbox" do |v|
        v.name = "autonode3"
        #v.memory = "1024"
        v.cpus = "2"
      end
      autonode3.vm.provision "shell", inline: $configureBox
      autonode3.vm.provision "shell", inline: $configureNode
  end
end
