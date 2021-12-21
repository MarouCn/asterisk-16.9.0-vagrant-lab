# -*- mode: ruby -*-
# vi: set ft=ruby :

# Parse JSON vagrant config
require "rubygems"
require "json"
jsonConfigString = File.read('vagrant/VagrantConfig.json')
vagrantConfig = JSON.parse(jsonConfigString)

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"

  config.vm.hostname = vagrantConfig["hostname"]
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  if vagrantConfig["network"] and vagrantConfig["network"]["forwarded_ports"]
    portforwards = vagrantConfig["network"]["forwarded_ports"]

    portforwards.each do |portguest, porthost|
      config.vm.network "forwarded_port", guest: portguest, host: porthost
    end
  end

   # Create a private network, which allows host-only access to the machine
   # using a specific IP.
   # config.vm.network "private_network", ip: "192.168.33.10"
   if vagrantConfig["network"] and vagrantConfig["network"]["private_network_ip"]
     config.vm.network "private_network", ip: vagrantConfig["network"]["private_network_ip"]
   end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"
  if vagrantConfig["network"] and vagrantConfig["network"]["public_network_ip"]
    config.vm.network "public_network", ip: vagrantConfig["network"]["public_network_ip"]
  end
  
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.synced_folder ".", "/vagrant"
  
  config.vm.provider "virtualbox" do |v|
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  config.vm.provision "shell", path: "vagrant/VagrantProvision.sh"
end
