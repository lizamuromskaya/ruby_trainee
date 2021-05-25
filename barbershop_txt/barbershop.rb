require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

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
  
  if @user_name==''
    @error='Enter your name!'
  end
   if @phone==''
    @error='Enter your phone number!'
  end
    if @datetime==''
    @error='Enter date!'
  end
  if @error!=''
    return erb :visit
  end



  f = File.open 'users.txt', 'a'
  f.write "User: #{@user_name}, phone: #{@phone}, date and time: #{@datetime}. Barber: #{@barber}.Color #{@color}\n"
  f.close
  erb :message
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
