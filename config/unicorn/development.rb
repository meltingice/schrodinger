worker_count     = ENV['UNICORN_WORKERS'] || 4
worker_processes worker_count.to_i
rails_env = 'development'
