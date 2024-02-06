class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@book-store-api-tc-5855f695cf77.herokuapp.com'
  layout 'mailer'

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end
end
