require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

get '/' do
	if !session[:player_name]
		redirect '/new_game'
	else
		redirect '/game'
	end
end

get '/new_game' do
	erb :new_game
end

get '/sswn/password' do
	erb :"sswn/password"
end

post '/set_name' do
	if !params[:player_name]
		redirect '/new_game'
	else
		session[:player_name] = params[:player_name]
		redirect '/play'
	end
end

get '/game' do
	erb :game
end