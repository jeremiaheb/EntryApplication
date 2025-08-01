# EntryApplication

[![Build Status](https://github.com/jeremiaheb/EntryApplication/actions/workflows/ci.yml/badge.svg)](https://github.com/jeremiaheb/EntryApplication/actions/workflows/ci.yml)
[![Dependabot enabled](https://img.shields.io/badge/dependabot-enabled-025e8c?logo=Dependabot)](https://github.com/jeremiaheb/EntryApplication/security/dependabot)

**EntryApplication** is a Ruby on Rails application for collecting fish, benthic and coral demographic samples.

## Development Setup

### Vagrant

A [Vagrant](https://www.vagrantup.com) virtual machine (VM) is provided for local development. It runs the same Ansible provisioning as the production virtual machine, plus some additional commands that make it useful for development.

First, [install Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant). Then from within a terminal, run:

```bash
vagrant up
```

> [!NOTE]
> This command will take a while the first time it runs. Go for coffee or otherwise do something else for a while! It will not take nearly as long once it is setup for the first time.

If anything fails to provision on the first run, it might be a temporary issue (e.g., Internet failure). You can safely run this command as many times as it takes to complete successfully:

```bash
vagrant provision
```

Once `vagrant up` or `vagrant provision` completes, you can get a shell on the VM with:

```bash
vagrant ssh
```

To setup the application, within a `vagrant ssh` session, run:

```bash
bin/setup
```

Once `bin/setup` completes, start the server by running:

```bash
bin/dev
```

Once `bin/dev` is running, the application will be available at <http://localhost:3000>

To start a Rails console, within a new `vagrant ssh` session, run:

```bash
bin/rails console
```

All typical `rake`, `rails`, `bundle`, etc commands can run this way.

For example, to run the test suite:

```bash
bin/rails test
```

To power off the machine without destroying it, within a terminal run:

```bash
vagrant halt
```

To power it back up again, run:

```bash
vagrant up --provision
```

### Testing

See [Rails Guides: Testing Rails Applications](https://guides.rubyonrails.org/testing.html).

To run the test suite, connect to the Vagrant VM (`vagrant ssh`) and run:

```bash
bin/rails test
```

To run the system tests (`tests/system`) which use a headless Chrome web browser to mimic real user interactions, run:

```bash
bin/rails test:system
```

### Code Formatting

[Rubocop](https://github.com/rubocop/rubocop) and [Prettier](https://prettier.io/) are used to maintain a consistent code format.

Most formatting errors can be automatically corrected by the tools themselves.

To run Rubocop and Prettier _and_ autocorrect any issues if possible, connect to the Vagrant VM (`vagrant ssh`) and run:

```bash
bin/lint --autocorrect
```

### Data

To develop with a more realistic data set, you can import data or restore data from a production backup, or some combination of both.

#### Production Backup

Download a database backup from a recent email. It will be in the form `backup_*.dump`.

Copy the `.dump` file to the project directory, connect to the Vagrant VM (`vagrant ssh`) and run:

```bash
# Replace FILE= with the actual filename
bin/rake db:restore FILE=backup_CaribbeanDataEntry_2025-07-10.dump
```

#### Import/Seed

To import species lists from the seed files in [db/SupportData](./db/SupportData/), connect to the Vagrant VM (`vagrant ssh`) and run:

```bash
bin/rake import:all
```

## Deployment

[Capistrano](https://capistranorb.com/) is used to deploy the code to servers over SSH.

[Create an SSH key](https://cloud.google.com/compute/docs/connect/create-ssh-keys#windows-10-or-later) if you have not already done so.

Next, add the key to an agent running locally. Open a terminal (Git Bash on Windows) and run:

```bash
eval $(ssh-agent); ssh-add
```

Within this same terminal, login to the virtual machine:

```bash
vagrant ssh
```

Verify the key is available within the virtual machine:

```bash
# long, random public key should print
ssh-add -L
```

With the key available to be used by Capistrano, run:

```
bin/cap production deploy
```

You will be prompted for a branch name, which defaults to the current branch. If that is what you want to deploy, simply hit &lt;enter&gt;.

## Production Setup

### Virtual Machine

This repository builds and snapshots an Ubuntu-based virtual machine that is setup to host the application. It uses the same Ansible playbook as Vagrant (eliding some development tasks).

To build the virtual machine, install [Packer](https://www.packer.io).

Then from a terminal, run:

``` bash
packer build -force server
```

The VM will be snapshot into the `./server/output` directory. The VM will be left powered off in VirtualBox, but it can be powered back on for experimentation or use in development.
