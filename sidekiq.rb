require 'dropbox_sdk'
require 'fog'

require "./workers/uploader.rb"
require "./workers/delta.rb"

S3_KEY = ENV['S3_KEY']
S3_SECRET = ENV['S3_SECRET']

TOKEN = ENV['DROPBOX_TOKEN']

redis_conn = proc {
  Redis.new
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 2, &redis_conn)
end
Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 2, &redis_conn)
end
