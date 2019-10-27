# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def registration_confirmation_email
        user  = User.find_by_email("robinhassan.cs1@gmail.com")
        UserMailer.registration_confirmation(user)
    end
end
