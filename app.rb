
require 'pry' if ENV["RACK_ENV"] == "development"
require 'sinatra'

require './workers/delta'

get '/hi' do
  "Hello World!"
end

get "/webhook" do
  challenge = params[:challenge]
  logger.info challenge

  return challenge
end

get "/test" do
  Delta.perform_async(1)
end

post "/webhook" do
  data = JSON.parse(request.body.read.to_s)

  logger.info data.inspect

  data["delta"]["users"].each do |id|
    Delta.perform_async(id)
  end
end
