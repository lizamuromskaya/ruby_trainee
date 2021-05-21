require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do #add page http://localhost:4567
	erb :index # erb - template engine 
end


post '/' do
  # user_name, phone, date_time
  @user_name = params[:user_name]
  @phone = params[:phone]
  @date_time = params[:date_time]
  @baber = params[:baber]

  @title = "Thank you!"
  @message = "Dear #{@user_name}, we are waiting for you #{@date_time}. Your baber:#{@baber}."

  # запишем в файл то, что ввёл клиент
  f = File.open 'users.txt', 'a'
  f.write "User: #{@user_name}, phone: #{@phone}, date and time: #{@date_time}. Baber: #{@baber}.\n"
  f.close

  erb :message

end
get '/about' do
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
	    @file = File.open("./users.txt","r")
	    erb :watch_result
	    # @file.close - должно быть, но не работает
	  else
	    @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
	    erb :admin
	  end
	end
