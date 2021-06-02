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

configure do
	init_db
	@db.execute 'create table if not exists Posts
	(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		outhor TEXT,
		created_date DATE,
		content TEXT
	)'
		# DEFAULT 'Anonymous'
	@db.execute 'create table if not exists Comments
	(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		outhor TEXT,
		created_date DATE,
		content TEXT,
		post_id integer
	)'
end

get '/' do
	@results = @db.execute 'select * from Posts order by id desc'

	erb :index			
end


get '/new' do
	erb :new
end

post '/new' do
	outhor = params[:outhor]
	content = params[:content]

	if content.length <= 0
		@error = 'Type post text'
		return erb :new
	end

	@db.execute 'insert into Posts (outhor, content, created_date) values (?,?, datetime())', [outhor,content]

	redirect to '/'
end


get '/details/:post_id' do

	post_id = params[:post_id]

	results = @db.execute 'select * from Posts where id = ?', [post_id]

	@row = results[0]

	@comments = @db.execute 'select * from Comments where post_id = ? order by id', [post_id]

	erb :details
end


post '/details/:post_id' do
	outhor = params[:outhor]

	post_id = params[:post_id]

	content = params[:content]	

	if content.length <= 0
		@error = 'Type comment text'
		return erb :details
	end

	@db.execute 'insert into Comments
		(
			outhor,
			content,
			created_date,
			post_id
		)
			values
		(
			?,
			?,
			datetime(),
			?
		)', [outhor,content, post_id]


	redirect to('/details/' + post_id)
end
