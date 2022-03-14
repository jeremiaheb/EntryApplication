class CoralDemographicPdf < Prawn::Document
  
  def initialize(coral_demographics)
      super(margin: 2)
    coral_demographics.each do |coral_demographic|
      @coral_demographic = coral_demographic
      sample_head
      notes
      species_data_30
      if @coral_demographic.demographic_corals.length > 30
        species_data_60
      end
      if @coral_demographic.demographic_corals.length > 60
        start_new_page
        sample_head
        species_data_90
      end
      if @coral_demographic.demographic_corals.length > 90
        species_data_120
      end
      start_new_page
    end
  end
  
  def sample_head
    data =  [ [ "Diver", "#{@coral_demographic.diver.diver_name}", "Boatlog/Manger:", "#{@coral_demographic.boatlog_manager.agency_name}"],
              [ "Buddy", "#{Diver.find(@coral_demographic.buddy).diver_name}", "Field ID", "#{@coral_demographic.field_id}", "Date", "#{@coral_demographic.sample_date}","Sample Time", "#{@coral_demographic.sample_begin_time.strftime("%H:%M")}" ],
              [ "Habitat", "#{@coral_demographic.habitat_type.habitat_name}", "Meters Completed", "#{@coral_demographic.meters_completed}", "Percent Hardbottom", "#{@coral_demographic.percent_hardbottom}"]
          ]
    table data, :cell_style => { :size => 8, :border_width => 0, :height => 17, :padding => 5 }

  end
  
  def notes
    data =  [
              [ {content: "#{@coral_demographic.sample_description}"} ]
            ]

    table data,
      :cell_style => { :size => 8, :height => 30, :padding => 2  },
      :column_widths => { 0 => 500}

  end

 def species_data_30
   table spp_1_30, 
    :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
    :column_widths => { 0 => 10, 1 => 60, 2 => 100, 3 => 30, 4 => 30, 5 => 30, 6 => 30}
 end

 def spp_1_30
  [[ "M", "Species", "MD      PD      MH", "OM%", "RM%", "Blch", "Dis"]] + 
  @coral_demographic.demographic_corals[0..29].map.with_index do |spp, index|
    [spp.meter_mark, spp.coral.code , "%s  -  %s  -  %s" % [spp.try(:max_diameter), spp.try(:perpendicular_diameter), spp.try(:height)], spp.old_mortality, spp.recent_mortality, spp.bleach_condition, spp.disease]
  end
 end

 def species_data_60
   move_up 527
   indent(290) do
     table spp_31_60, 
       :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
       :column_widths => { 0 => 10, 1 => 60, 2 => 100, 3 => 30, 4 => 30, 5 => 30, 6 => 30}
   end
 end

 def spp_31_60
  [[ "M", "Species", "MD      PD      MH", "OM%", "RM%", "Blch", "Dis"]] + 
    @coral_demographic.demographic_corals[30..59].map.with_index do |spp, index|
    [spp.meter_mark, spp.coral.code , "%s  -  %s  -  %s" % [spp.try(:max_diameter), spp.try(:perpendicular_diameter), spp.try(:height)], spp.old_mortality, spp.recent_mortality, spp.bleach_condition, spp.disease]
  end
 end
 
 def species_data_90
   table spp_61_90, 
    :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
    :column_widths => { 0 => 10, 1 => 60, 2 => 100, 3 => 30, 4 => 30, 5 => 30, 6 => 30}
 end

 def spp_61_90
  [[ "M", "Species", "MD      PD      MH", "OM%", "RM%", "Blch", "Dis"]] + 
  @coral_demographic.demographic_corals[60..89].map.with_index do |spp, index|
    [spp.meter_mark, spp.coral.code , "%s  -  %s  -  %s" % [spp.try(:max_diameter), spp.try(:perpendicular_diameter), spp.try(:height)], spp.old_mortality, spp.recent_mortality, spp.bleach_condition, spp.disease]
  end
 end

 def species_data_120
   move_up 527
   indent(290) do
   table spp_91_120, 
    :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
    :column_widths => { 0 => 10, 1 => 60, 2 => 100, 3 => 30, 4 => 30, 5 => 30, 6 => 30}
  end
 end

 def spp_91_120
  [[ "M", "Species", "MD      PD      MH", "OM%", "RM%", "Blch", "Dis"]] + 
  @coral_demographic.demographic_corals[90..119].map.with_index do |spp, index|
    [spp.meter_mark, spp.coral.code , "%s  -  %s  -  %s" % [spp.try(:max_diameter), spp.try(:perpendicular_diameter), spp.try(:height)], spp.old_mortality, spp.recent_mortality, spp.bleach_condition, spp.disease]
  end
 end
end

