require 'sinatra'
require 'sinatra/reloader'

get '/' do #add page http://localhost:4567
	erb :index # erb - template engine 
end

post '/' do
	@user_name = params[:user_name]
	@phone = params[:phone]
	@date_time=params[:date_time]
	@password=params[:password]
	@title="Thank you!"
	@message="Dear, #{@user_name}, 
	we will be waiting for you at #{@date_time}"

	#f=File.open './public/users.txt','a' # add http://localhost:4567/users.txt
	f=File.open 'users.txt','a'
	f.write "User:#{@user_name}. Phone: #{@phone}. Date and time: #{@date_time}\n"
	f.close
	erb :message


end

get '/admin' do
  erb :admin
end
		# Добавить зону /admin где по паролю будет выдаваться список тех, кто записался (из users.txt)

	# sinatra text file sso
	post '/admin' do
	  @login = params[:login]
	  @password = params[:password]

	  # проверим логин и пароль, и пускаем внутрь или нет:
	  if @login == 'admin' && @password == 'admin'
	    @file = File.open("./users.txt","r")
	    erb :watch_result
	    # @file.close - должно быть, но тогда не работает. указал в erb
	  else
	    @report = '<p>Доступ запрещён! Неправильный логин или пароль.</p>'
	    erb :admin
	  end
	end


