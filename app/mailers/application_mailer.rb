require "google_cloud_detector"

class ApplicationMailer < ActionMailer::Base
  if GoogleCloudDetector.running_on_google_cloud?
    default from: email_address_with_name("ncrmpdataentry@googleusercontent.com", "NCRMP Data Entry")
  else
    default from: email_address_with_name("jeremiah.blondeau+entryapplication@noaa.gov", "NCRMP Data Entry")
  end

  layout "mailer"
end
