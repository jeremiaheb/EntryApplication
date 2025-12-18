case Rails.env
when "development", "test"
  Rails.application.config.action_mailer.default_url_options = { host: "entryapplication.example" }
  Rails.application.config.action_mailer.perform_deliveries = false
  Rails.application.config.action_mailer.raise_delivery_errors = false
when "production"
  Rails.application.config.action_mailer.default_url_options = { host: "entryapplication.example" }
  Rails.application.config.action_mailer.delivery_method = :sendmail
  Rails.application.config.action_mailer.perform_deliveries = true
  Rails.application.config.action_mailer.raise_delivery_errors = true
end
