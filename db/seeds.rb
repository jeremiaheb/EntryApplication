# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Habitat Types
HabitatType.find_or_initialize_by(habitat_name: "Sand").
  update!(habitat_description: "Sand only", region: "Atlantic")
HabitatType.find_or_initialize_by(habitat_name: "Contiguous reef Spur-Groove").
  update!(habitat_description: "Contiguous reef with distinct spur-groove formation", region: "Atlantic")
HabitatType.find_or_initialize_by(habitat_name: "Contiguous reef Other").
  update!(habitat_description: "Contiguous reef with no distinct formation", region: "Atlantic")
HabitatType.find_or_initialize_by(habitat_name: "Isolated reef structure(s)").
  update!(habitat_description: "E.g  patch reefs  rocky outcrops pinnacle", region: "Atlantic")
HabitatType.find_or_initialize_by(habitat_name: "Reef Rubble").
  update!(habitat_description: "Mostly unconsolidated or consolidated reef fragments", region: "Atlantic")
HabitatType.find_or_initialize_by(habitat_name: "Sand-Seagrass-HB matrix").
  update!(habitat_description: "Mostly softbottom non-reef habitat", region: "Atlantic")
HabitatType.find_or_initialize_by(habitat_name: "Artificial reef").
  update!(habitat_description: "E.g. wrecks etc.", region: "Atlantic")
HabitatType.find_or_initialize_by(habitat_name: "Bedrock").
  update!(habitat_description: "Bedrock", region: "Caribbean")
HabitatType.find_or_initialize_by(habitat_name: "Aggregate Reef").
  update!(habitat_description: "Aggregate Reef", region: "Caribbean")
HabitatType.find_or_initialize_by(habitat_name: "Pavement").
  update!(habitat_description: "Pavement", region: "Caribbean")
HabitatType.find_or_initialize_by(habitat_name: "Patch Reef").
  update!(habitat_description: "Patch Reef", region: "Caribbean")
HabitatType.find_or_initialize_by(habitat_name: "Scattered coral/rock in sand").
  update!(habitat_description: "Scattered coral/rock in sand", region: "Caribbean")
HabitatType.find_or_initialize_by(habitat_name: "High Relief").
  update!(habitat_description: "High Relief", region: "FlowerGardens")
HabitatType.find_or_initialize_by(habitat_name: "Low Relief").
  update!(habitat_description: "Low Relief", region: "FlowerGardens")