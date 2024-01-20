# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  subject { described_class }

  context 'with admin' do
    permissions :index?, :show?, :create?, :update?, :destroy? do
      it 'grants access to category for admin' do
        expect(subject).to permit(user, category)
      end
    end
  end

  context 'with visitor' do
    before { user.status = 0 }

    permissions :index?, :show? do
      it 'grants access to category for visitor' do
        expect(subject).to permit(user, category)
      end
    end

    permissions :create?, :update?, :destroy? do
      it 'grants no access to category for visitor' do
        expect(subject).not_to permit(user, category)
      end
    end
  end
end
