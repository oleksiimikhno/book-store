require 'rails_helper'

RSpec.describe Cart, type: :model do
  it 'has paid status' do
    cart = Cart.new(status: :paid)
    expect(cart.paid?).to be_truthy
  end

  it 'has unpaid status' do
    cart = Cart.new(status: :unpaid)
    expect(cart.unpaid?).to be_truthy
  end

  it 'has canceled status' do
    cart = Cart.new(status: :canceled)
    expect(cart.canceled?).to be_truthy
  end

  it 'belongs to user' do
    user = User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'Passw0rd')
    cart = user.carts.create(status: :unpaid)
    expect(cart.user).to eq(user)
  end

  it 'has unpaid status by default' do
    cart = Cart.new
    expect(cart.unpaid?).to be_truthy
  end

  it 'can change status to paid' do
    user = User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'Passw0rd')
    cart = Cart.create(status: :unpaid, user_id: user.id)
    cart.paid!
    expect(cart.paid?).to be_truthy
  end
end
