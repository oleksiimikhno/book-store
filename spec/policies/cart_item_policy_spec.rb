# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItemPolicy, type: :policy do
  let(:cart_item) { create(:cart_item) }
  let(:user) { User.find(cart_item.cart.user_id) }

  subject { described_class }

  context 'with admin' do
    permissions :show?, :create?, :update?, :destroy? do
      it 'grants access for admin' do
        expect(subject).to permit(user, cart_item)
      end
    end
  end

  context 'with visitor' do
    before { user.update(status: 0) }

    permissions :show?, :create?, :update? do
      it 'grants access to cart_item for visitors' do
        expect(subject).to permit(user, cart_item)
      end
    end

    permissions :destroy? do
      it 'denies access to cart_item for visitors' do
        expect(subject).not_to permit(user, cart_item)
      end
    end
  end
end
