class RequestMailer < ActionMailer::Base
  default from: "notification@devyoung.com"

  def group_request(request)
  	@request = request
  	mail(to: "#{request.group.user.name} <#{request.group.user.email}>", subject: 'Request!')
  end

  def user_request(request)
  	@request = request
  	mail(to: "#{request.user.name} <#{request.user.email}>", subject: 'Request!')
  end

  def request_confirmed(request)
  	@request = request
  	mail(
  		to: "#{request.group.user.name} <#{request.group.user.email}>, #{request.user.name} <#{request.user.email}>",
  		subject: 'Request Confirmed!')
  end
end
