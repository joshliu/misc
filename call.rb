
require 'twilio-ruby'

account_sid = 'wat'
auth_token = '{{ wat }}'
@client = Twilio::REST::Client.new account_sid, auth_token
 
call = @client.account.calls.create(:url => "http://demo.twilio.com/docs/voice.xml",
    :to => "wat",
    :from => "wat")
puts call.to