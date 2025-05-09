set :stage, :next
set :branch, ENV.fetch("BRANCH", "next")
set :rails_env, "production"

server "155.206.222.147", user: "entryapplication", roles: %w[web db]