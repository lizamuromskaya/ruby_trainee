require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
#ctrl+/

 def get_db
  return SQLite3::Database.new 'barbershop.db'
 end
 
configure do
  #запуск при инициализации
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

end

get '/' do #add page http://localhost:4567
	erb :index # erb - template engine 
end

post '/visit' do
  @user_name = params[:user_name]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @barber = params[:barber]
  @color=params[:color]
  @title = "Thank you!"
  @message = "Dear #{@user_name}, we are waiting for you #{@datetime}. Your barber:#{@barber}. Color:"
  
  hh={ :user_name =>'Enter your name',
        :phone=>'Enter your phone number',
        :datetime=>'Enter date'}

  @error=hh.select {|key,_| params[key]==""}.values.join(", ")
  
  if @error !=''
    return erb :visit
  end

  db=get_db
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
  #f = File.open 'users.txt', 'a'
  #f.write "User: #{@user_name}, phone: #{@phone}, date and time: #{@datetime}. Barber: #{@barber}.Color #{@color}\n"
  #f.close
  erb :message
end


def is_parameters_empty? hh
end


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
get '/calendar' do
  erb :calendar
end
		# /admin по паролю будет выдаваться список тех, кто записался (из users.txt)
	post '/admin' do
	  @login = params[:login]
	  @password = params[:password]

	  # проверим логин и пароль
	  if @login == 'admin' && @password == 'admin'
	    @file = File.open("./users.txt","r")
	    erb :watch_result

	    # @file.close - должно быть, но не работает
	  else
	    @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
	    erb :admin
	  end
	end

