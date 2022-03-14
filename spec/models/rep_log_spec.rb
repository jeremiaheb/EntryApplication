require 'spec_helper'

describe RepLog do

  describe "field_id" do
    let!(:rep_log_1){FactoryGirl.create(:rep_log)}

    it "Should give correct field_id" do
      expect(rep_log_1.field_id).to eq("12342J")
    end
  end
end

