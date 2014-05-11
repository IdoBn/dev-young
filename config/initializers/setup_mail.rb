ActionMailer::Base.smtp_settings = {
  :port =>           '587',
  :address =>        'smtp.mandrillapp.com',
  :user_name =>      ENV['MANDRILL_USERNAME'],
  :password =>       ENV['MANDRILL_APIKEY'],
  :domain =>         'heroku.com',
  :authentication => :plain
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_url_options[:host] = "http://aqueous-brook-9907.herokuapp.com/" # this will need to change