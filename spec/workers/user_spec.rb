# frozen_string_literal: true

require 'sidekiq/testing'

RSpec.describe 'Test sending email with sidekiq', type: :request do
  let(:user) { create(:user) }

  it 'send email to sidekiq queue' do
    expect do
      RegistrationEmailWorker.perform_async(user.id)
    end.to change(RegistrationEmailWorker.jobs, :size).by(1)
  end

  it 'should be a correct worker' do
    expect { RegistrationEmailWorker.perform_async }.to enqueue_sidekiq_job(RegistrationEmailWorker)
  end
end
