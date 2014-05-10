require "spec_helper"

describe RequestMailer do
  [:group_request, :user_request, :request_confirmed].each do |method|
  	context "##{method}" do
  		it 'should be sent async' do
	  		expect { 
		  		UserMailer.delay.send(method, user1)
		  	}.to change(Sidekiq::Extensions::DelayedMailer.jobs, :size).by(1)
  		end
  	end
  end
end
