set :stage, :production
set :assets_prefix, "caribbean_data_entry/assets"
server "155.206.222.145", user: "entryapplication", roles: %w[app db web]
