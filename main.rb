require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

helpers do

end

get '/' do
	if !session[:player_name]
		redirect '/new_game'
	else
		redirect '/game'
	end
end

get '/reset' do
	session[:player_name] = nil
	session[:player_money] = 0
	session[:player_bet] = 0
	redirect '/'
end


get '/new_game' do
	erb :new_game
end

get '/sswn/password' do
	erb :"sswn/password"
end

post '/set_name' do
	if params[:player_name]
		session[:player_name] = params[:player_name].downcase.capitalize
		session[:player_money] = 500
		redirect '/bet'		
	else
		redirect '/new_game'
	end
end

post '/game' do
	if params[:player_bet]
		session[:player_bet] = params[:player_bet].to_i
		session[:player_money] -= params[:player_bet].to_i
		erb :game		
	else
		redirect '/bet'
	end
end

get '/game' do
	erb :game
end

get '/bet' do

	erb :bet
end