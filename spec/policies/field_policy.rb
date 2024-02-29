# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:label) { create(:label) }
  let(:field) { create(:field) }

  subject { described_class }

  context 'with admin' do
    permissions :index?, :show?, :create?, :update?, :destroy? do
      it 'grants access to field for admin' do
        expect(subject).to permit(user, field)
      end
    end
  end

  context 'with visitor' do
    before { user.status = 0 }

    permissions :index?, :show? do
      it 'grants access to field for visitor' do
        expect(subject).to permit(user, field)
      end
    end

    permissions :create?, :update?, :destroy? do
      it 'grants no access to field for visitor' do
        expect(subject).not_to permit(user, field)
      end
    end
  end
end
