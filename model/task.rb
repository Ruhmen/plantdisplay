require 'data_mapper'
require 'dm-migrations'
require 'pry'

class Task
  include DataMapper::Resource
  property :id,           Serial
  property :name,         String, :required => true
  property :value,        Float
  property :completed_at, DateTime
end
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
DataMapper.finalize
DataMapper.auto_upgrade!


Thread.new do
  if Task.all(:name => 'Bodentemperatur').last == nil
    @url_content  = open('https://api.koubachi.com/v2/plants.json?user_credentials=LFAW3KZO9Rk_xCkxnCEg&app_key=KLAB9OTEKTDF0BO70G9GJWK7') {|f| f.read }
    @json_obj = JSON.parse(@url_content, object_class: OpenStruct)[0]
    @task = Task.create(name: "Wasser-Level", value: @json_obj.plant.vdm_water_level.round(3), completed_at: Time.now)
    @task = Task.create(name: "Bodentemperatur", value: @json_obj.plant.vdm_temperature_level.round(3), completed_at: Time.now)
    @task = Task.create(name: "Licht-Level", value: @json_obj.plant.vdm_light_level.round(3), completed_at: Time.now)
  end
  while true do
    @url_content  = open('https://api.koubachi.com/v2/plants.json?user_credentials=LFAW3KZO9Rk_xCkxnCEg&app_key=KLAB9OTEKTDF0BO70G9GJWK7') {|f| f.read }
    @json_obj = JSON.parse(@url_content, object_class: OpenStruct)[0]
    if Task.all(:name => 'Wasser-Level').last.value != @json_obj.plant.vdm_water_level
      @task = Task.create(name: "Wasser-Level", value: @json_obj.plant.vdm_water_level.round(3), completed_at: Time.now)
    end
    if Task.all(:name => 'Bodentemperatur').last.value != @json_obj.plant.vdm_temperature_level
      @task = Task.create(name: "Bodentemperatur", value: @json_obj.plant.vdm_temperature_level.round(3), completed_at: Time.now)
    end
    if Task.all(:name => 'Licht-Level').last.value != @json_obj.plant.vdm_light_level
      @task = Task.create(name: "Licht-Level", value: @json_obj.plant.vdm_light_level.round(3), completed_at: Time.now)
    end
    sleep 120
  end
end
