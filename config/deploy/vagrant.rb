set :stage, :vagrant
set :rails_env, "production"

server "127.0.0.1", user: "entryapplication", port: "2222"
