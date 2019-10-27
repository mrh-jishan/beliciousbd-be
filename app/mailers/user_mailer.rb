class UserMailer < ApplicationMailer
    default :from => ENV["SES_FROM"]

    def registration_confirmation(user)
        @user = user
        mail(:to => "#{user.first_name} #{user.last_name} <#{user.email}>", :subject => "Registration Confirmation")
    end
end
