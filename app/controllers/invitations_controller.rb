class InvitationsController < ApplicationController

  def create
    @invitation = Invitation.new(invite_params)
    @invitation.email_token = SecureRandom.hex(32)

    if @invitation.save
      InviteMailer.invite(@invitation).deliver
      flash[:success] = "Invite sent successfully!"
    else
      flash[:error] = "Invite failed!"
    end
    redirect_to members_path
  end

  def destroy
    @invitation = Invitation.find(params[:id]);
    @invitation.destroy
    redirect_to members_path
  end

  private

    def invite_params
      params.require(:invitation).permit(
        :name,
        :email
      )
    end

end