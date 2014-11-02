require "sidekiq"
require "sidekiq/web"

require './app'

run Rack::URLMap.new(
  '/' => Sinatra::Application,
  '/sidekiq' => Sidekiq::Web
)

redis_conn = proc {
  Redis.new
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 2, &redis_conn)
end
Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 2, &redis_conn)
end
