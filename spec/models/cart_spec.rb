require 'rails_helper'

RSpec.describe Cart, type: :model do
  it 'has active status' do
    cart = Cart.new(status: :active)
    expect(cart.active?).to be_truthy
  end

  it 'has active status' do
    cart = Cart.new(status: :archive)
    expect(cart.archive?).to be_truthy
  end

  it 'belongs to user' do
    user = User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'Passw0rd')
    cart = user.carts.create(status: :active)
    expect(cart.user).to eq(user)
  end

  it 'has active status by default' do
    cart = Cart.new
    expect(cart.active?).to be_truthy
  end

  it 'can change status to archive' do
    user = User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'Passw0rd')
    cart = Cart.create(status: :active, user_id: user.id)
    cart.archive!
    expect(cart.archive?).to be_truthy
  end
end
