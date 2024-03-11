require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:favorite) { create(:favorite) }
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  it 'should be valid with valid attributes' do
    expect(favorite).to be_valid
  end

  it 'should a favorite equal a user product' do
    favorite = Favorite.create(user_id: user.id, product_id: product.id)

    expect(user.products.first).to eq(favorite.product)
  end

  it 'should a favorite be deleted' do
    favorite = Favorite.create(user_id: user.id, product_id: product.id)
    favorite.destroy

    expect(user.products).to match_array([])
  end
end
