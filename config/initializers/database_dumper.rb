require "database_dumper"

Rails.application.config.x.database_dumper_destinations = [
  DatabaseDumper::LocalDirectoryDestination.new(Rails.root.join("backups")),
  DatabaseDumper::ActionMailerDestination.new(:DatabaseBackupMailer, :backup),
]

# If configured, add Google Cloud as a destination
Rails.error.handle do
  if File.exist?("/etc/google_instance_id") || ENV.fetch("FORCE_GOOGLE_CLOUD", false)
    bucket = Google::Cloud::Storage.new(project_id: "ggn-nmfs-sencrmp-prod-1").bucket("ncrmp-bucket-storage")
    Rails.application.config.x.database_dumper_destinations << DatabaseDumper::GoogleCloudStorageBucketDestination.new(bucket, "entryapplication/backups")
  end
end
