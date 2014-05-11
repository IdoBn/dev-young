ActionMailer::Base.smtp_settings = {
  :address              => "smtp.mandrillapp.com",
  :port                 => 587,
  :domain               => "heroku.com",
  :user_name            => ENV['MANDRILL_USERNAME'],
  :password             => ENV['MANDRILL_APIKEY'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_url_options[:host] = "localhost:3000" # this will need to change