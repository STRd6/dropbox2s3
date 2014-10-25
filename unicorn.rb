require "sidekiq"

worker_processes 2

before_fork do |server, worker|
  @sidekiq_pid ||= spawn("bundle exec sidekiq -r ./sidekiq.rb")
end
