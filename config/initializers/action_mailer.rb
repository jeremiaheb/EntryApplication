require "google_cloud_detector"

case Rails.env
when "development", "test"
  Rails.application.config.action_mailer.default_url_options = { host: "entryapplication.example" }
  Rails.application.config.action_mailer.perform_deliveries = false
  Rails.application.config.action_mailer.raise_delivery_errors = false
when "production"
  if GoogleCloudDetector.running_on_google_cloud?
    Rails.application.config.action_mailer.default_url_options = {
      host: "ncrmp-data-entry.fisheries.noaa.gov",
      script_name: "/ncrmp_data_entry",
    }
  else
    Rails.application.config.action_mailer.default_url_options = {
      host: "grunt.sefsc.noaa.gov",
      script_name: "/caribbean_data_entry",
    }
  end

  Rails.application.config.action_mailer.delivery_method = :sendmail
  Rails.application.config.action_mailer.perform_deliveries = true
  Rails.application.config.action_mailer.raise_delivery_errors = true
end
