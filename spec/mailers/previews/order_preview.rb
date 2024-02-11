# frozen_string_literal: true
# Preview all emails at http://localhost:3000/rails/mailers/order

class OrderPreview < ActionMailer::Preview
  def order_completed_email
    OrderMailer.with(user: Order.first).order_completed_email
  end
end
