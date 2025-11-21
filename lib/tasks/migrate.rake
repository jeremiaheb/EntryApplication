namespace :migrate do
  desc "Temporary task to migrate diver_samples table to diver_id and buddy_id fields on samples table. This task assumes diver_samples is correct and will overwrite any existing diver_id and buddy_id on the samples table."
  task diver_samples: :environment do
    DiverSample.includes(:sample).find_each do |ds|
      if ds.primary_diver?
        ds.sample.update(diver_id: ds.diver_id)
      else
        ds.sample.update(buddy_id: ds.diver_id)
      end
    end
  end

  desc "Temporary task to migrate boatlog_manager_id fields to mission_id."
  task mission_id: :environment do
    BoatlogManager.find_each do |boatlog_manager|
      mission = case boatlog_manager.agency_name
      when "NOAA/STX_NCRMP"
        Mission.find_by!(region: Region.find_by!(name: "St. Croix"), agency: Agency.find_by!(name: "NOAA"), project: Project.find_by!(name: "NCRMP"))
      when "NOAA/STTSTJ_NCRMP"
        Mission.find_by!(region: Region.find_by!(name: "St. Thomas and St. John"), agency: Agency.find_by!(name: "NOAA"), project: Project.find_by!(name: "NCRMP"))
      when "HJR/PRICO_NCRMP"
        Mission.find_by!(region: Region.find_by!(name: "Puerto Rico"), agency: Agency.find_by!(name: "HJR"), project: Project.find_by!(name: "NCRMP"))
      when "CSS/PRICO_NCRMP"
        Mission.find_by!(region: Region.find_by!(name: "Puerto Rico"), agency: Agency.find_by!(name: "CSS"), project: Project.find_by!(name: "NCRMP"))
      when "SeaVentures/PRICO_NCRMP"
        Mission.find_by!(region: Region.find_by!(name: "Puerto Rico"), agency: Agency.find_by!(name: "SeaVentures"), project: Project.find_by!(name: "NCRMP"))
      else
        raise "Unknown case: #{boatlog_manager.agency_name}. Please change the code in migrate.rake to find the correct mission for this boatlog manager."
      end

      BoatLog.where(boatlog_manager_id: boatlog_manager.id).update_all(mission_id: mission.id)
      Sample.where(boatlog_manager_id: boatlog_manager.id).update_all(mission_id: mission.id)
      BenthicCover.where(boatlog_manager_id: boatlog_manager.id).update_all(mission_id: mission.id)
      CoralDemographic.where(boatlog_manager_id: boatlog_manager.id).update_all(mission_id: mission.id)
    end
  end
end
