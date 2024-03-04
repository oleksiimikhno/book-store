# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductPolicy, type: :policy do
  let(:product) { create(:product) }
  let(:user) { create(:user) }

  subject {described_class}

  context 'with admin' do
    permissions :index?, :show?, :create?, :update?, :destroy?, :add_label?, :remove_label? do
      it 'grants access to product for admin' do
        expect(subject).to permit(user, product)
      end
    end
  end

  context 'with visitor' do
    before { user.status = 0 }

    permissions :index?, :show? do
      it 'grants access to product for visitor' do
        expect(subject).to permit(user, product)
      end
    end

    permissions :create?, :update?, :destroy?, :add_label?, :remove_label? do
      it 'grants no access to product for visitor' do
        expect(subject).not_to permit(user, product)
      end
    end
  end
end
