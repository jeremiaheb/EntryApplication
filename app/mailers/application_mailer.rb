require "google_cloud_detector"

class ApplicationMailer < ActionMailer::Base
  if GoogleCloudDetector.running_on_google_cloud?
    default from: "NCRMP Data Entry <ncrmpdataentry@googleusercontent.com>"
  else
    default from: "NCRMP Data Entry <jeremiah.blondeau+entryapplication@noaa.gov>"
  end

  layout "mailer"
end
