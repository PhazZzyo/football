# Preview all emails at http://localhost:3000/rails/mailers/register_mailer
class RegisterMailerPreview < ActionMailer::Preview
    def welcome_mail
        RegisterMailer.with(user: User.first).welcome_mail
    end
end
