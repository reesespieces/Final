require 'sinatra'
require 'sequel'
require 'rubygems'
require 'simple-rss'
require 'open-uri'

#enable :sessions

DB = Sequel.connect('sqlite://test.db')

get '/chart' do
  DB.create_table(:db) do
    primary_key :id
    String :username
    String :password
  end

  end

get '/' do
  if session[:secret] != "sloth"
    redirect 'home.html'
    session[:secret] = "sloth"
  else
    erb :mainpage
  end
end

post '/newsparser1' do #logging in
  #session[:secret] = "sloth"
  @username = params[:username]
  @password = params[:password]

  @items = DB[:db]

  if @items[:username => @username] #:db[:username => @username] #DB[:username => @username]
    erb :mainpage
    #return "Sorry. The username you entered has already been taken. Please try another username."
  else #:db[:username != @username] #DB[:username] != @username
    redirect 'signup.html'
  end
end

post '/newsparser' do #signing up
  #session[:secret] = "sloth"
  @username = params[:username]
  @password = params[:password]

  @items = DB[:db]

  if @items[:username => @username] #:db[:username => @username] #DB[:username => @username]
    redirect 'signup.html'
    #return "Sorry. The username you entered has already been taken. Please try another username."
  else #:db[:username != @username] #DB[:username] != @username
    @items.insert(:username => @username, :password => @password)
    erb :mainpage
  end

  #@abc = SELECT * FROM USERNAME #WHERE @username = :username
=begin

  if @username == :username
    'Username already exists'
  else #@username == :username
    erb :test
  end
=end

=begin
  @abc = DB(SELECT * FROM username WHERE @username = :username)

  if @abc == true
    'Username already exists. Please try another'
  elsif @abc == false
    'Success!'
  else
    'error'
  end
=end

  #puts @items.all

end

get '/main' do
  erb :mainpage
end

get '/usatoday' do
  erb :usatoday
end

get '/cnn' do
  erb :cnn
end

get '/foxnews' do
  erb :fox
end

get '/economist' do
  erb :economist
end

get '/b' do
  erb :bbc
end

get '/nyt' do
  erb :nyt
end
