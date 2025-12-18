# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "EntryApplication"
set :repo_url, "git@github.com:jeremiaheb/EntryApplication.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/apps/EntryApplication"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "storage", ".bundle", "node_modules", "public/data", "backups"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :assets_prefix, "ncrmp_data_entry/assets"

# Forward agent for git over SSH
set :ssh_options, forward_agent: true

# rbenv settings
set :rbenv_type, :user

# Public assets must be readable by Apache
SSHKit.config.umask = "0002"

namespace :deploy do
  namespace :check do
    before :linked_files, :upload_encryption_keys do
      on roles(:web) do
        unless test("test -f #{shared_path}/config/master.key")
          upload! "config/master.key", "#{shared_path}/config/master.key"
        end
      end
    end
  end

  namespace :yarn do
    desc "Install JavaScript packages"
    task :install do
      on roles(:web) do
        with path: "$PATH:$HOME/.nvm" do
          within release_path do
            execute "nvm-exec", "yarn", "install", "--production", "--frozen-lockfile"
          end
        end
      end
    end
  end
  before "deploy:assets:precompile", "deploy:yarn:install"

  desc "Restart the application via its systemd service"
  task :restart do
    on roles(:web), in: :sequence do
      execute "sudo", "systemctl", "restart", "entryapplication.service"
    end
  end
  after "deploy:finishing", "deploy:restart"
end
