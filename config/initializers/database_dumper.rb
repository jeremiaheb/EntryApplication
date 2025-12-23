require "database_dumper"
require "google_cloud_detector"

Rails.application.config.x.database_dumper_destinations = [
  DatabaseDumper::LocalDirectoryDestination.new(Rails.root.join("backups")),
  DatabaseDumper::ActionMailerDestination.new(:DatabaseBackupMailer, :backup),
]

# If configured, add Google Cloud as a destination
Rails.error.handle do
  if GoogleCloudDetector.running_on_google_cloud?
    bucket = Google::Cloud::Storage.new(project_id: "ggn-nmfs-sencrmp-prod-1").bucket("ncrmp-bucket-storage")
    Rails.application.config.x.database_dumper_destinations << DatabaseDumper::GoogleCloudStorageBucketDestination.new(bucket, "entryapplication/backups")
  end
end
