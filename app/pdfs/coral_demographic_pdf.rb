class CoralDemographicPdf < Prawn::Document
  
  def initialize(coral_demographics)
      super(margin: 2)
    coral_demographics.each do |coral_demographic|
      @coral_demographic = coral_demographic
      sample_head
      notes
      species_data_28
      if @coral_demographic.demographic_corals.length > 28
        species_data_56
      end
      start_new_page
    end
  end
  
  def sample_head
    data =  [ [ "Diver", "#{@coral_demographic.diver.diver_name}", "Boatlog/Manger:", "#{@coral_demographic.boatlog_manager.agency_name}"],
              [ "Buddy", "#{Diver.find(@coral_demographic.buddy).diver_name}", "Field ID", "#{@coral_demographic.field_id}", "Date", "#{@coral_demographic.sample_date}","Sample Time", "#{@coral_demographic.sample_begin_time.strftime("%H:%M")}" ],
              [ "Habitat", "#{@coral_demographic.habitat_type.habitat_name}", "Meters Completed", "#{@coral_demographic.meters_completed}" ]
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

 def species_data_28
   table spp_1_28, 
    :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
    :column_widths => { 0 => 60, 1 => 100, 2 => 30, 3 => 30, 4 => 30, 5 => 30}
 end

 def spp_1_28
  [["Species", "MD      PD      MH", "OM%", "RM%", "Blch", "Dis"]] + 
  @coral_demographic.demographic_corals[0..27].map.with_index do |spp, index|
    [spp.coral.code , "%s  -  %s  -  %s" % [spp.try(:max_diameter), spp.try(:perpendicular_diameter), spp.try(:height)], spp.old_mortality, spp.recent_mortality, spp.bleach_condition, spp.disease]
  end
 end

 def species_data_56
   move_up 493
   indent(280) do
     table spp_29_56, 
       :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
       :column_widths => { 0 => 60, 1 => 100, 2 => 30, 3 => 30, 4 => 30, 5 => 30}
   end
 end

 def spp_29_56
  [["Species", "MD      PD      MH", "OM%", "RM%", "Blch", "Dis"]] + 
  @coral_demographic.demographic_corals[28..@coral_demographic.demographic_corals.length].map.with_index do |spp, index|
    [spp.coral.code , "%s  -  %s  -  %s" % [spp.try(:max_diameter), spp.try(:perpendicular_diameter), spp.try(:height)], spp.old_mortality, spp.recent_mortality, spp.bleach_condition, spp.disease]
  end
 end

end

