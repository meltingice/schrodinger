Sidekiq.configure_server do |config|
  config.redis = { :url => ENV['REDIS_PROVIDER'], :namespace => 'schrodinger' }
  config.default_worker_options = { 'queue' => Rails.env.to_s }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDIS_PROVIDER'], :namespace => 'schrodinger' }
  config.default_worker_options = { 'queue' => Rails.env.to_s }
end
