set :stage, :production
server "155.206.222.145", user: "entryapplication", roles: %w[app db web]
server "155.206.222.147", user: "entryapplication", roles: %w[app db web], new_assets_prefix: "ncrmp_data_entry/assets"
