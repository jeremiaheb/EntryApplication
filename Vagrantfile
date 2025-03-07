# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # https://portal.cloud.hashicorp.com/vagrant/discover?query=bento%2Fubuntu-
  config.vm.box = "bento/ubuntu-24.04"

  # Forward 3000 from guest to 3000 on host
  config.vm.network "forwarded_port", guest: 3000, host: 3000, host_ip: "127.0.0.1"

  # Host-only networking can be more convenient in some cases
  config.vm.network "private_network", ip: "192.168.56.10"

  # Share this folder as /vagrant within the VM
  config.vm.synced_folder ".", "/vagrant"

  # Allow additional time on slower systems
  config.vm.boot_timeout = 10 * 60 # seconds

  # VirtualBox configuration
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true if ENV["VIRTUALBOX_GUI"]

    # Customize VM resources
    vb.memory = 2048 # MB
    vb.cpus = 2
  end

  # Provisioning with Ansible
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "server/playbook.yml"
  end
end
