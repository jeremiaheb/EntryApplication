class BenthicCoverPdf < Prawn::Document
  
  def initialize(benthic_covers)
      super(margin: 2)
    benthic_covers.each do |benthic_cover|
      @benthic_cover = benthic_cover
      sample_head
      start_new_page
    end
  end
  
  def sample_head
    data =  [ ["Boatlog/Manger:", "#{@benthic_cover.boatlog_manager.agency_name}", "Diver", "#{@benthic_cover.diver.diver_name}"]
          ]
    table data, :cell_style => { :size => 8, :border_width => 0, :height => 17, :padding => 5 }

  end



end

