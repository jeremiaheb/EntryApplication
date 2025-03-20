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

# We use Vagrant as a source because it is very convenient and skips what
# would normally be a lot of futzing with debian-installer and preseed.cfg, as
# well as an overall lengthier build process.
#
# However, this build is not meant to provide a Vagrant box, so we attempt to
# remove all traces of Vagrant as a build step later.
source "vagrant" "ubuntu_24_04" {
  communicator = "ssh"
  source_path = "bento/ubuntu-24.04"
  provider = "virtualbox"
  template = "./server/Vagrantfile.pkr.tmpl"
  output_dir = "./server/output"
  add_force = true
  insert_key = true
}

build {
  sources = ["source.vagrant.ubuntu_24_04"]

  # Install ansible and update all packages to the latest
  provisioner "shell" {
    inline = [
      "sudo env DEBIAN_FRONTEND=noninteractive apt-get update",
      "sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y ansible",
      "sudo env DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y",
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "./server/playbook.yml"
  }

  # Cleanup before finalization
  provisioner "shell" {
    inline = [
      "sudo env DEBIAN_FRONTEND=noninteractive apt-get autopurge -y",
      "sudo env DEBIAN_FRONTEND=noninteractive apt-get dist-clean -y",
    ]
  }

  # Delete traces of Vagrant because Vagrant is not used in production
  #
  # NOTE: This must be the last provisioner because automated connectivity will
  # no longer work after this user is deleted
  provisioner "shell" {
    inline = [
      # This may partially fail because the vagrant user is still connected, but
      # it is good enough.
      "sudo deluser --debug --remove-all-files --remove-home vagrant || true",
      # Just in case something partially fails with the above command, Vagrant's
      # main files are deleted here as a defense in depth. With these
      # directories gone, Vagrant will not be usable (as intended).
      "sudo rm -rf /vagrant /home/vagrant"
    ]
  }

  post-processor "manifest" {
    output = "./server/output/manifest.json"
    strip_path = true
  }

  # Unpack .box so that .vmdk and .ovf are easily accessible
  post-processor "shell-local" {
    inline = [
      "tar --directory=./server/output --extract --verbose --file=./server/output/package.box"
    ]
  }
}
