require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'] }
  config.default_worker_options = { 'retry' => 3 }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'] }
end