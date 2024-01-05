require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) do
    {
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      password: 'Passw0rd'
    }
  end

  it 'should be valid with valid attributes' do
    user = User.new(valid_attributes)
    expect(user).to be_valid
  end

  it 'should not be valid without a first name' do
    user = User.new(
      last_name: 'Doe',
      email: 'john@example.com',
      password: 'Passw0rd'
    )
    expect(user).not_to be_valid
  end

  it 'should not be valid without a last name' do
    user = User.new(
      first_name: 'John',
      email: 'john@example.com',
      password: 'Passw0rd'
    )
    expect(user).not_to be_valid
  end

  it 'should not be valid without an email' do
    user = User.new(
      first_name: 'John',
      last_name: 'Doe',
      password: 'Passw0rd'
    )
    expect(user).not_to be_valid
  end

  it 'should not be valid without a password' do
    user = User.new(
      first_name: 'John',
      last_name: 'Doe'
    )
    expect(user).not_to be_valid
  end

  it 'validates presence and format of name' do
    user = User.new(first_name: 'John')
    expect(user).not_to be_valid

    user.first_name = 'J'
    expect(user).not_to be_valid

    user.first_name = 'John Smith'
    expect(user).not_to be_valid

    user.first_name = 'John123'
    expect(user).not_to be_valid

    user.first_name = 'John@Smith'
    expect(user).not_to be_valid
  end

  it 'validates presence and format of email' do
    user = User.new(valid_attributes)

    user.email = 'john@example.'
    expect(user).not_to be_valid

    user.email = 'john@example,com'
    expect(user).not_to be_valid

    user.email = 'john@example.com'
    expect(user).to be_valid
  end

  it 'validates format of password' do
    user = User.new(valid_attributes)

    user.password = 'passw0rd'
    expect(user).not_to be_valid

    user.password = '123456'
    expect(user).not_to be_valid

    user.password = 'Passw0rd'
    expect(user).to be_valid
  end
end
