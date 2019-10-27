# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def registration_confirmation_email
        user  = User.first
        UserMailer.registration_confirmation(user)
    end
end
