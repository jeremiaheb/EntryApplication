set :stage, :production_cloud
set :rails_env, "production"

# Proxy through Google Cloud IAP
# https://cloud.google.com/iap/docs/using-tcp-forwarding
set :ssh_options, {
  proxy: Net::SSH::Proxy::Command.new(File.join(__dir__, "..", "..", "server", "gcloud-iap-tunnel") + " %h %p"),
}

server "sefsc-ncrmp-web-prod.us-east4-a.ggn-nmfs-sencrmp-prod-1", user: "entryapplication", roles: %w[app db web]
