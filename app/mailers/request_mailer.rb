class RequestMailer < ActionMailer::Base
  default from: "ido@devyoung.com"

  def group_request(request_id)
  	@request = Request.find(request_id)
  	mail(to: "#{@request.group.user.name} <#{@request.group.user.email}>", subject: 'Request!')
  end

  def user_request(request_id)
  	@request = Request.find(request_id)
  	mail(to: "#{@request.user.name} <#{@request.user.email}>", subject: 'Request!')
  end

  def request_confirmed(request_id)
  	@request = Request.find(request_id)
  	mail(
  		to: "#{@request.group.user.name} <#{@request.group.user.email}>, #{@request.user.name} <#{@request.user.email}>",
  		subject: 'Request Confirmed!')
  end
end
