class InviteMailer < ActionMailer::Base
  default from: "noreply@zetapsi-mutheta.com"

  def invite(invitation)
    @invitation = invitation
    @url = "#{members_url}/#{invitation.email_token}/confirm"
    mail to: invitation.email, subject: 'Create an account at Zeta Psi - Mu Theta'
  end
end
