class Ability
  include CanCan::Ability

  def initialize(member)
    # Define abilities for the passed in user here.

    member ||= Member.new # guest (not logged in as a member)
    # TODO member model should always *at least* have :guest role

    # only admins can assign roles
    can :assign_roles, Member if member.has_role? :admin

    if member.has_role? :admin

      # full admins can do anything
      can :manage, :all

    end

    if member.has_role? :basic

      # Basic members can only edit their own personal info
      can :read, Member
      can [:edit, :update], Member do |m|
        m.email == member.email
      end

    end

    if member.has_role? :manage_albums
      can :manage, Album
    end

    if member.has_role? :manage_events
      can :manage, Event
    end

    if member.has_role? :manage_pages
      can :manage, Page
      can :edit, EditableContent
    end

    if member.has_role? :guest

      # Guests can only read stuff
      can :read, Member

    end
  end
end
