class DevelopmentMailInterceptor

  # Redirect mail to gmail account listed in .gmail
  def self.delivering_email(message)
    gmail_file = Rails.root.join('.gmail')

    if File.exist?(gmail_file)
      user_password_host = File.read(gmail_file).chomp.split(/\n/);
      user = user_password_host[0];

      message.subject = "#{message.to} #{message.subject}"
      message.to = "#{user}@gmail.com"
    end
  end

end
