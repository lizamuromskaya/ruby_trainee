#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :barber, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end 

get '/' do
	erb :index			
end

get '/clients' do
	@clients=Client.order('created_at DESC')
	erb :clients		
end

get '/clients/:id' do
	@client = Client.find(params[:id])
	erb :client
end

get '/contacts' do
	erb "Phone: +375441111111"		
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
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
		@error = @c.errors.full_messages.first
		erb :visit
	end
end