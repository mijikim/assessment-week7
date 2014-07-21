require 'sinatra/base'
require 'gschool_database_connection'
require './lib/messages_table'
require './lib/country_list'

class Application < Sinatra::Application
  enable :sessions

  def initialize
    super
    @messages_table = Messages.new(@database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV['RACK_ENV']))
  end

  get '/' do
    messages = @messages_table.messages
    erb :index, :locals => {:messages => messages}
  end

  get '/messages' do
    messages = @messages_table.messages
    erb :messages, :locals => {:messages => messages}
  end

  post '/messages' do
    current_msg_id = @messages_table.create(params[:username], params[:message])
    session[:msg_id] = current_msg_id
    messages = @messages_table.messages
    erb :messages, :locals => {:messages => messages}
  end

  get '/continents' do
    all_continents = CountryList.new.continents
    erb :continents, locals: {continents: all_continents}
  end

  get '/continents/:continent_name' do
    list_of_countries = CountryList.new.countries_for_continent(params[:continent_name])
    erb :countries, locals: {countries: list_of_countries, continent: params[:continent_name]}
  end

end