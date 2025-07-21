case Rails.env
when "production"
  Rails.application.config.assets.prefix = "/caribbean_data_entry/assets"
  Rails.application.config.relative_url_root = "/caribbean_data_entry"
end
