lock "3.19.2"

set :application, "EntryApplication"
set :repo_url, "git@github.com:jeremiaheb/EntryApplication.git"
set :branch, ENV["BRANCH"] if ENV["BRANCH"]
set :deploy_to, "/var/www/apps/EntryApplication"
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle]
set :linked_files, %w[config/master.key config/credentials/production.key]

set :ssh_options, forward_agent: true

set :rbenv_type, :user

namespace :deploy do
  namespace :check do
    before :linked_files, :upload_encryption_keys do
      on roles(:web) do
        unless test("test -f #{shared_path}/config/master.key")
          upload! "config/master.key", "#{shared_path}/config/master.key"
        end

        unless test("test -f #{shared_path}/config/credentials/production.key")
          upload! "config/credentials/production.key", "#{shared_path}/config/credentials/production.key"
        end
      end
    end
  end

  desc "Restart the application via its systemd service"
  task :restart do
    on roles(:web), in: :sequence do
      execute "sudo", "systemctl", "restart", "entryapplication"
    end
  end

  desc "Reload (code reload only) the application via its systemd service"
  task :reload do
    on roles(:web), in: :sequence do
      # Must be on a single line; otherwise capistrano/sshkit will add
      # semicolons at the end of every newline 🤦🏻
      execute "systemctl is-active entryapplication >/dev/null 2>&1 && sudo systemctl reload entryapplication || sudo systemctl start entryapplication"
    end
  end
  after "deploy:finishing", "deploy:reload"
end
