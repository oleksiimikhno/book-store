# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user

class UserPreview < ActionMailer::Preview
  def registration_email
    UserMailer.with(user: User.first).registration_email
  end

  def reset_password_email
    UserMailer.with(user: User.first).reset_password_email
  end
end
