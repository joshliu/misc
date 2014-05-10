require 'rubygems'
require 'twilio-ruby'

# Get your Account Sid and Auth Token from twilio.com/user/account
account_sid = ''
auth_token = ''
@client = Twilio::REST::Client.new account_sid, auth_token

message = @client.account.sms.messages.create(
    :body => "wat",
    :to => "",     # Replace with your phone number
    :from => "")   # Replace with your Twilio number
puts message.sid
