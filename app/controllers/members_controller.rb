class MembersController < ApplicationController

  before_action :authenticate_member!, except: [:show, :index]

  def index
    @members = Member.all
    @new_member = Member.new
  end

  def create
    @member = Member.new(new_member_params)
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
    if @member.update_attributes(edit_member_params)
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
