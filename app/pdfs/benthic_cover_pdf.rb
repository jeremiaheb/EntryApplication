class BenthicCoverPdf < Prawn::Document
  
  def initialize(benthic_covers)
      super(margin: 2)
    benthic_covers.each do |benthic_cover|
      @benthic_cover = benthic_cover
      sample_head
      blank5
      depth_and_rugosity
      topography
      benthic_fauna
      esa_corals
      notes
      species_data_27
      start_new_page
    end
  end

  def blank5
    data = [[""]]
    table data,
      :cell_style => {:height => 5, :border_width => 0},
      :column_widths => { 0 => 100 }
  end
  
  def sample_head
    data =  [ [ "Diver", "#{@benthic_cover.diver.diver_name}", "Boatlog/Manger:", "#{@benthic_cover.boatlog_manager.agency_name}"],
              [ "Buddy", "#{Diver.find(@benthic_cover.buddy).diver_name}", "Field ID", "#{@benthic_cover.field_id}", "Date", "#{@benthic_cover.sample_date}","Sample Time", "#{@benthic_cover.sample_begin_time.strftime("%H:%M")}" ],
              [ "Habitat", "#{@benthic_cover.habitat_type.habitat_name}", "Meters Completed", "#{@benthic_cover.meters_completed}" ]
          ]
    table data, :cell_style => { :size => 8, :border_width => 0, :height => 17, :padding => 5 }

  end

  def depth_and_rugosity
   data = [ [ {content: "Depth and Rugosity", align: :center, colspan: 2}],
            [ {content: "Min Depth:", border_right_width: 0}, {content: "#{@benthic_cover.rugosity_measure.min_depth}", border_left_width: 0} ],
            [ {content: "Max Depth:", border_right_width: 0}, {content: "#{@benthic_cover.rugosity_measure.max_depth}", border_left_width: 0} ],
            [ {content: "Max vert. height:", border_right_width: 0}, {content: "#{@benthic_cover.rugosity_measure.max_vert_height}", border_left_width: 0} ]
          ]

   table data,
     :cell_style => { :size => 8, :height => 17, :padding => 2  },
     :column_widths => { 0 => 50, 1 => 50 }
  end
  
  def topography
    move_up 68
    indent(105) do  
      data = [ [ {content: "Topography", align: :center, colspan: 2}],
        [ {content: "0-19:", border_right_width: 0}, {content: "#{@benthic_cover.rugosity_measure.cnt_less_than_20}", border_left_width: 0} ],
        [ {content: "20-49:", border_right_width: 0}, {content: "#{@benthic_cover.rugosity_measure.cnt_20_less_than_50}", border_left_width: 0} ],
        [ {content: "50-99:", border_right_width: 0}, {content: "#{@benthic_cover.rugosity_measure.cnt_50_less_than_100}", border_left_width: 0} ],
        [ {content: "100-149:", border_right_width: 0}, {content: "#{@benthic_cover.rugosity_measure.cnt_100_less_than_150}", border_left_width: 0} ],
        [ {content: "150-199:", border_right_width: 0}, {content: "#{@benthic_cover.rugosity_measure.cnt_150_less_than_200}", border_left_width: 0} ],
        [ {content: ">200:", border_right_width: 0}, {content: "#{@benthic_cover.rugosity_measure.cnt_greater_than_200}", border_left_width: 0} ]
      ]

      table data,
        :cell_style => { :size => 8, :height => 17, :padding => 2  },
        :column_widths => { 0 => 35, 1 => 35 }

    end
  end

  def benthic_fauna
    move_up 119
    indent(180) do  
      data = [ [ {content: "Benthic Fauna", align: :center, colspan: 2}],
        [ {content: "P. argus:", border_right_width: 0}, {content: "#{@benthic_cover.invert_belt.lobster_num}", border_left_width: 0} ],
        [ {content: "S. gigas:", border_right_width: 0}, {content: "#{@benthic_cover.invert_belt.conch_num}", border_left_width: 0} ],
        [ {content: "D. antillarum:", border_right_width: 0}, {content: "#{@benthic_cover.invert_belt.diadema_num}", border_left_width: 0} ]
      ]

      table data,
        :cell_style => { :size => 8, :height => 17, :padding => 2  },
        :column_widths => { 0 => 50, 1 => 50 }    
    end
  end

  def esa_corals
    move_up 68
    indent(285) do  
      data = [ [ {content: "ESA Corals", align: :center, colspan: 2}],
        [ {content: "A. cervicornis:", border_right_width: 0}, {content: "#{@benthic_cover.presence_belt.a_cervicornis}", border_left_width: 0} ],
        [ {content: "A. palmata:", border_right_width: 0}, {content: "#{@benthic_cover.presence_belt.a_palmata}", border_left_width: 0} ],
        [ {content: "D. cylindrus:", border_right_width: 0}, {content: "#{@benthic_cover.presence_belt.d_cylindrus}", border_left_width: 0} ],
        [ {content: "O. annularis:", border_right_width: 0}, {content: "#{@benthic_cover.presence_belt.m_annularis}", border_left_width: 0} ],
        [ {content: "O.faveolata:", border_right_width: 0}, {content: "#{@benthic_cover.presence_belt.m_faveolata}", border_left_width: 0} ],
        [ {content: "O. franksi:", border_right_width: 0}, {content: "#{@benthic_cover.presence_belt.m_franksi}", border_left_width: 0} ],
        [ {content: "M. ferox:", border_right_width: 0}, {content: "#{@benthic_cover.presence_belt.m_ferox}", border_left_width: 0} ]
      ]

      table data,
        :cell_style => { :size => 8, :height => 17, :padding => 2  },
        :column_widths => { 0 => 60, 1 => 60 }

    end
  end
  
  def notes
    move_up 136
    indent(410) do  
      data = [
              [ {content: "#{@benthic_cover.sample_description}"} ]
            ]

      table data,
        :cell_style => { :size => 8, :height => 145, :padding => 2  },
        :column_widths => { 0 => 100}

    end
  end

 def species_data_27
   table spp_1_27, 
    :cell_style => { :size => 8, :height => 17, :align => :center, :padding => 2 },
    :column_widths => { 0 => 100, 1 => 100, 2 => 100, 3 => 100}
 end

 def spp_1_27
  [["Category", "Hard Num", "Soft Num", "Rubble Num"]] + 
  @benthic_cover.point_intercepts.map.with_index do |spp, index|
    [spp.cover_cat.name , spp.hardbottom_num, spp.softbottom_num, spp.rubble_num]
  end
 end

end

