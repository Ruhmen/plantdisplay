require 'sinatra'
require 'json'
require 'ostruct'
require 'open-uri'
require 'chartkick'

get '/' do
  @title = "home"
  erb :home
end

get '/palmi' do
  @url_content  = open('https://api.koubachi.com/v2/plants.json?user_credentials=LFAW3KZO9Rk_xCkxnCEg&app_key=KLAB9OTEKTDF0BO70G9GJWK7') {|f| f.read }
  @json_obj = JSON.parse(@url_content, object_class: OpenStruct)[0]
  @plantdate = @json_obj.plant.created_at
  @water_level = @json_obj.plant.vdm_water_level
  @title = "palmi"
  erb :palmi
end
