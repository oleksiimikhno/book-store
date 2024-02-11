# frozen_string_literal: true

RSpec.describe 'Test sending email with sidekiq', type: :request do
  let(:user) { create(:user) }

  it 'send email to sidekiq queue' do
    expect do
      Email::RegistrationWorker.perform_async(user.id)
    end.to change(Email::RegistrationWorker.jobs, :size).by(1)
  end

  it 'should be a correct worker' do
    expect { Email::RegistrationWorker.perform_async }.to enqueue_sidekiq_job(Email::RegistrationWorker)
  end
end
