class DevelopmentMailInterceptor

  # Redirect mail to gmail account listed in .gmail
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    puts "REDIRECTING TO: #{ENV['MAIL_USERNAME']}@gmail.com"
    message.to = "#{ENV["MAIL_USERNAME"]}@gmail.com"
  end

end
