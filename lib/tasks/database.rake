require "open3"

namespace :db do
  desc "Backup the database and email it to recipients"
  task backup: :environment do
    connection_config =  Rails.application.config.database_configuration[Rails.env]

    stdout_s, stderr_s, status = Open3.capture3(
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
    )

    if status.success?
      DatabaseBackupMailer.with(content: stdout_s).backup.deliver_now
    else
      DatabaseBackupMailer.with(stderr_s: stderr_s).backup_failed.deliver_now
    end
  end

  desc "Restore the database from a dump file"
  task restore: :environment do
    connection_config =  Rails.application.config.database_configuration[Rails.env]

    file = ENV.fetch("FILE", nil)
    unless file
      STDERR.puts "Please specify the database dump file to restore from"
      STDERR.puts
      STDERR.puts "Example: rake db:restore FILE=backup_CaribbeanDataEntry_2025-07-10.dump"
      exit 1
    end

    puts "You are about to delete all data in the '#{connection_config["database"]}' database and replace it with the data in '#{file}'."
    puts
    print "Do you want to continue? (y/n): "
    exit unless STDIN.gets.chomp.downcase == "y"


    stdout_s, stderr_s, status = Open3.capture3(
      { "PGPASSWORD" => connection_config["password"] },
      "pg_restore",
      "--clean",
      "--if-exists",
      "--no-owner",
      "--no-privileges",
      "--host=#{connection_config["host"]}",
      "--username=#{connection_config["username"]}",
      "--dbname=#{connection_config["database"]}",
      "--role=#{connection_config["username"]}",
      file,
    )

    if status.success?
      puts "Database restored successfully"
    else
      STDERR.puts "Database restore FAILED. The standard error output was:"
      STDERR.puts
      STDERR.puts stderr_s
      exit 1
    end
  end


  desc "Clear database tables and restart id for each at 1"
  task clear_tables: :environment do
    tablelist = ["samples", "benthic_covers", "coral_demographics", "boat_logs", "sample_animals", "diver_samples", "point_intercepts", "rugosity_measures", "invert_belts", "presence_belts", "demographic_corals", "rep_logs", "station_logs"]
    auto_val = 1

    puts "deleting records from Sample and its child tables"
    Sample.destroy_all
    puts "deleting records from BenthicCover and its child tables"
    BenthicCover.destroy_all
    puts "deleting records from CoralDemographic and its child tables"
    CoralDemographic.destroy_all
    puts "deleting records from BoatLog and its child tables"
    BoatLog.destroy_all

    tablelist.each do |table|
      puts "Resetting auto increment for #{table} to #{auto_val}"
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{auto_val}")
    end
  end
end
