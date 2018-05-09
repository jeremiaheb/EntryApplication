# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

puts "Seeding database with data"

#SampleType.delete_all
#SampleType.connection.execute( 'ALTER SEQUENCE sample_types_id_seq RESTART WITH 1' )
#open("#{Rails.root}/db/SupportData/SampleTypeList.csv") do |sampleTypes|
  #sampleTypes.read.each_line do|sampleType|
    #SampleTypeName, SampleTypeDesc = sampleType.chomp.split(",")
    #SampleType.create( :sample_type_name => SampleTypeName, :sample_type_description => SampleTypeDesc )
  #end
#end

#HabitatType.delete_all
#HabitatType.connection.execute( 'ALTER SEQUENCE habitat_types_id_seq RESTART WITH 1' )
#open("#{Rails.root}/db/SupportData/HabitatList.csv") do |habitatTypes|
  #habitatTypes.read.each_line do|habitatType|
    #HabName, HabDesc, HabReg = habitatType.chomp.split(",")
    #HabitatType.create( :habitat_name => HabName, :habitat_description => HabDesc, :region => HabReg )
  #end
#end

Diver.delete_all
Diver.connection.execute( 'ALTER SEQUENCE divers_id_seq RESTART WITH 1' )
open("#{Rails.root}/db/SupportData/ncrmp_diverlist_2018.csv") do |divers|
  divers.read.each_line do|diver|
    DiverNumber, DiverName, UserName, Email, Password, Active, Role = diver.chomp.split(",")
    Diver.create( :diver_number => DiverNumber, :diver_name => DiverName, :username => UserName, :email => Email, :password => Password, :active => Active, :role => Role )
    puts "successfully created #{DiverName}"
  end
end

#Animal.delete_all
#Animal.connection.execute( 'ALTER SEQUENCE animals_id_seq RESTART WITH 1' )
#open("#{Rails.root}/db/SupportData/FishSpecies_April2016.csv") do |animals|
  #animals.read.each_line do |animal|
    #SppCode, ScientificName, CommonName, MinSize, MaxSize, MaxNumber = animal.chomp.split(",")
    #Animal.create( :species_code => SppCode, :scientific_name => ScientificName, :common_name => CommonName, :min_size => MinSize, :max_size => MaxSize, :max_number => MaxNumber )
  #end
#end

#Coral.delete_all
#Coral.connection.execute( 'ALTER SEQUENCE corals_id_seq RESTART WITH 1' )
#open("#{Rails.root}/db/SupportData/CoralSpecies_April2016.csv") do |corals|
  #corals.read.each_line do |coral|
    #Code, ScientificName, CommonName, Category = coral.chomp.split(",")
    #Coral.create( :scientific_name => ScientificName, :code => Code)
  #end
#end


#CoverCat.delete_all
#CoverCat.connection.execute( 'ALTER SEQUENCE cover_cats_id_seq RESTART WITH 1' )
#open("#{Rails.root}/db/SupportData/LPISpeciesList_April2016.csv") do |corals|
  #corals.read.each_line do |coral|
    #Code, ScientificName, CommonName = coral.chomp.split(",")
    #CoverCat.create( :name => ScientificName, :code => Code, :common => CommonName)
  #end
#end


#open("#{Rails.root}/db/SupportData/BioGeoDivers.csv") do |divers|
  #divers.read.each_line do|diver|
    #DiverNumber, DiverName, UserName, Email, Password, Active, Role = diver.chomp.split(",")
    #Diver.create( :diver_number => DiverNumber, :diver_name => DiverName, :username => UserName, :email => Email, :password => Password, :active => Active, :role => Role )
    #puts "successfully created #{DiverName}"
  #end
#end
