require 'sinatra'
require 'json'
require 'ostruct'
require 'open-uri'
require 'chartkick'

# get '/' do
#   @titel = "This is the home-Site"
#   erb :home
# end

# get '/index' do
#   status 404
#   @titel = "This the index-Site"
#   erb :index
# end

get '/' do
  @url_content  = open('https://api.koubachi.com/v2/plants.json?user_credentials=LFAW3KZO9Rk_xCkxnCEg&app_key=KLAB9OTEKTDF0BO70G9GJWK7') {|f| f.read }
  @json_obj = JSON.parse(@url_content, object_class: OpenStruct)[0]
  @plantdate = @json_obj.plant.created_at
  @titel = @json_obj.plant.name
  @water_level = @json_obj.plant.vdm_water_level
  erb :home
end
