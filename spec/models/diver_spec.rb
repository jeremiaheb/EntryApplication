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
      it { should be_able_to(:manage, Dashboard) }
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
