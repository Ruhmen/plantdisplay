require 'sinatra'
require 'json'
require 'ostruct'
require 'open-uri'
require 'chartkick'
require 'data_mapper'


get '/' do
  @title = "home"
  @tasks = Task.all
  erb :home
end

get '/palmi' do
  @url_content  = open('https://api.koubachi.com/v2/plants.json?user_credentials=LFAW3KZO9Rk_xCkxnCEg&app_key=KLAB9OTEKTDF0BO70G9GJWK7') {|f| f.read }
  @json_obj = JSON.parse(@url_content, object_class: OpenStruct)[0]
  @title = "palmi"
  @tasks = Task.all
  erb :palmi
end

get '/javascriptex' do
  @title = "javascriptex"
  @tasks = Task.all
  erb :javascriptex
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Task
  include DataMapper::Resource
  property :id,           Serial
  property :name,         String, :required => true
  property :completed,    String
end
DataMapper.finalize
