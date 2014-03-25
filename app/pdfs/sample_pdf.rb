class SamplePdf < Prawn::Document
  
  def initialize(samples)
      super(margin: 2)
    samples.each do |sample|
      @sample = sample
      sample_head
      substrate_slope
      max_vert_relief
      surface_relief_perc
      blank1
      abiotic_footprint
      blank2
      comments
      biotic_cover
      species_data_27
      if @sample.sample.sample_animals.length > 27
        species_data_54
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

 def substrate_slope
   data = [ [{content: "Substrate Slope", align: :center, colspan: 2}], [ {content: "Max Depth:", border_right_width: 0}, {content: "#{@sample.sample.substrate_max_depth}", border_left_width: 0} ], [ {content: "Min Depth:", border_right_width: 0}, {content: "#{@sample.sample.substrate_min_depth}", border_left_width: 0} ] ]

   table data,
     :cell_style => { :size => 8, :height => 17, :padding => 2  },
     :column_widths => { 0 => 75, 1 => 75 }
 end

 def max_vert_relief
   data = [ [{content: "Max Vertical Relief", align: :center, colspan: 2}], [ {content: "Hard Relief:", border_right_width: 0}, {content: "#{@sample.sample.hard_verticle_relief}", border_left_width: 0} ], [ {content: "Soft Relief:", border_right_width: 0}, {content: "#{@sample.sample.soft_verticle_relief}", border_left_width: 0} ] ]

   table data,
     :cell_style => { :size => 8, :height => 17, :padding => 2 },
     :column_widths => { 0 => 75, 1 => 75 }
 end

 def surface_relief_perc
   data = [ 
          [ {content: "Surface Relief %", colspan: 3}],
          [ {content: "", }, {content: "Hard"}, {content: "Avg. Soft", align: :center} ],
          [ {content: "<0.2"}, {content: "#{@sample.sample.hard_relief_cat_0}"}, {content: "#{@sample.sample.soft_relief_cat_0}"} ],
          [ {content: "0.2-0.5"}, {content: "#{@sample.sample.hard_relief_cat_1}"}, {content: "#{@sample.sample.soft_relief_cat_1}"} ],
          [ {content: "0.5-1.0"}, {content: "#{@sample.sample.hard_relief_cat_2}"}, {content: "#{@sample.sample.soft_relief_cat_2}"} ],
          [ {content: "1.0-1.5"}, {content: "#{@sample.sample.hard_relief_cat_3}"}, {content: "#{@sample.sample.soft_relief_cat_3}"} ],
          [ {content: ">1.5"}, {content: "#{@sample.sample.hard_relief_cat_4}"}, {content: "#{@sample.sample.soft_relief_cat_4}"} ]
          ]

   table data,
     :cell_style => { :size => 8, :align => :center, :height => 17, :padding => 2 },
     :column_widths => { 0 => 50, 1 => 50, 2 => 50}
 end

 def blank1
   move_up 221
   indent(150) do
    data = [[""]]

    table data,
      :cell_style => {:height => 85},
      :column_widths => { 0 => 100 }
   end
 end

 def abiotic_footprint
   indent(150) do
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

 def blank2
   indent(150) do
    data = [[""]]

    table data,
      :cell_style => {:height => 68},
      :column_widths => { 0 => 100 }
   end
 end

 def comments
  move_up 221
  indent(250) do
    data =  [
              [{content: "Comments: " + "#{@sample.sample.sample_description}", align: :left, colspan: 4 } ]
            ]

    table data,
     :cell_style => { :size => 8, :height => 51, :padding => 2 },
     :column_widths => { 0 => 85, 1 => 85, 2 => 85, 3 => 85}
  end
 end
 
 def biotic_cover
  indent(250) do
    data =  [
              [{content: "Biotic Cover %", align: :center, colspan: 4 } ],
              [{content: "Sand", align: :center, colspan: 2 },{content: "Hardbottom", align: :center, colspan: 2 } ],
              [{content: "Bare", align: :center, colspan: 1 }, {content: "#{@sample.sample.sand_bare}", align: :center, colspan: 1 }, {content: "Algae(<1)", align: :center, colspan: 1 }, {content: "#{@sample.sample.hardbottom_algal_turf}", align: :center, colspan: 1 } ],
              [{content: "Macro Algae", align: :center, colspan: 1 }, {content: "#{@sample.sample.sand_macro_algae}", align: :center, colspan: 1 }, {content: "Algae(>1)", align: :center, colspan: 1 }, {content: "#{@sample.sample.hardbottom_macro_algae}", align: :center, colspan: 1 } ],
              [{content: "Seagrass", align: :center, colspan: 1 }, {content: "#{@sample.sample.sand_seagrass}", align: :center, colspan: 1 }, {content: "Live Coral", align: :center, colspan: 1 }, {content: "#{@sample.sample.hardbottom_live_coral}", align: :center, colspan: 1 } ],
              [{content: "Sponge", align: :center, colspan: 1 }, {content: "#{@sample.sample.sand_sponge}", align: :center, colspan: 1 }, {content: "Octocoral", align: :center, colspan: 1 }, {content: "#{@sample.sample.hardbottom_octocoral}", align: :center, colspan: 1 } ],
              [{content: "1:" + "#{@sample.sample.sand_pcov_other1_lab}", align: :left, colspan: 1 }, {content: "#{@sample.sample.sand_pcov_other1}", align: :center, colspan: 1 }, {content: "Sponge", align: :center, colspan: 1 }, {content: "#{@sample.sample.hardbottom_sponge}", align: :center, colspan: 1 } ],
              [{content: "2:" + "#{@sample.sample.sand_pcov_other2_lab}", align: :left, colspan: 1 }, {content: "#{@sample.sample.sand_pcov_other2}", align: :center, colspan: 1 }, {content: "1: " + "#{@sample.sample.hard_pcov_other1_lab}", align: :left, colspan: 1 }, {content: "#{@sample.sample.hard_pcov_other1}", align: :center, colspan: 1 } ],
              [{content: "", align: :center, colspan: 1 }, {content: "", align: :center, colspan: 1 }, {content: "2: " + "#{@sample.sample.hard_pcov_other2_lab}", align: :left, colspan: 1 }, {content: "#{@sample.sample.hard_pcov_other2}", align: :center, colspan: 1 } ],
              [{content: "", align: :center, colspan: 1 }, {content: "", align: :center, colspan: 1 }, {content: "", align: :center, colspan: 1 }, {content: "", align: :center, colspan: 1 } ],
            ]

    table data,
     :cell_style => { :size => 8, :height => 17, :padding => 2 },
     :column_widths => { 0 => 85, 1 => 85, 2 => 85, 3 => 85}
  end
 end

 def species_data_27
   table spp_1_27, 
    :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
    :column_widths => { 0 => 15, 1 => 30, 2 => 129, 3 => 129}
 end
 
 def species_data_54
   move_up 476
   indent(304) do
   table spp_28_54, 
    :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
    :column_widths => { 0 => 15, 1 => 30, 2 => 129, 3 => 129}
 end
 end

 def spp_1_27
  [["", "Period", "Species", "N/Avg-Min-Max"]] + 
  @sample.sample.sample_animals[0..26].map.with_index do |spp, index|
    [index + 1 , spp.time_seen, spp.animal.species_code, "%s / %s - %s - %s" % [spp.number_individuals, spp.try(:average_length), spp.try(:min_length), spp.try(:max_length)]]
  end
 end

 def spp_28_54
  [["", "Period", "Species", "N/Avg-Min-Max"]] + 
  @sample.sample.sample_animals[27..@sample.sample.sample_animals.length].map.with_index do |spp, index|
    [index + 28 , spp.time_seen, spp.animal.species_code, "%s / %s - %s - %s" % [spp.number_individuals, spp.try(:average_length), spp.try(:min_length), spp.try(:max_length)] ]
  end 
 end


end
