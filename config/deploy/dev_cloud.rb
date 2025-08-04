set :stage, :dev_cloud
set :rails_env, "production"

server "10.27.25.212", user: "entryapplication", roles: %w[app db web]
