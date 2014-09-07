web: bundle exec unicorn -p $PORT -c ./config/unicorn/$RAILS_ENV.rb
worker: bundle exec sidekiq -C ./config/sidekiq.yml -e $RAILS_ENV
