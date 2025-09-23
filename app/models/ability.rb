class Ability
  include CanCan::Ability

  def initialize(current_diver)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    #

    if current_diver.role == "admin"
      can :manage, :all
    elsif current_diver.role == "manager"
      can :manage, [Sample, BenthicCover, CoralDemographic, BoatLog]
    elsif current_diver.role == "diver"
      can :draft, [Sample, BenthicCover, CoralDemographic]
      can :create, [Sample, BenthicCover, CoralDemographic]
      can :read, [Sample, BenthicCover, CoralDemographic]
      can :length_histogram, [Sample]
      can :destroy, [Sample, BenthicCover, CoralDemographic]
      can :update, Sample do |sample|
        sample.try(:myId) == current_diver.id
      end
      can :update, BenthicCover do |cover|
        cover.try(:myId) == current_diver.id
      end
      can :update, CoralDemographic do |coral_demographic|
        coral_demographic.try(:myId) == current_diver.id
      end
    end
  end
end
