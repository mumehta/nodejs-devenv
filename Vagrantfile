# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = "nodejs"
  config.vm.box_url = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64-vagrant.box"

  config.vm.network :private_network, ip: "192.168.33.27"
  config.vm.network "forwarded_port", guest: 80, host: 80, host_ip: "127.0.0.1" 
  config.vm.network "forwarded_port", guest: 443, host: 443, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3000, host: 3000, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 9000, host: 9000, host_ip: "127.0.0.1"  
  # MongoDB ports
  config.vm.network "forwarded_port", guest: 27017, host: 27017, host_ip: "127.0.0.1" 
  config.vm.network "forwarded_port", guest: 28017, host: 28017, host_ip: "127.0.0.1" 
  # RabbitMQ ports
  config.vm.network "forwarded_port", guest: 5672, host: 5672, host_ip: "127.0.0.1" 
  config.vm.network "forwarded_port", guest: 15672, host: 15672, host_ip: "127.0.0.1" 
  config.ssh.forward_agent = true
  config.vm.synced_folder "./app", "/vagrant/app", create: true, group: "vagrant", owner: "vagrant", type: "rsync", rsync__args: ["--verbose", "--archive", "--delete", "-z"]
  config.vm.provider :virtualbox do |vbox|
    vbox.customize [ "modifyvm", :id, "--memory", 2048 ]
    vbox.customize [ "modifyvm", :id, "--cpus", 2 ]
    vbox.customize [ "modifyvm", :id, "--natdnshostresolver1", "on" ]
    vbox.customize [ "modifyvm", :id, "--ioapic", "on" ]
    vbox.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1 ]
    vbox.customize [ "setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1" ]
  end
  config.vm.network :private_network, ip: "192.168.33.27"
  config.vm.provision :shell, path: "provision/bootstrap.sh"
end