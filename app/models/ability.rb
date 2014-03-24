class Ability
  include CanCan::Ability

  def initialize(member)
    # Define abilities for the passed in user here.

    member ||= Member.new # guest (not logged in as a member)

    # only admins can assign roles
    can :assign_roles, Member if member.has_role? :admin

    if member.has_role? :admin

      # full admins can do anything
      can :manage, :all

    elsif member.has_role? :basic

      # Basic members can only edit their own personal info
      can :read, Member
      can [:edit, :update], Member do |m|
        m.email == member.email
      end

    elsif member.has_role? :guest

      # Guests can only read stuff
      can :read, Member

    end
  end
end
