set :stage, :next
set :branch, "next"
set :rails_env, "production"

server "199.242.232.174", user: "entryapplication", roles: %w[web db]