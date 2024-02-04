class UserMailer < ApplicationMailer
  default from: 'support@book-store-api-tc-5855f695cf77.herokuapp.com'

  def registration_email
    @user = params[:user]
    @url = Rails.env.development? ? 'http://localhost:3000' : params[:host]

    mail(to: @user.email, subject: 'Thank you for your registration!') do |format|
      format.html { render 'registration_email' }
    end
  end
end
