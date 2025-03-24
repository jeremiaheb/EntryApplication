lock "3.19.2"

set :application, "EntryApplication"
set :repo_url, "git@github.com:jeremiaheb/EntryApplication.git"
set :branch, ENV["BRANCH"] if ENV["BRANCH"]
set :deploy_to, "/var/www/apps/EntryApplication"
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle]
set :linked_files, %w[config/master.key config/credentials/production.key]

set :ssh_options, forward_agent: true

set :rbenv_type, :user
