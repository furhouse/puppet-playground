# -*- mode: ruby -*-
# vi: set ft=ruby :

# Puppet Provisioner provides a plugin named "puppet", so this always evaluates to true.
begin
  gem "puppet", ">=3.8"
rescue Gem::LoadError
  raise "puppet is not installed in vagrant gems! please run 'vagrant plugin install puppet'"
end

Vagrant.configure(2) do |config|

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
    config.cache.scope = :machine
  end

  config.vm.define :master do |master|
    master.puppet_install.puppet_version = "3.8.6"
    master.vm.box = "ubuntu/trusty64"
    master.vm.hostname = "vdc-puppetmaster1.localdomain"
    master.vm.network "private_network", ip: "192.168.137.2"
    master.vm.provision :hosts, :sync_hosts => true

    # r10k plugin to deploy puppet modules
    master.r10k.puppet_dir = "puppet"
    master.r10k.puppetfile_path = "puppet/Puppetfile"

    master.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "default.pp"
      puppet.module_path = "puppet/modules"
    end

    master.vm.provision "shell", inline: "sudo r10k deploy environment -pv"
    master.vm.provision "shell", inline: "sudo cp /vagrant/puppet/nodeclassifier.rb /etc/puppet/nodeclassifier.rb"
    master.vm.provision "shell", inline: "sudo cp /vagrant/puppet/autosign.conf /etc/puppet/autosign.conf"
    master.vm.provision "shell", inline: "sudo /etc/init.d/apache2 restart"
    # master.vm.provision "shell", inline: "sudo puppet agent -tv --summarize"
  end

  config.vm.define :vdc1web01 do |vdc1web01|
    vdc1web01.puppet_install.puppet_version = "3.8.6"
    vdc1web01.vm.box = "ubuntu/trusty64"
    vdc1web01.vm.hostname = "vdc1-web-01.localdomain"
    vdc1web01.vm.network "private_network", ip: "192.168.137.3"
    vdc1web01.vm.provision :hosts, :sync_hosts => true

    vdc1web01.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "puppetagent.pp"
      puppet.module_path = "puppet/modules"
    end
  end

  config.vm.define :vdc2web01 do |vdc2web01|
    vdc2web01.puppet_install.puppet_version = "3.8.6"
    vdc2web01.vm.box = "ubuntu/trusty64"
    vdc2web01.vm.hostname = "vdc2-web-01.localdomain"
    vdc2web01.vm.network "private_network", ip: "192.168.137.4"
    vdc2web01.vm.provision :hosts, :sync_hosts => true

    vdc2web01.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "puppetagent.pp"
      puppet.module_path = "puppet/modules"
    end
  end

  config.vm.define :vdc1db01 do |vdc1db01|
    vdc1db01.puppet_install.puppet_version = "3.8.6"
    vdc1db01.vm.box = "ubuntu/trusty64"
    vdc1db01.vm.hostname = "vdc1-db-01.localdomain"
    vdc1db01.vm.network "private_network", ip: "192.168.137.5"
    vdc1db01.vm.provision :hosts, :sync_hosts => true

    vdc1db01.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "puppetagent.pp"
      puppet.module_path = "puppet/modules"
    end
  end

  config.vm.define :vdc2db01 do |vdc2db01|
    vdc2db01.puppet_install.puppet_version = "3.8.6"
    vdc2db01.vm.box = "ubuntu/trusty64"
    vdc2db01.vm.hostname = "vdc2-db-01.localdomain"
    vdc2db01.vm.network "private_network", ip: "192.168.137.6"
    vdc2db01.vm.provision :hosts, :sync_hosts => true

    vdc2db01.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file  = "puppetagent.pp"
      puppet.module_path = "puppet/modules"
    end
  end

end
