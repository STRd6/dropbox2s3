require 'dropbox_sdk'
require 'fog'

require "./workers/uploader.rb"
require "./workers/delta.rb"

S3_KEY = ENV['S3_KEY']
S3_SECRET = ENV['S3_SECRET']

TOKEN = ENV['DROPBOX_TOKEN']

REDIS = Redis.new(:url => ENV['REDIS_URL'])
