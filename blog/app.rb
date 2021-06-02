#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'bloginsinatra.db'
	@db.results_as_hash = true 
end

before do
	init_db   # индициализация БД
end

get '/' do
	erb "Hello!"
end

get '/new' do
	erb :new
end

post '/new' do
	content=params[:content]
	erb "You typed #{content}"
end
