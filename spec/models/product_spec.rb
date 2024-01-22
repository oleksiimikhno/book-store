require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }
  let(:product2) { create(:product) }

  it 'creates a product' do
    expect(product).to be_valid
  end

  it 'is a meta_title length below 20' do
    product.meta_title = '123'
    expect(product).to_not be_valid
  end

  it 'is a meta_title length above 120' do
    product.meta_title = 'Deleniti neque magni modi repellendus. Quia nemo l...' * 3
    expect(product).to_not be_valid
  end

  it 'is a meta_description length below 60' do
    product.meta_description = '123'
    expect(product).to_not be_valid
  end

  it 'is a meta_description length above 200' do
    product.meta_description = 'Deleniti neque magni modi repellendus. Quia nemo l...' * 4
    expect(product).to_not be_valid
  end

  it 'is meta_title or meta_description can be empty' do
    product.meta_title = nil
    expect(product).to be_valid

    product.meta_description = nil
    expect(product).to be_valid
  end

  it 'is a price cannot be negative' do
    product.price = -50
    expect(product).to_not be_valid
  end

  it 'is a quantity cannot be negative' do
    product.quantity = -1
    expect(product).to_not be_valid
  end

  it 'is should be an active status when create' do
    expect(product.active?).to be_truthy
  end

  it 'is a product can change own status' do
    product.status = 'inactive'
    expect(product.inactive?).to be_truthy

    product.status = 'archived'
    expect(product.archived?).to be_truthy
  end

  it 'is category_id cannot be empty' do
    product.category_id = ''
    expect(product).to_not be_valid
  end

  it 'is category_id cannot be negative' do
    product.category_id = -1

    expect(product).to_not be_valid
  end

  it 'is a last product should be at first position (default_sort)' do
    expect(product).to eq(Product.all.first)
  end

  it 'should a last product at last position' do
    products = Product.all.order_by_date(:asc)
    expect(product).to eq(products.last)
  end

  it 'should a last product at first position' do
    products = Product.all.order_by_date(:desc)
    expect(product).to eq(products.last)
  end

  it 'is a product with highest price at first prosition' do
    product2.update(price: 1)
    products = Product.all.order_by_price(:desc)

    expect(product).to eq(products.first)
  end

  it 'is a product with highest price at last prosition' do
    product2.update(price: 1)
    products = Product.all.order_by_price(:asc)

    expect(product).to eq(products.last)
  end

  #TODO 
   # add special price
   # it 'is has attacments'
   # it "is not valid without a start_date"
   # it "is not valid without a end_date"
end
