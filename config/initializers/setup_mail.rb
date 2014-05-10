ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "devyoung.com",
  :user_name            => Rails.application.secrets.gmail_user_name,
  :password             => Rails.application.secrets.gmial_user_password,
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"