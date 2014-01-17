class SamplePdf < Prawn::Document
  
  def initialize(samples)
      super(margin: 2)
    samples.each do |sample|
      @sample = sample
      sample_head
      abiotic_footprint
      comments
      species_data_36
      if @sample.sample_animals.length > 36
        species_data_72
      end
      start_new_page
    end
  end
  
  def sample_head
    data =  [ ["Boatlog/Manger:", "#{@sample.boatlog_manager.agency_name}"],
            ["Diver","#{@sample.diver_samples.primary[0].diver.diver_name}","Date","#{@sample.sample_date}","Field Number","#{@sample.field_id}","Visibility","#{@sample.underwater_visibility}"],
            ["Buddy","#{@sample.diver_samples.secondary[0].diver.diver_name}","Sample Start","#{@sample.sample_begin_time.strftime("%H:%M")}","Habitat","#{@sample.habitat_type.habitat_name}","Water Temp","#{@sample.water_temp}"],
            ["Dive Start",@sample.dive_begin_time.strftime("%H:%M"),"Sample End","#{@sample.sample_end_time.strftime("%H:%M")}","Fish Gear","#{@sample.fishing_gear}","Cylinder Radius","#{@sample.cylinder_radius}"],
            ["Dive End",@sample.dive_end_time.strftime("%H:%M"),"Max Depth","#{@sample.dive_depth}","Stn Depth","#{@sample.sample_depth}","Current","#{@sample.current}"]
          ]
    table data, :cell_style => { :size => 8, :border_width => 0, :height => 17, :padding => 5 }

  end

 def abiotic_footprint
   indent(0) do
    data = [ 
           [ {content: "Abiotic Footprint", align: :center, colspan: 2}],
           [ {content: "Sand"}, {content: "#{@sample.sand_percentage}"} ],
           [ {content: "Hard-B"}, {content: "#{@sample.hardbottom_percentage}"} ],
           [ {content: "Rubble"}, {content: "#{@sample.rubble_percentage}"} ]
    ]

    table data,
      :cell_style => { :size => 8, :height => 17, :padding => 2, :align => :center  },
      :column_widths => { 0 => 50, 1 => 50 }
   end
 end

 def comments
  move_up 68
  indent(100) do
    data =  [
              [{content: "Comments: " + "#{@sample.sample_description}", align: :left, colspan: 4 } ]
            ]

    table data,
     :cell_style => { :size => 8, :height => 68, :padding => 2 },
     :column_widths => { 0 => 85, 1 => 85, 2 => 85, 3 => 85}
  end
 end
 

 def species_data_36
   table spp_1_36, 
    :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
    :column_widths => { 0 => 15, 1 => 30, 2 => 129, 3 => 129}
 end
 
 def species_data_72
   move_up 629
   indent(304) do
   table spp_37_72, 
    :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
    :column_widths => { 0 => 15, 1 => 30, 2 => 129, 3 => 129}
 end
 end

 def spp_1_36
  [["", "Period", "Species", "N/Avg-Min-Max"]] + 
  @sample.sample_animals[0..35].map.with_index do |spp, index|
    [index + 1 , spp.time_seen, spp.animal.species_code, "%s / %s - %s - %s" % [spp.number_individuals, spp.try(:average_length), spp.try(:min_length), spp.try(:max_length)]]
  end
 end

 def spp_37_72
  [["", "Period", "Species", "N/Avg-Min-Max"]] + 
  @sample.sample_animals[36..@sample.sample_animals.length].map.with_index do |spp, index|
    [index + 37 , spp.time_seen, spp.animal.species_code, "%s / %s - %s - %s" % [spp.number_individuals, spp.try(:average_length), spp.try(:min_length), spp.try(:max_length)] ]
  end 
 end


end
