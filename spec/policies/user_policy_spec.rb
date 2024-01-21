# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:user) { create(:user) }

  subject { described_class }


  context 'with admin' do
    permissions :index?, :show?, :create?, :update?, :destroy? do
      it 'grants access to user for admin' do
        expect(subject).to permit(user, user)
      end
    end
  end

  context 'with visitor' do
    before { user.status = 0 }

    permissions :show?, :create?, :update?, :destroy? do
      it 'grants access to user for visitor' do
        expect(subject).to permit(user, user)
      end
    end

    permissions :index? do
      it 'grants no access to user for visitor' do
        expect(subject).not_to permit(user, user)
      end
    end
  end
end
