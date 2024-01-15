require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart_item) { create(:cart_item) }

  it 'creates a cart_item' do
    expect(cart_item).to be_valid
  end

  it 'is a quantity cannot be negative' do
    cart_item.quantity = -1
    expect(cart_item).to_not be_valid
  end

  it 'is a price cannot be negative' do
    cart_item.price = -1
    expect(cart_item).to_not be_valid
  end

  it 'ensures price is a float' do
    expect(cart_item.price).to be_a_kind_of(Float)
  end
end
