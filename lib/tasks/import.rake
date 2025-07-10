require "csv"

namespace :import do
  # rake import:coral FILE=db/SupportData/CoralSpecies_July2025.csv
  task :coral => :environment do
    file = ENV.fetch("FILE", Rails.root.join("db/SupportData/CoralSpecies_July2025.csv"))
    CSV.foreach(file, headers: true) do |row|
      coral = Coral.find_or_initialize_by(code: row["Code"])

      coral.scientific_name = row["ScientificName"]
      coral.common_name = row["CommonName"]
      coral.short_code = row["Short Code"]
      coral.rank = row["Rank"]

      if coral.save
        STDOUT.puts "Imported coral '#{coral.code}'"
      else
        STDERR.puts "Saving coral '#{coral.code}' failed: #{coral.errors.full_messages.join(", ")}"
      end
    end
  end
end