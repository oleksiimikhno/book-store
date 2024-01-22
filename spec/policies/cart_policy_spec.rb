# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartPolicy, type: :policy do
  let(:cart_first) { create(:cart) }
  let(:user) { User.find(cart_first.user_id) }
  let(:cart_second) { user.carts.create }
  let(:carts) { [cart_first, cart_second] }

  subject { described_class }

  context 'with admin' do

    permissions :index? do
      it 'grants access for admin' do
        expect(subject).to permit(user, carts)
      end
    end

    permissions :show?, :create?, :update?, :destroy? do
      it 'grants access for admin' do
        expect(subject).to permit(user, cart_first)
      end
    end
  end

  context 'with visitor' do
    before { user.update(status: 0) }

    permissions :index? do
      it 'grants access to cart if the user owns the cart' do
        expect(subject).to permit(user, carts)
      end
    end

    permissions :show?, :update? do
      it 'grants access to cart if the user owns the cart' do
        expect(subject).to permit(user, cart_first)
      end
    end

    permissions :create? do
      it 'grants access to cart for visitor' do
        expect(subject).to permit(user, cart_first)
      end
    end

    permissions :destroy? do
      it 'denies access to cart for visitor' do
        expect(subject).not_to permit(user, cart_first)
      end
    end
  end
end
