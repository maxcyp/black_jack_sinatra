require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

helpers do
	def get_card_img(card)
		#suits = ['H', 'D', 'C', 'S']
		#values = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']
		
		if card[0] == 'H'
			suit = 'hearts'
		elsif card[0] == 'D'
			suit = 'diamonds'
		elsif card[0] == 'C'
			suit = 'clubs'
		else 
			suit = 'spades'
		end
		
		if card[1] == 'J'
			value = 'jack'
		elsif card[1] == 'Q'
			value = 'queen'
		elsif card[1] == 'K'
			value = 'king'
		elsif card[1] == 'A'
			value = 'ace'
		else
			value = card[1]
		end
		
		str = suit + '_' + value
	end

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
		
		#Create Deck
		suits = ['H', 'D', 'C', 'S']
		values = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']
		
		#Suffle and Combine
		session[:deck] = suits.product(values).shuffle!
		session[:dealer_cards] = [] 
		session[:player_cards] = []
		
		#Deal cards
		session[:player_cards] << session[:deck].pop
		session[:dealer_cards] << session[:deck].pop
		session[:player_cards] << session[:deck].pop
		session[:dealer_cards] << session[:deck].pop		
		
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

post '/hit' do
	session[:player_cards] << session[:deck].pop
	redirect '/game'
end

post '/stay' do
	redirect '/game'
end