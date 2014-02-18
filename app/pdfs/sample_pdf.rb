class SamplePdf < Prawn::Document
  
  def initialize(samples)
      super(margin: 2)
    samples.each do |sample|
      @sample = sample
      sample_head
      abiotic_footprint
      comments
      species_data_36
      if @sample.sample.sample_animals.length > 36
        species_data_72
      end
      start_new_page
    end
  end
  
  def sample_head
    data =  [ [],
            ["Diver","#{@sample.diver.diver_name}","Date","#{@sample.sample.sample_date}","Field Number","#{@sample.sample.field_id}","Boatlog/Manger:", "#{@sample.sample.boatlog_manager.agency_name}"],
            ["Buddy","#{@sample.sample.diver_samples.secondary[0].diver.diver_name}","Sample Start","#{@sample.sample.sample_begin_time.strftime("%H:%M")}","Habitat","#{@sample.sample.habitat_type.habitat_name}","Visibility","#{@sample.sample.underwater_visibility}"],
            ["Dive Start",@sample.sample.dive_begin_time.strftime("%H:%M"),"Sample End","#{@sample.sample.sample_end_time.strftime("%H:%M")}","Fish Gear","#{@sample.sample.fishing_gear}","Water Temp","#{@sample.sample.water_temp}"],
            ["Dive End",@sample.sample.dive_end_time.strftime("%H:%M"),"Max Depth","#{@sample.sample.dive_depth}","Stn Depth","#{@sample.sample.sample_depth}","Current","#{@sample.sample.current}"]
          ]
    table data, :cell_style => { :size => 8, :border_width => 0, :height => 17, :padding => 5 }

  end

 def abiotic_footprint
   indent(0) do
    data = [ 
           [ {content: "Abiotic Footprint", align: :center, colspan: 2}],
           [ {content: "Sand"}, {content: "#{@sample.sample.sand_percentage}"} ],
           [ {content: "Hard-B"}, {content: "#{@sample.sample.hardbottom_percentage}"} ],
           [ {content: "Rubble"}, {content: "#{@sample.sample.rubble_percentage}"} ]
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
              [{content: "Comments: " + "#{@sample.sample.sample_description}", align: :left, colspan: 4 } ]
            ]

    table data,
     :cell_style => { :size => 8, :height => 68, :padding => 2 },
     :column_widths => { 0 => 100, 1 => 100, 2 => 100, 3 => 100}
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
  @sample.sample.sample_animals[0..35].map.with_index do |spp, index|
    [index + 1 , spp.time_seen, spp.animal.species_code, "%s / %s - %s - %s" % [spp.number_individuals, spp.try(:average_length), spp.try(:min_length), spp.try(:max_length)]]
  end
 end

 def spp_37_72
  [["", "Period", "Species", "N/Avg-Min-Max"]] + 
  @sample.sample.sample_animals[36..@sample.sample.sample_animals.length].map.with_index do |spp, index|
    [index + 37 , spp.time_seen, spp.animal.species_code, "%s / %s - %s - %s" % [spp.number_individuals, spp.try(:average_length), spp.try(:min_length), spp.try(:max_length)] ]
  end 
 end


end
