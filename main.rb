require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

get '/' do
	
	"Hello World"
end

get '/test' do
	erb :test
end

get '/sswn/password' do
	erb :"sswn/password"
end
