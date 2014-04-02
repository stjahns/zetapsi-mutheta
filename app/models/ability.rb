class Ability
  include CanCan::Ability

  def initialize(member)
    # Define abilities for the passed in user here.

    member ||= Member.new # guest (not logged in as a member)
    member.roles.add :guest

    if member.has_role? :admin

      # full admins can do anything
      # including assigning roles
      can :manage, :all

    end

    if member.has_role? :basic

      # Basic members can only edit their own personal info
      can :read, Member
      can [:edit, :update], Member do |m|
        m.email == member.email
      end

      # Basic members can only view their own transactions
      can [:read], Transaction,
        :member_id => member.id

      # Basic members can create reimbursement requests for themselves
      can [:create, :edit, :update], Transaction, 
        :member_id => member.id, 
        :type => "ReimbursementRequest"

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

      # Guests can only view active members
      can :read, Member do |m|
        not m.elder?
      end

    end
  end
end
