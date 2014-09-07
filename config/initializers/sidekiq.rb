config = YAML.load(File.read(Rails.root.join('config/redis.yml')))[Rails.env.to_s]
REDIS_PROVIDER ||= "redis://#{config['host']}:#{config['port']}"

Sidekiq.configure_server do |config|
  config.redis = { :url => REDIS_PROVIDER, :namespace => 'droplytics' }
  config.default_worker_options = { 'queue' => Rails.env.to_s }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => REDIS_PROVIDER, :namespace => 'droplytics' }
  config.default_worker_options = { 'queue' => Rails.env.to_s }
end
