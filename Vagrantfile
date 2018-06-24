# -*- mode: ruby -*-

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/" + ENV['UBUNTU']
  config.vm.provision :shell, path: "tuxonice-install.sh"
  config.vm.provision :reload
  config.vm.provision :shell, path: "tuxonice-grub.sh"
  config.vm.provision :reload
  config.vm.synced_folder ".", "/vagrant"
end
