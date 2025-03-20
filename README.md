# EntryApplication

**EntryApplication** is a Ruby on Rails application for collecting fish, benthic and coral demographic samples.

## Development Setup

### Vagrant

A [Vagrant](https://www.vagrantup.com) box is provided for local development. It runs the same Ansible provisioning as the production virtual machine, plus some additional commands that make it useful for development.

First, [install Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant). Then from a terminal, run:

``` bash
vagrant up
```

The first run will take some time because it starts with a basic Ubuntu Linux machine and builds all the required dependencies on top. Once this is finished, future runs will not take as long.

To get a shell on the machine, run:

``` bash
vagrant ssh
```

To start the Rails server, run:

``` bash
bin/dev
```

Once `bin/dev` is running, the application will be available at <http://localhost:3000>

To start a Rails console, within a new `vagrant ssh` session run:

``` bash
bin/rails console
```

All typical `rake`, `rails`, etc commands can be run this way.

For example, to run the test suite:

``` bash
bin/rails test
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
