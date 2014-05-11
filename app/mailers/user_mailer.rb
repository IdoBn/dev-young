class UserMailer < ActionMailer::Base
  default from: "ido@devyoung.com"

  def registration(user_id)
  	@user = User.find(user_id)
  	mail(to: "#{@user.name} <#{@user.email}>", subject: 'welcome!')
  end
end
