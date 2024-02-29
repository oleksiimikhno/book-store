# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LabelPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:label) { create(:label) }

  subject { described_class }

  context 'with admin' do
    permissions :index?, :show?, :create?, :update?, :destroy? do
      it 'grants access to label for admin' do
        expect(subject).to permit(user, label)
      end
    end
  end

  context 'with visitor' do
    before { user.status = 0 }

    permissions :index?, :show? do
      it 'grants access to label for visitor' do
        expect(subject).to permit(user, label)
      end
    end

    permissions :create?, :update?, :destroy? do
      it 'grants no access to label for visitor' do
        expect(subject).not_to permit(user, label)
      end
    end
  end
end
