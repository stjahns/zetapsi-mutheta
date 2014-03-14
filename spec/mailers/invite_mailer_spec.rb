require "spec_helper"

describe InviteMailer do
  before do 
    @invitation = Invitation.new(name: "Joe Schmoe", email: "abc@xyz.com")
    @invitation.email_token = SecureRandom.hex(64)
  end

  let(:mail) { InviteMailer.invite @invitation }

  describe 'invite' do

    it 'renders invitation subject' do
      mail.subject.should =~ /create an account/i
    end

    it 'renders receiver email' do
      mail.from.should == ['noreply@zetapsi-mutheta.com']
    end

    it 'renders sender email' do
      mail.to.should == [@invitation.email]
    end

    it 'uses name in body' do
      mail.body.encoded.should match(@invitation.name)
    end

    it 'uses confirmation token in body' do
      mail.body.encoded.should match(@invitation.email_token)
    end

  end
end
