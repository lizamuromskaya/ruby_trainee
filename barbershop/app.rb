#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base

end

before do
	@barbers = Barber.all
end 


get '/' do
	@barbers=Barber.all
	erb :index
end

get '/visit' do
	@c = Client.new
  erb :visit
end

post '/visit' do

	@c = Client.new params[:client]
	if @c.save
		erb "<h2>Thank you!</h2>"
	else
		#@error = @c.errors.full_messages.first
		erb :visit
	end
end