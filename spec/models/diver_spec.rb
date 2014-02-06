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

end


