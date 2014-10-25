require 'sinatra'

get '/hi' do
  "Hello World!"
end

get "/webhook" do
  params[:challenge]
end
