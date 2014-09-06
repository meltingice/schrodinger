unicorn: bundle exec unicorn -p 3000 -c config/unicorn/development.rb > /dev/null 2>&1
sidekiq: bundle exec sidekiq -C config/sidekiq.yml -e development
rails: tail -n 0 -f log/development.log
