require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:subscription) { create(:subscription) }

  it 'should be valid with valid attributes' do
    expect(subscription).to be_valid
  end

  it 'should has a status inactive' do
    expect(subscription.inactive?).to be_truthy
  end

  it 'should change status to an active' do
    subscription.active!
    expect(subscription.active?).to be_truthy
  end

  it 'should has contain an email' do
    expect(subscription[:email]).not_to be_empty
  end

  it 'should have a references to the user' do
    expect(subscription[:user_id]).to be_truthy
  end

  it 'should an user can be a nulleshed' do
    subscription.update(user_id: nil)
    expect(subscription[:user_id]).to be_nil
  end
end
