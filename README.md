# EntryApplication

**EntryApplication** is a Ruby on Rails application for collecting fish, benthic and coral demographic samples.

## Development Setup

### Vagrant

A [Vagrant](https://www.vagrantup.com) box is provided for local development. It runs the same Ansible provisioning as the production virtual machine, plus some additional commands that make it useful for development.

First, [install Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant). Then from within a terminal, run:

``` bash
vagrant up
```

> [!NOTE]
> This command will take a while the first time it runs. Go for coffee or otherwise do something else for a while! It will not take nearly as long once it is setup for the first time.

To get a shell on the machine, run:

``` bash
vagrant ssh
```

To start the Rails server, within a `vagrant ssh` session run:

``` bash
bin/dev
```

Once `bin/dev` is running, the application will be available at <http://localhost:3000>

To start a Rails console, within a new `vagrant ssh` session run:

``` bash
bin/rails console
```

All typical `rake`, `rails`, `bundle`, etc commands can run this way.

For example, to run the test suite:

``` bash
bin/rails test
```

To power off the machine without destroying it, within a terminal run:

``` bash
vagrant halt
```

To power it back up again, run:

``` bash
vagrant up
```

### Local

If you prefer to setup Ruby on Rails applications fully locally, you can do so by installing Ruby and PostgreSQL locally.

``` bash
# Install dependencies
bin/setup

# Run server
bin/dev
```

Once `bin/dev` is running, the application will be available at <http://localhost:3000>
