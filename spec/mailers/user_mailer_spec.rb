require "spec_helper"

describe UserMailer do
	context '#registration' do
		it 'sends registration mail async' do
	  	expect { 
	  		UserMailer.delay.registration(user1.id)
	  	}.to change(Sidekiq::Extensions::DelayedMailer.jobs, :size).by(1)
	  end
	end
end
