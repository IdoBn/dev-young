class UserMailer < ActionMailer::Base
  default from: "ido@devyoung.com"

  def registration(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", subject: 'welcome!')
  end
end
