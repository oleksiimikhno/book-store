require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { create(:review) }

  it 'should have a text' do
    expect(review.text).not_to be_empty
  end

  it 'should have a rating' do
    expect(review.rating).not_to be_nil
  end

  it 'should have a user' do
    expect(review.user).not_to be_nil
  end

  it 'should have a reviewable' do
    expect(review.reviewable).not_to be_nil
  end

  it 'should have a references to the user' do
    expect(review[:user_id]).to be_truthy
  end

  it 'should have a references to the reviewable' do
    expect(review[:reviewable_id]).to be_truthy
  end

  it 'should have a references to the reviewable type' do
    expect(review[:reviewable_type]).to be_truthy
  end

  it 'should have a rating between 1 and 5' do
    expect(review.rating).to be_between(1, 5)
  end

  it 'should have a text length between 3 and 2500' do
    expect(review.text.length).to be_between(3, 2500)
  end

  it 'should have a text length below 2500' do
    review.text = 'a' * 2501
    expect(review).to_not be_valid
  end
end
