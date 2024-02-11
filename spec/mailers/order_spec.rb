require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  let(:cart_item) { create(:cart_item) }
  let(:order) { cart_item.cart }

  let(:email_data) do
    {
      subject: "Thank you for your order ##{order.id}!",
      from: ['support@book-store-api-tc-5855f695cf77.herokuapp.com']
    }
  end

  context 'describe order completed' do
    let(:email) { OrderMailer.with(order: order).order_completed_email.deliver_now }

    it 'should has an user email' do
      expect(email.to).to eq([order.user.email])
    end

    it 'should be an order subject' do
      expect(email.subject).to eq(email_data[:subject])
    end

    it 'should be the sender email' do
      expect(email.from).to eq(email_data[:from])
    end
  end

  context 'describe order changed status' do
    let(:subject) { "Your order ##{order.id} status changed to #{order.status}!" }
    let(:email) { OrderMailer.with(order: order).order_changed_status_email.deliver_now }

    it 'should has an user email' do
      expect(email.to).to eq([order.user.email])
    end

    it 'should be an order subject' do
      expect(email.subject).to eq(subject)
    end

    it 'should be the sender email' do
      expect(email.from).to eq(email_data[:from])
    end
  end
end
