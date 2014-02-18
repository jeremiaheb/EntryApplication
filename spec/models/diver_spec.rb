require 'spec_helper'
require 'cancan/matchers'

describe Diver do
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }

    context 'when an admin' do
      let (:user) { FactoryGirl.create(:diver, role: Diver::ADMIN) }

      it { should be_able_to(:manage, :all) }
    end

    context 'when a manager' do
      let (:user) { FactoryGirl.create(:diver, role: Diver::MANAGER) }

      it { should be_able_to(:manage, Sample) }
      it { should be_able_to(:manage, CoralDemographic) }
      it { should be_able_to(:manage, BenthicCover) }
      it { should be_able_to(:manage, BoatLog) }
    end

    context 'when a diver' do
      let (:user)                     { FactoryGirl.create(:diver, role: Diver::DIVER) }
      let (:my_coral_demograhpic)     { FactoryGirl.create(:coral_demographic, diver_id: user.id) }
      let (:not_my_coral_demographic) { FactoryGirl.create(:coral_demographic) }

      it { should be_able_to(:create,      CoralDemographic) }
      it { should be_able_to(:read,        my_coral_demograhpic) }
      it { should be_able_to(:destroy,     CoralDemographic) }
      it { should be_able_to(:update,      my_coral_demograhpic) }
      it { should_not be_able_to(:update,  not_my_coral_demographic) }
    end
  end

  context 'when an admin' do
    let (:user) { FactoryGirl.create(:diver, role: Diver::ADMIN) }

    context '#admin?' do
      it 'returns true' do
        expect(user.admin?).to be_true
      end
    end
  end

  context 'when a manager' do
    let (:user) { FactoryGirl.create(:diver, role: Diver::MANAGER) }

    context '#manager?' do
      it 'returns true' do
        expect(user.manager?).to be_true
      end
    end
  end

  context 'when a diver' do
    let (:user) { FactoryGirl.create(:diver, role: Diver::DIVER) }

    context '#diver?' do
      it 'returns true' do
        expect(user.diver?).to be_true
      end
    end
  end

  describe "#whole_name" do
    let!(:diver) {FactoryGirl.create(:diver, :firstname => "Jeremiah", :lastname => "Blondeau")}

    it "should have correct whole name" do 
      expect(diver.whole_name).to eq("Jeremiah Blondeau")
    end
  end

  describe "#diver_proofing_samples" do
    let!(:boatlog_manager) {FactoryGirl.create(:boatlog_manager)}
    let!(:sample_animal) {FactoryGirl.create(:sample_animal, :sample => nil)}
    let!(:diver) {FactoryGirl.create(:diver)}
    let!(:samples) do
      3.times.map do 
        s = FactoryGirl.build(:sample, :boatlog_manager => boatlog_manager)
        s.sample_animals << sample_animal
        s.save
        s
      end
    end
    let!(:diver_samples) do
     [ FactoryGirl.create(:diver_sample, :diver => diver, :primary_diver => true, :sample => samples[0]),
       FactoryGirl.create(:diver_sample, :diver => diver, :primary_diver => false, :sample => samples[0]),
       FactoryGirl.create(:diver_sample, :diver => diver, :primary_diver => true, :sample => samples[1]),
       FactoryGirl.create(:diver_sample, :diver => diver, :primary_diver => false, :sample => samples[1]),
       FactoryGirl.create(:diver_sample, :primary_diver => true, :sample => samples[2])]
    end

    it "should only have current divers samples" do
      expect(diver.diver_proofing_samples.count).to eq(2)
    end
  end

end
