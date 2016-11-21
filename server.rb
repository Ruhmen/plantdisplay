require 'sinatra'
require 'json'
require 'ostruct'
require 'open-uri'
require 'chartkick'
# require 'groupdate'
load 'model/task.rb'

get '/' do
  @title = "home"
  @tasks = Task.all
  erb :home
end

get '/palmi' do
  @title = "palmi"
  @tasks = Task.all
  erb :palmi
end

get '/javascriptex' do
  @title = "javascriptex"
  @tasks = Task.all
  erb :javascriptex
end
