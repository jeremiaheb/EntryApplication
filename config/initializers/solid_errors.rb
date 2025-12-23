Rails.application.config.solid_errors.send_emails = Rails.env.production?
Rails.application.config.solid_errors.email_to = "andy.lindeman@noaa.gov, jeremiah.blondeau@noaa.gov"
Rails.application.config.solid_errors.destroy_after = 90.days
