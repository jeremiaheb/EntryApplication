class CoralDemographicPdf < Prawn::Document
  
  def initialize(coral_demographics)
      super(margin: 2)
    coral_demographics.each do |coral_demographic|
      @coral_demographic = coral_demographic
      sample_head
      start_new_page
    end
  end
  
  def sample_head
    data =  [ ["Diver", "#{@coral_demographic.diver.diver_name}", "Boatlog/Manger:", "#{@coral_demographic.boatlog_manager.agency_name}" ]
          ]
    table data, :cell_style => { :size => 8, :border_width => 0, :height => 17, :padding => 5 }

  end



end

