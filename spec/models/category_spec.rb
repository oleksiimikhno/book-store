require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }

  it 'creates a category' do
    expect(category).to be_valid
  end

  it 'is a meta_title length below 20' do
    category.meta_title = '123'
    expect(category).to_not be_valid
  end

  it 'is a meta_title length above 120' do
    category.meta_title = 'Deleniti neque magni modi repellendus. Quia nemo l...' * 3
    expect(category).to_not be_valid
  end

  it 'is a meta_description length below 60' do
    category.meta_description = '123'
    expect(category).to_not be_valid
  end

  it 'is a meta_description length above 200' do
    category.meta_description = 'Deleniti neque magni modi repellendus. Quia nemo l...' * 4
    expect(category).to_not be_valid
  end

  it 'is meta_title or meta_description can be empty' do
    category.meta_title = nil
    expect(category).to be_valid

    category.meta_description = nil
    expect(category).to be_valid
  end
end
