# frozen_string_literal: true

RSpec.describe 'Test sending email with sidekiq', type: :request do
  let(:user) { create(:user) }

  it 'send order completed email to sidekiq queue' do
    expect do
      Email::OrderCompletedWorker.perform_async(user.id)
    end.to change(Email::OrderCompletedWorker.jobs, :size).by(1)
  end

  it 'should order completed be a correct worker' do
    expect { Email::OrderCompletedWorker.perform_async }.to enqueue_sidekiq_job(Email::OrderCompletedWorker)
  end

  it 'send order changed status email to sidekiq queue' do
    expect do
      Email::OrderChangedStatusWorker.perform_async(user.id)
    end.to change(Email::OrderChangedStatusWorker.jobs, :size).by(1)
  end

  it 'should order changed status be a correct worker' do
    expect { Email::OrderChangedStatusWorker.perform_async }.to enqueue_sidekiq_job(Email::OrderChangedStatusWorker)
  end
end
