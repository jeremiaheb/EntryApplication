class Ability
  include CanCan::Ability

  def initialize(current_diver)
    # See https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
    if current_diver.admin?
      # All privileges
      can :manage, :all
    else
      # Create/draft samples
      can [:create, :draft], [Sample, BenthicCover, CoralDemographic]

      # Read/update/delete own samples
      can [:read, :update, :destroy], [Sample, BenthicCover, CoralDemographic], diver_id: current_diver.id

      # If a mission manager ...
      if current_diver.missions_managed_ids.any?
        # Manage samples for missions managed
        can :manage, [Sample, BenthicCover, CoralDemographic], mission_id: current_diver.missions_managed_ids

        # Create boat logs
        can :create, [BoatLog]
        # Manage boat logs for missions managed
        can :manage, [BoatLog], mission_id: current_diver.missions_managed_ids
      end
    end
  end
end
