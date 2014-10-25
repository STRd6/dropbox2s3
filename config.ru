require "sidekiq"
require "sidekiq/web"

require './app'

run Rack::URLMap.new(
  '/' => Sinatra::Application,
  '/sidekiq' => Sidekiq::Web
)
