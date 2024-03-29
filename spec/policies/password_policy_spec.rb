# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordPolicy, type: :policy do
  let(:user) { create(:user) }

  subject { described_class }

  context 'with admin' do
    permissions :update? do
      it 'grants access to password for admin' do
        expect(subject).to permit(user, user)
      end
    end
  end

  context 'with visitor' do
    before { user.status = 0 }

    permissions :update? do
      it 'grants access to password for user' do
        expect(subject).to permit(user, user)
      end

      it 'grants no access to password for another user' do
        another_user = User.new
        expect(subject).not_to permit(another_user, user)
      end
    end
  end
end
