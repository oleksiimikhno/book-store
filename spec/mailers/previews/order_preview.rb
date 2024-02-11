# frozen_string_literal: true
# Preview all emails at http://localhost:3000/rails/mailers/order

class OrderPreview < ActionMailer::Preview
  def order_completed_email
    OrderMailer.with(order: Cart.first).order_completed_email
  end

  def order_changed_status_email
    OrderMailer.with(order: Cart.first).order_changed_status_email
  end
end
