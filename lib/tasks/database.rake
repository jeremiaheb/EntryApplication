namespace :db do
  desc "Clear database tables and restart id for each at 1"
  task :clear_tables => :environment do
    
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
