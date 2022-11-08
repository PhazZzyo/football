class RegisterMailer < ApplicationMailer

    default From: 'welcome@footballpools.com'

    def welcome_mail
        
        @user = params[:user]
        mail(to: @user.email, subject: 'Welcome to Football pools app!')
    end
end
