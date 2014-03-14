require 'development_mail_interceptor'

gmail_file = Rails.root.join('.gmail')

if File.exist?(gmail_file)

  user_password_host = File.read(gmail_file).chomp.split(/\n/);
  user = user_password_host[0];
  password = user_password_host[1];
  host = user_password_host[2];

  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "gmail.com",
    :user_name            => user,
    :password             => password,
    :authentication       => "plain",
    :enable_starttls_auto => true
  }

  ActionMailer::Base.default_url_options[:host] = host

else
  raise "Missing .gmail config file in Rais root!"
end

Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
