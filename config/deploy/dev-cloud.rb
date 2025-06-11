set :stage, :"dev-cloud"
set :rails_env, "production"

server "10.27.25.212", user: "entryapplication", roles: %w[web db]