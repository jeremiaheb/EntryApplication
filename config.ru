# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
#run EntryApplication::Application
if Rails.env.production?
  map '/RVC_Data_Entry' do
    run EntryApplication::Application
  end
else
  run EntryApplication::Application
end
