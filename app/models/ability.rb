class Ability
  include CanCan::Ability

  def initialize(current_diver)
    # See https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
    if current_diver.admin?
      # All privileges
      can :manage, :all
    elsif current_diver.manager?
      # Create/draft samples
      can [:create, :draft], [Sample, BenthicCover, CoralDemographic]

      # Manage own samples
      can :manage, [Sample, BenthicCover, CoralDemographic], diver_id: current_diver.id
      can :manage, [Sample, BenthicCover, CoralDemographic], boatlog_manager_id: current_diver.boatlog_manager_id

      # Create boat logs
      can :create, [BoatLog]
      # Manage own boat logs
      can :manage, [BoatLog], boatlog_manager_id: current_diver.boatlog_manager_id
    elsif current_diver.diver?
      # Create/draft samples
      can [:create, :draft], [Sample, BenthicCover, CoralDemographic]

      # Read/update/delete own samples
      can [:read, :update, :destroy], [Sample, BenthicCover, CoralDemographic], diver_id: current_diver.id
    end
  end
end
