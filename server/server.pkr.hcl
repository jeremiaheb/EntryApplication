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

variable "ubuntu_iso_url" {
  type = string
  default = "https://releases.ubuntu.com/noble/ubuntu-24.04.2-desktop-amd64.iso"
}

variable "ubuntu_iso_checksum" {
  type = string
  default = "sha256:d7fe3d6a0419667d2f8eff12796996328daa2d4f90cd9f87aa9371b362f987bf"
}

source "virtualbox-iso" "ubuntu_24" {
  vm_name = "ubuntu_24"
  disk_size = 50000
  cpus = 2
  memory = 2048
  headless = true

  iso_url = var.ubuntu_iso_url
  iso_checksum = var.ubuntu_iso_checksum

  guest_os_type = "Ubuntu_64"
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_wait_timeout = "20m"

  http_directory = "./http"

  boot_command = [
    "<esc><wait>",
    "<esc><wait>",
    "<enter><wait>",
    "/install/vmlinuz noapic ",
    "auto=true priority=critical ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "debian-installer=en_US locale=en_US keyboard-configuration/layoutcode=us ",
    "-- <enter>"
  ]
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
}

build {
  sources = ["source.virtualbox-iso.ubuntu_24"]

  provisioner "ansible-local" {
    playbook_file = "./playbook.yml"
  }

  provisioner "shell" {
    inline = [
      "env DEBIAN_FRONTEND=noninteractive apt-get update",
      "env DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y",
    ]
  }

  post-processor "vagrant" {
    output = "./output/ubuntu-24.box"
  }

  # post-processor "artifice" {
  #   files = ["{{.BuildName}}/{{.Provider}}/*.vmdk"]
  #   destination = "./output/ubuntu-24.vmdk"
  # }
}
