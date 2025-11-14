# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Regions
puerto_rico = Region.find_or_create_by!(name: "Puerto Rico")
dry_tortugas = Region.find_or_create_by!(name: "Dry Tortugas")
florida_keys = Region.find_or_create_by!(name: "Florida Keys")
southeast_florida = Region.find_or_create_by!(name: "Southeast Florida")
st_thomas_and_st_john = Region.find_or_create_by!(name: "St. Thomas and St. John")
st_croix = Region.find_or_create_by!(name: "St. Croix")
flower_garden_banks = Region.find_or_create_by!(name: "Flower Garden Banks")

# Agencies
noaa = Agency.find_or_create_by!(name: "NOAA")
hjr = Agency.find_or_create_by!(name: "HJR")
css = Agency.find_or_create_by!(name: "CSS")
sea_ventures = Agency.find_or_create_by!(name: "SeaVentures")
fwc_marathon = Agency.find_or_create_by!(name: "FWC Marathon")

# Projects
ncrmp = Project.find_or_create_by!(name: "NCRMP")
makai = Project.find_or_create_by!(name: "Makai")

# Missions
Mission.find_or_create_by!(agency: noaa, region: st_thomas_and_st_john, project: ncrmp)
Mission.find_or_create_by!(agency: noaa, region: st_croix, project: ncrmp)
Mission.find_or_create_by!(agency: noaa, region: dry_tortugas, project: makai)
Mission.find_or_create_by!(agency: noaa, region: florida_keys, project: makai)
Mission.find_or_create_by!(agency: noaa, region: florida_keys, project: ncrmp)
Mission.find_or_create_by!(agency: fwc_marathon, region: florida_keys, project: ncrmp)
Mission.find_or_create_by!(agency: hjr, region: puerto_rico, project: ncrmp)
Mission.find_or_create_by!(agency: css, region: puerto_rico, project: ncrmp)
Mission.find_or_create_by!(agency: sea_ventures, region: puerto_rico, project: ncrmp)

# Habitat Types
HabitatType.find_or_initialize_by(habitat_name: "Sand").
  update!(habitat_description: "Sand only", region: "Atlantic", regions: [dry_tortugas, florida_keys, southeast_florida])
HabitatType.find_or_initialize_by(habitat_name: "Contiguous reef Spur-Groove").
  update!(habitat_description: "Contiguous reef with distinct spur-groove formation", region: "Atlantic", regions: [dry_tortugas, florida_keys, southeast_florida])
HabitatType.find_or_initialize_by(habitat_name: "Contiguous reef Other").
  update!(habitat_description: "Contiguous reef with no distinct formation", region: "Atlantic", regions: [dry_tortugas, florida_keys, southeast_florida])
HabitatType.find_or_initialize_by(habitat_name: "Isolated reef structure(s)").
  update!(habitat_description: "E.g  patch reefs  rocky outcrops pinnacle", region: "Atlantic", regions: [dry_tortugas, florida_keys, southeast_florida])
HabitatType.find_or_initialize_by(habitat_name: "Reef Rubble").
  update!(habitat_description: "Mostly unconsolidated or consolidated reef fragments", region: "Atlantic", regions: [dry_tortugas, florida_keys, southeast_florida])
HabitatType.find_or_initialize_by(habitat_name: "Sand-Seagrass-HB matrix").
  update!(habitat_description: "Mostly softbottom non-reef habitat", region: "Atlantic", regions: [dry_tortugas, florida_keys, southeast_florida])
HabitatType.find_or_initialize_by(habitat_name: "Artificial reef").
  update!(habitat_description: "E.g. wrecks etc.", region: "Atlantic", regions: [dry_tortugas, florida_keys, southeast_florida])
HabitatType.find_or_initialize_by(habitat_name: "Bedrock").
  update!(habitat_description: "Bedrock", region: "Caribbean", regions: [puerto_rico, st_thomas_and_st_john, st_croix])
HabitatType.find_or_initialize_by(habitat_name: "Aggregate Reef").
  update!(habitat_description: "Aggregate Reef", region: "Caribbean", regions: [puerto_rico, st_thomas_and_st_john, st_croix])
HabitatType.find_or_initialize_by(habitat_name: "Pavement").
  update!(habitat_description: "Pavement", region: "Caribbean", regions: [puerto_rico, st_thomas_and_st_john, st_croix])
HabitatType.find_or_initialize_by(habitat_name: "Patch Reef").
  update!(habitat_description: "Patch Reef", region: "Caribbean", regions: [puerto_rico, st_thomas_and_st_john, st_croix])
HabitatType.find_or_initialize_by(habitat_name: "Scattered coral/rock in sand").
  update!(habitat_description: "Scattered coral/rock in sand", region: "Caribbean", regions: [puerto_rico, st_thomas_and_st_john, st_croix])
HabitatType.find_or_initialize_by(habitat_name: "High Relief").
  update!(habitat_description: "High Relief", region: "FlowerGardens", regions: [flower_garden_banks])
HabitatType.find_or_initialize_by(habitat_name: "Low Relief").
  update!(habitat_description: "Low Relief", region: "FlowerGardens", regions: [flower_garden_banks])
