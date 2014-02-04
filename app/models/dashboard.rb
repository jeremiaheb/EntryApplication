class Dashboard
  def divers(current_diver)
    boatlog_managers = if current_diver.admin?
      BoatlogManager.all
    else
      [current_diver.boatlog_manager]
    end

    organized_hash = {}

    boatlog_managers.each do |boatlog_manager|
      boatlog_manager.divers_responsible_for.each do |diver|
        if !organized_hash.has_key?(diver)
          organized_hash[diver] = {
            "boat"   => 0,
            "sample" => 0,
            "lpi"    => 0,
            "demo"   => 0
          }
        end

        organized_hash[diver]["boat"] += boatlog_manager.boatlog_replicates_count_for_diver(diver)
        organized_hash[diver]["sample"] += boatlog_manager.samples_count_for_diver(diver)
        organized_hash[diver]["lpi"] += boatlog_manager.benthic_covers_count_for_diver(diver)
        organized_hash[diver]["demo"] += boatlog_manager.coral_demographics_count_for_diver(diver)
      end
    end
    organized_hash.sort_by { |diver, data| diver }
  end
end
