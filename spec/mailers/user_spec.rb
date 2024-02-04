require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:mail) { UserMailer.registration_email(user).deliver_now }

  let(:mail_data) do
    {
      subject: 'Thank you for your registration!',
      from: ['support@book-store-api-tc-5855f695cf77.herokuapp.com']
    }
  end

  context 'descibe user registration' do
    it 'should the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'should be the subject' do
      expect(mail.subject).to eq(mail_data[:subject])
    end

    it 'should be the sender email' do
      expect(mail.from).to eq(mail_data[:from])
    end
  end
end
