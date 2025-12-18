class DatabaseDumper
  BackupFailed = Class.new(StandardError)

  # Sends a backup via email via ActionMailer
  class ActionMailerDestination
    def initialize(mailer_klass, action)
      @mailer_klass = mailer_klass
      @action = action
    end

    def dump(io, identifier:)
      @mailer_klass.to_s.safe_constantize.with(io: io, identifier: identifier).send(@action).deliver_now
    end
  end

  # Save a backup to a local directory
  class LocalDirectoryDestination
    def initialize(directory)
      @directory = directory
    end

    def dump(io, identifier:)
      FileUtils.mkdir_p(@directory)
      File.open(File.join(@directory, "backup_#{identifier}.dump"), "w") do |backup_file|
        IO.copy_stream(io, backup_file)
      end
    end
  end

  # Save a backup to a Google Cloud bucket
  class GoogleCloudStorageBucketDestination
    def initialize(bucket, prefix)
      @bucket = bucket
      @prefix = prefix
    end

    def dump(io, identifier:)
      @bucket.upload_file(io, File.join(@prefix, "backup_#{identifier}.dump"))
    end
  end

  def dump_to_destinations(destinations = Rails.application.config.x.database_dumper_destinations)
    Tempfile.open("database_backup") do |io|
      dump_to_io(io)

      identifier = "#{Time.now.strftime("%Y%m%d%H%M%S")}_#{SecureRandom.hex(4)}"
      destinations.each do |destination|
        io.rewind

        Rails.error.handle do
          destination.dump(io, identifier: identifier)
        end
      end
    end
  end

  def dump_to_io(io)
    connection_config =  Rails.application.config.database_configuration[Rails.env]

    stderr_s = nil
    exit_status = nil
    Open3.popen3(
      { "PGPASSWORD" => connection_config["password"] },
      "pg_dump",
      "--clean",
      "--if-exists",
      "--encoding=#{connection_config["encoding"]}",
      "--host=#{connection_config["host"]}",
      "--username=#{connection_config["username"]}",
      "--dbname=#{connection_config["database"]}",
      "--format=custom",
      "--compress=9",
    ) do |stdin, stdout, stderr, wait_thr|
      stdin.close

      stdout_thread = Thread.new { IO.copy_stream(stdout, io) }
      stderr_thread = Thread.new { stderr_s = stderr.read }

      stdout_thread.join
      stderr_thread.join

      exit_status = wait_thr.value
    end

    raise BackupFailed, "Backup failed: #{stderr_s}" unless exit_status.success?
  end
end
