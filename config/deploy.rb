require 'bundler/capistrano'
load 'deploy/assets'
set :application, "entryApplication"
set :repository,  "https://github.com/jeremiaheb/EntryApplication.git"

set :scm, :git
set :deploy_via, :remote_cache

set :use_sudo, false
set :user, 'jeremiaheb'
set :branch, :master
set :rails_env, :production
set :deploy_to, "/var/www/apps/#{application}"
role :web, "199.242.231.104"                          # Your HTTP server, Apache/etc
role :app, "199.242.231.104"                          # This may be the same as your `Web` server
role :db,  "199.242.231.104", :primary => true # This is where Rails migrations will run


default_run_options[:pty] = true
#ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
ssh_options[:forward_agent] = true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
