require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:products) { FactoryBot.create_list(:product, 3) }
  let(:product) { products.first }
  let(:second_product) { products.second }

  it 'creates a product' do
    expect(product).to be_valid
  end

  context 'describe a product fields' do
    it 'should a meta_title length below 20' do
      product.meta_title = '123'
      expect(product).to_not be_valid
    end

    it 'should a meta_title length above 120' do
      product.meta_title = 'Deleniti neque magni modi repellendus. Quia nemo l...' * 3
      expect(product).to_not be_valid
    end

    it 'should a meta_description length below 60' do
      product.meta_description = '123'
      expect(product).to_not be_valid
    end

    it 'should a meta_description length above 200' do
      product.meta_description = 'Deleniti neque magni modi repellendus. Quia nemo l...' * 4
      expect(product).to_not be_valid
    end

    it 'should meta_title or meta_description can be empty' do
      product.meta_title = nil
      expect(product).to be_valid

      product.meta_description = nil
      expect(product).to be_valid
    end

    it 'should a quantity cannot be negative' do
      product.quantity = -1
      expect(product).to_not be_valid
    end

    it 'should model cannot be nil' do
      product.model = nil
      expect(product).not_to be_nil
    end

    it 'should model cannot be empty' do
      product.model = ''
      expect(product).not_to be_valid
    end
  end

  context 'describe a product prices' do
    it 'should a price cannot be negative' do
      product.price = -50
      expect(product).to_not be_valid
    end

    it 'should a special_price price cannot be negative' do
      product.special_price = -50
      expect(product).to_not be_valid
    end
  end

  context 'describe a product enums' do
    it 'should should be an active status when create' do
      expect(product.active?).to be_truthy
    end

    it 'should a product can change own status' do
      product.status = 'inactive'
      expect(product.inactive?).to be_truthy

      product.status = 'archived'
      expect(product.archived?).to be_truthy
    end

    it 'should a product has awaiting status' do
      product.status = 'awaiting'
      expect(product.awaiting?).to be_truthy
    end
  end

  context 'describe a product relatives' do
    it 'should category_id cannot be empty' do
      product.category_id = ''
      expect(product).to_not be_valid
    end

    it 'should category_id cannot be negative' do
      product.category_id = -1

      expect(product).to_not be_valid
    end
  end

  context 'describe a product sort methods' do
    it 'should a last product should be at first position (default_sort)' do
      second_product.update!(price: 6000)
      expect(second_product).to eq(Product.all.last)
    end

    it 'should a last product at first position' do
      products = Product.order_by_date(:asc)

      expect(product).to eq(products.first)
    end

    it 'should a last product at last position' do
      products = Product.order_by_date(:desc)

      expect(product).to eq(products.last)
    end

    it 'should a product with highest price at first prosition' do
      second_product.update(price: 1)
      products = Product.order_by_price(:desc)
      expect(product).to eq(products.first)
    end

    it 'should a product with highest price at last prosition' do
      second_product.update(price: 1)
      products = Product.order_by_price(:asc)

      expect(product).to eq(products.last)
    end

    it 'should a product with highest special_price price at first prosition' do
      second_product.update(special_price: 1)
      products = Product.all.order_by_price(:desc)

      expect(product).to eq(products.first)
    end

    it 'should a product with highest duscount price at last prosition' do
      second_product.update(special_price: 1)
      products = Product.all.order_by_price(:asc)

      expect(product).to eq(products.last)
    end
  end

  context 'describe a product search' do
    it 'should find product in title' do
      product = products.last
      product.update(name: '123123')

      expect(product).to eq(Product.search('312').first)
    end

    it 'should find product in description' do
      product = products.last
      product.update(description: '123123')

      expect(product).to eq(Product.search('312').first)
    end

    it 'should sort search query' do
      products = Product.search('11')

      expect(products).to match_array([])
    end
  end

  context 'describe a product images' do
    it 'should image has formats :webp, :jpg, :jpeg, :png' do
      is_expected.to validate_content_type_of(:image).allowing(:webp, :jpg, :jpeg, :png)
    end

    it 'should images has formats :webp, :jpg, :jpeg, :png' do
      is_expected.to validate_content_type_of(:images).allowing(:webp, :jpg, :jpeg, :png)
    end

    it 'should image have currect size' do
      is_expected.to validate_size_of(:image).between(1.kilobyte..2.megabytes)
    end
  end

  #TODO 
   # add special price
   # it "should not valid without a start_date"
   # it "should not valid without a end_date"
end
