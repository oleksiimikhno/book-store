require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }
  let(:second_product) { create(:product) }
  # let(:product) { create(:product, :with_image) }

  it 'creates a product' do
    expect(product).to be_valid
  end

  context 'descibe a product string fields' do
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
  end

  context 'describe a product prices' do
    it 'should a price cannot be negative' do
      product.price = -50
      expect(product).to_not be_valid
    end

    it 'should a quantity cannot be negative' do
      product.quantity = -1
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

  context 'descibe a product sort methods' do
    it 'should a last product should be at first position (default_sort)' do
      expect(product).to eq(Product.all.first)
    end

    it 'should a last product at last position' do
      products = Product.all.order_by_date(:asc)
      # debugger
      expect(product).to eq(products.last)
    end

    it 'should a last product at first position' do
      products = Product.all.order_by_date(:desc)
      
      expect(product).to eq(products.last)
    end

    it 'should a product with highest price at first prosition' do
      second_product.update(price: 1)
      products = Product.all.order_by_price(:desc)

      expect(product).to eq(products.first)
    end

    it 'should a product with highest price at last prosition' do
      second_product.update(price: 1)
      products = Product.all.order_by_price(:asc)

      expect(product).to eq(products.last)
    end
  end

  context 'describe a product images' do
    it 'should image has formats :webp, :jpg, :jpeg, :png' do
      is_expected.to validate_content_type_of(:image).allowing(:webp, :jpg, :jpeg, :png)
    end

    it 'should images has formats :webp, :jpg, :jpeg, :png' do
      is_expected.to validate_content_type_of(:images).allowing(:webp, :jpg, :jpeg, :png)
    end

    # it 'should image can be blank' do

    #   # debugger
    #   is_expected.to validate_attached_of(:image).allow_blank
    # end


#     it 'should should images attacheds'
    # it { is_expected.to validate_attached_of(:image) }


    # it { is_expected.to validate_size_of(:avatar).between(100..500.kilobytes) }

    # it { is_expected.to validate_attached_of(:avatar).allow_blank }

    # it { is_expected.to validate_attached_of(:avatar).on(:update) }

    # it { is_expected.to validate_dimensions_of(:avatar).width(250).with_message('Invalid dimensions.') }
  end

  #TODO 
   # add special price
   # it "should not valid without a start_date"
   # it "should not valid without a end_date"
end
