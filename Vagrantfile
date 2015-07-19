# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(2) do |config|
  config.vm.define "box" do |box|
    box.vm.box = "oel65-64"
    box.vm.hostname = "jeqo-chef.localdomain"
    box.vm.network "private_network", ip: "192.168.56.100", auto_config: true
    box.vm.synced_folder "data" , "/data", :mount_options => ["dmode=777", "fmode=777"]

    disk_path = "disks/disk1.vdi"

    box.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 2048]
      vb.customize ["modifyvm", :id, "--name"  , "jeqo-chef"]
      vb.customize ["modifyvm", :id, "--cpus"  , 2]
      vb.customize ["modifyvm", :id, "--chipset", "ich9"]

      #Script to add a new disk and expand space on OS (root and swap)
      if ARGV[0] == "up" && ! File.exist?(disk_path)
        vb.customize [
          'createhd',
          '--filename', disk_path,
          '--format', 'VDI',
          '--size', 30 * 1024
        ]

        vb.customize [
          'storageattach', :id,
          '--storagectl', 'SATA Controller',
          '--port', 1,
          '--device', 0,
          '--type', 'hdd',
          '--medium', disk_path
        ]
      end
    end

    if ARGV[0] == "up" && ! File.exist?(disk_path)
      config.vm.provision "shell" do |s|
        s.path = "bootstrap.sh"
      end

      config.vm.provision "shell" do |s|
        s.path = "increase_swap.sh"
        s.args = "4096"
      end
    end

    box.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.roles_path = "roles"

      chef.add_role "demo-soa-12c"
    end
  end

end
