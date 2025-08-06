case Rails.env
when "production"
  if ::File.exist?(Rails.root.join("public/ncrmp_data_entry/assets"))
    Rails.application.config.assets.prefix = "/ncrmp_data_entry/assets"
    Rails.application.config.relative_url_root = "/ncrmp_data_entry"
  else
    Rails.application.config.assets.prefix = "/caribbean_data_entry/assets"
    Rails.application.config.relative_url_root = "/caribbean_data_entry"
  end
end