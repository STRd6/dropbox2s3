require "sidekiq"

worker_processes 1

before_fork do |server, worker|
  @sidekiq_pid ||= spawn("bundle exec sidekiq -r ./sidekiq.rb")
end
