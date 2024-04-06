require 'rails_helper'

RSpec.describe Coupon, type: :model do
  let(:coupon) { create(:coupon) }

  it 'should be valid with valid attributes' do
    expect(coupon).to be_valid
  end

  it 'should has a status active' do
    expect(coupon.active?).to be_truthy
  end

  it 'should change status to an active' do
    coupon.active!
    expect(coupon.active?).to be_truthy
  end

  it 'should has contain an name' do
    expect(coupon[:first_name]).not_to be_empty
  end

  it 'should has contain an email' do
    expect(coupon[:email]).not_to be_empty
  end

  it 'should have a references to the user' do
    expect(coupon[:user_id]).to be_truthy
  end

  it 'should an user can be a nulleshed' do
    coupon.update(user_id: nil)
    expect(coupon[:user_id]).to be_nil
  end

  it 'should have an uncoupon token' do
    expect(coupon.token).to_not be_nil
  end

  it 'should generate new token' do
    old_token = coupon.token
    coupon.regenerate_token

    expect(coupon.token).to_not eq(old_token)
  end

  it 'should have a default discount_value' do
    expect(coupon.discount_value).to eq(10)
  end
end
