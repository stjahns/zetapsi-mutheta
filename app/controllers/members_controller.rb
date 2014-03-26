class MembersController < ApplicationController

  before_action :authenticate_member!, except: [:show, :index]
  load_and_authorize_resource
  skip_authorize_resource :only => [:index]

  def index
    @members = Member.all
    @new_member = Member.new
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
    authorize! :assign_roles, @member if params[:member][:roles]
    if @member.update_attributes(member_params)
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
        :email,
        :elder,
        :profile_photo,
        :position,
        :program,
        :about,
        :roles => []
      )
    end

end
