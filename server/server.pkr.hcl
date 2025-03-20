packer {
  required_plugins {
    vagrant = {
      source = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    virtualbox = {
      source = "github.com/hashicorp/virtualbox"
      version = "~> 1"
    }
    ansible = {
      source = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

source "vagrant" "ubuntu_24_04" {
  communicator = "ssh"
  source_path = "bento/ubuntu-24.04"
  provider = "virtualbox"
  output_dir = "./output"
}

build {
  sources = ["source.vagrant.ubuntu_24_04"]

  provisioner "shell" {
    inline = [
      "env DEBIAN_FRONTEND=noninteractive apt-get update",
      "env DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y",
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "./playbook.yml"
  }

  # Delete vagrant stuff
  provisioner "shell" {
    inline = [
      "ls -al /home/vagrant"
    ]
  }
}
