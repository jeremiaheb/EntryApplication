require "google_cloud_detector"

Rails.application.config.solid_errors.send_emails = Rails.env.production?
if GoogleCloudDetector.running_on_google_cloud?
  Rails.application.config.solid_errors.email_from = "ncrmpdataentry@googleusercontent.com"
else
  Rails.application.config.solid_errors.email_from = "jeremiah.blondeau+entryapplication@noaa.gov"
end
Rails.application.config.solid_errors.email_to = "andy.lindeman@noaa.gov, jeremiah.blondeau@noaa.gov"
Rails.application.config.solid_errors.destroy_after = 90.days
