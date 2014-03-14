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
      @edit_password = true
    end
  end

  def create
    @member = Member.new(new_member_params)
    if @member.save
      # destroy the corresponding invitation
      Invitation.destroy_all("email = '#{@member.email}'")
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

    if @member.update(edit_member_params)
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

    def new_member_params
      params.require(:member).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :profile_photo,
        :position,
        :program,
        :about
      )
    end

    def edit_member_params
      params.require(:member).permit(
        :name,
        :email,
        :profile_photo,
        :position,
        :program,
        :about
      )
    end

end
