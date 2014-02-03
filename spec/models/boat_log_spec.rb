require 'spec_helper'

describe BoatLog do

  describe "boatlog_divers" do
    let!(:rep_log){FactoryGirl.create(:rep_log)}
    let!(:station_log){FactoryGirl.create(:station_log, :rep_logs => [rep_log])}
    let!(:boat_log){FactoryGirl.create(:boat_log, :station_logs => [station_log] )}

    it "Should give all divers in boatlog" do
      expect(boat_log.boatlog_divers).to eq([[rep_log.field_id, rep_log.diver.diver_name]])
    end
  end
  


end

