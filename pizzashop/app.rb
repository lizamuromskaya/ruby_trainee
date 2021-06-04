#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

#set :bind, '0.0.0.0'
set :database, {adapter: "sqlite3", database: "pizzashop.db"}

class Product < ActiveRecord::Base
	#validates :name, presence: true
end

get '/' do
	erb :index
end

get '/about' do
	erb :about
end