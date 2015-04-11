class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

      user ||= User.new # guest user (not logged in)
      if user.has_role? :admin
         can :manage, User
         can :manage, Business
         can :manage, Cancellation
     elsif user.has_role? :business_admin
         can :manage, User, business_id: user.business_id
         can :read, Business, id: user.business_id
         can :manage, Cancellation, user: { business_id: user.business_id }
     else
         can :read, User, business_id: user.business_id
         can :read, Business, id: user.business_id
         can :manage, Cancellation, creator: { business_id: user.business_id}
     end
  end
end
