set :stage, :vagrant
set :rails_env, "production"

server "127.0.0.1", user: "entryapplication"
set :repo_url, File.realpath(File.join(File.dirname(__FILE__), "..", ".."))
