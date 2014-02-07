require 'spec_helper'

describe BoatLog do

  describe "boatlog_divers" do
    let!(:boat_log){FactoryGirl.create(:boat_log, :station_logs => [station_log_1, station_log_2] )}
      let!(:station_log_1){FactoryGirl.create(:station_log, :stn_number => 1, :rep_logs => [rep_log_1, rep_log_2, rep_log_3])}
        let!(:rep_log_1){FactoryGirl.create(:rep_log, :replicate => "A")}
        let!(:rep_log_2){FactoryGirl.create(:rep_log, :replicate => "B")}
        let!(:rep_log_3){FactoryGirl.create(:rep_log, :replicate => "J")}
      let!(:station_log_2){FactoryGirl.create(:station_log, :stn_number => 2, :rep_logs => [rep_log_4, rep_log_5])}
        let!(:rep_log_4){FactoryGirl.create(:rep_log, :replicate => "A")}
        let!(:rep_log_5){FactoryGirl.create(:rep_log, :replicate => "B")}

    it "Should give all divers in boatlog" do
      #binding.pry
      expect(boat_log.boatlog_divers).to eq([ [rep_log_1.field_id, rep_log_1.diver.diver_name],
                                              [rep_log_2.field_id, rep_log_2.diver.diver_name],
                                              [rep_log_3.field_id, rep_log_3.diver.diver_name],
                                              [rep_log_4.field_id, rep_log_4.diver.diver_name],
                                              [rep_log_5.field_id, rep_log_5.diver.diver_name] ])
    end
  end
  


end

