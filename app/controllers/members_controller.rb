class MembersController < ApplicationController

  def index
    @members = Member.all
    @invitations = Invitation.all
    @invitation = Invitation.new
  end

  def new
    invitation = Invitation.where("email_token = ?", params[:id]).first
    if invitation.nil?
      redirect_to root_path
    else
      @member = Member.new
      @member.name = invitation.name
      @member.email = invitation.email
    end
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to @member
    else
      render 'new'
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])

    if @member.update(member_params)
      redirect_to @member
    else
      render 'edit'
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to members_path
  end

  private

    def member_params
      params.require(:member).permit(
        :name,
        :profile_photo,
        :position,
        :program,
        :about
      )
    end

end
