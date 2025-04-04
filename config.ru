# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

# The same app is mounted in multiple locations during the transition to a single unified app.
%w{/rvc_data_entry /caribbean_data_entry /ncrmp_data_entry}.each do |path|
  map path do
    run Rails.application
  end
end

map "/" do
  run Rails.application
end

Rails.application.load_server
