FactoryGirl.define do
	factory :user do
		provider 'facebook'
		uid '100008238285369'
		name 'Maria Amhbchbhecfi Narayananman'
		email 'azxdapn_narayananman_1399144402@tfbnw.net'
		oauth_token 'CAAEKU6pnZCngBAJgDG4ACqq3tnJ3c7ue5wZAksudu7cEd9LTQrKQPWNSQRl0dkw73QrG9EQBJSx0PbXjKSRZCqjZBUtW2HlRrLursNZC5LB7YHR2Pcchl4FGSYR9ErAYNTvaPNNZArhZAJgxZAclKWQSwOfwXM9Rf1mGSF5rZC97M92o4MCIkdHki3S8Jf2r0he8ZD'
		oauth_expires_at 1.hour.from_now

		factory :user2 do
			uid '100008305658419'
			name 'Susan Amhcjefehdai Greeneescu'
			email 'dadxxaw_greeneescu_1399144357@tfbnw.net'
			oauth_token 'CAAEKU6pnZCngBAPWv7DBY8sFIIdfaBDxtbfq2WrEcG0koRepZC1WpaSogZBZAYdXnZAXVQCzHU0OGwLKjTGM7vaFwTk78I6xHeY7lu4cVj2J6UhjmDjvR0LidgwG0ml3SUGlxkPldgp4EyZAGr3A0TPmY6HAz1NT62xyAZAY3dYS7p9ZAy60ZCygD2BVfKI0Rgq4ZD'
		end

		factory :user3 do
			uid '100008223768432'
			name 'Donna Amhbbcgfhdcb Sidhustein'
			email 'xlcyfef_sidhustein_1399144349@tfbnw.net'
			oauth_token 'CAAEKU6pnZCngBADyvCM4xNcSFUucORRtgrTK28EvwYAVUj20ZCYfISKL4AXfAyc5lVKPpSjALsXDu84v04Pc3MCxXwNMZCBNoHSkXt7AjkAsxlnTTgg4krZC2I6F1M3CQqEcZCoZAZAdGDZCZB7VNfOBZADe93rMsc9cAwVjVlEyI7t7s8eWktSILXNqspMSGfFGIZD'
		end
	end
end