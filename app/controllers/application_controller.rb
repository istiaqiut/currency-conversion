# For the documentation check http://sinatrarb.com/intro.html
require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  # This configuration part will inform the app where to search for the views and from where it will serve the static files
  require_relative '../services/currency.rb'
  register Sinatra::Flash
  register Sinatra::StrongParams
  include CurrencyService
  enable :sessions
  configure do
    set :views, "app/views"
    set :public_dir, "public"
  end


  get '/' do
    @currencies = available_currencies
    erb :index
  end

  post '/', needs: [:inputvalue, :inputcurrency, :outputcurrency] do
    @input_value = params[:inputvalue].to_f
    @input_currency = params[:inputcurrency]
    @output_currency = params[:outputcurrency]
    if (!currency_converter_params(@input_value, @input_currency, @output_currency))
      flash[:alert] = "Currency conversion failed!"
      redirect '/'
    else
      @output_value = conversion(@input_value, @input_currency, @output_currency)
      insert_currency_converter(@input_value, @input_currency, @output_currency, @output_value)
      flash[:notice] = "Currency converted successfully"
      redirect "/"
    end

  end

  get '/histories' do
    @currencies_histories = CurrencyConverter.all(order: :created_at)
    erb :histories
  end

  def currency_converter_params (input_value, input_currency, output_currency)
    @currencies = available_currencies
    if (input_value <= 0 || !@currencies.include?(input_currency) || !@currencies.include?(output_currency))
      return false
    end
    return true
  end

end
