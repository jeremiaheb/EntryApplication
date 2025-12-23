module GoogleCloudDetector
  # Returns true if the application is running on Google Cloud, or has the
  # FORCE_GOOGLE_CLOUD environment variable set to force the application to act
  # like it is running on Google Cloud
  def self.running_on_google_cloud?
    File.exist?("/etc/google_instance_id") || ENV.fetch("FORCE_GOOGLE_CLOUD", false)
  end
end
