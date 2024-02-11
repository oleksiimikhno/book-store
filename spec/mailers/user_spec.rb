require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:email) { UserMailer.with(user: user).registration_email.deliver_now }

  let(:email_data) do
    {
      subject: 'Thank you for your registration!',
      from: ['support@book-store-api-tc-5855f695cf77.herokuapp.com']
    }
  end

  context 'descibe user registration' do
    it 'should the receiver email' do
      expect(email.to).to eq([user.email])
    end

    it 'should be the subject' do
      expect(email.subject).to eq(email_data[:subject])
    end

    it 'should be the sender email' do
      expect(email.from).to eq(email_data[:from])
    end
  end
end
