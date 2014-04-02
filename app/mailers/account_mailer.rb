class AccountMailer < ActionMailer::Base
  default from: "noreply@zetapsi-mutheta.com"

  def transaction_email(transaction)
    @transaction = transaction
    @member = Member.find(transaction.member_id)

    unless @transaction.receipt.nil?

      tmp_path = "#{Rails.root}/tmp/reciept";
      transaction.receipt.copy_to_local_file(:original, tmp_path)
      attachments['receipt.jpg'] = File.new(tmp_path).read
    end

    mail(to: @member.email, subject: 'A Transaction has been Added to Your Account')
  end
    
end
