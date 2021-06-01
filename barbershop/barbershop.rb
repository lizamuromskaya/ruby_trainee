require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_barber_exists?(db, name)
  db.execute('select * from Barbers where name=?', [name]).length > 0
end

def seed_db(db, barbers)
  barbers.each do |barber|
    db.execute 'insert into Barbers (name) values (?)', [barber] unless is_barber_exists? db, barber
  end
end

def get_db
  db = SQLite3::Database.new 'barbershop.db'
  db.results_as_hash = true
  db
end

before do
  db = get_db
  @barbers = db.execute 'select * from Barbers'
end

configure do    # запуск при инициализации
  db = get_db

  db.execute 'CREATE TABLE IF NOT EXISTS
    "Users"
    (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "username" TEXT,
      "phone" TEXT,
      "datetime" TEXT,
      "barber" TEXT,
      "color" TEXT
    )'
  db.execute 'CREATE TABLE IF NOT EXISTS
    "Barbers"
    (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "name" TEXT
    )'
  seed_db db, %w[Alex Ann Jul]
end

get '/' do # add page http://localhost:4567
  erb :index # erb - template engine
end
get '/show' do
  db = get_db
  @results = db.execute 'select * from Users order by id'
  erb :showusers
end

post '/visit' do
  @user_name = params[:user_name]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @barber = params[:barber]
  @color = params[:color]
  @title = 'Thank you!'
  @message = "Dear #{@user_name}, we are waiting for you #{@datetime}. Your barber:#{@barber}. Color:"

  hh = { user_name: 'Enter your name',
         phone: 'Enter your phone number',
         datetime: 'Enter date' }

  @error = hh.select { |key, _| params[key] == '' }.values.join(', ')

  return erb :visit if @error != ''

  db = get_db
  db.execute 'insert into
  Users
  (
    username,
    phone,
    datetime,
    barber,
    color
  )
  values (?,?,?,?,?)', [@user_name, @phone, @datetime, @barber, @color]
  # f = File.open 'users.txt', 'a'
  # f.write "User: #{@user_name}, phone: #{@phone}, date and time: #{@datetime}. Barber: #{@barber}.Color #{@color}\n"
  # f.close
  erb :message
end

def is_parameters_empty?(hh); end

get '/about' do
  # @error='something wrong!'
  erb :about
end
get '/admin' do
  erb :admin
end
get '/visit' do
  erb :visit
end
get '/contacts' do
  erb :contacts
end

# /admin по паролю будет выдаваться список тех, кто записался (из users.txt)
post '/admin' do
  @login = params[:login]
  @password = params[:password]

  # проверим логин и пароль
  if @login == 'admin' && @password == 'admin'
    # @file = File.open("./users.txt","r")
    # erb :watch_result

  else
    @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
    erb :admin
  end
end
