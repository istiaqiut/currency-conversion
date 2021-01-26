module CurrencyService
  require_relative '../models/model.rb'
  require 'money/bank/currencylayer_bank'


  def available_currencies
    currencies = ["EUR", "USD", "CHF"]
    return currencies
  end

  def conversion(input_value, input_currency, output_currency)
    currency_api = Money::Bank::CurrencylayerBank.new
    currency_api.access_key = '0d0d621e58fa525dda2a6bbe7192e98f'
    Money.default_bank = currency_api
    input_currency_exchange = 100 * Money.new(input_value, input_currency)
    output_currency_value = input_currency_exchange.exchange_to(output_currency)
    return output_currency_value.to_f
  end

  def insert_currency_converter(input_value, input_currency, output_currency, output_value)
    currency_converter = CurrencyConverter.new()
    currency_converter.inputCurrency = input_currency
    currency_converter.inputValue = input_value
    currency_converter.outputCurrency = output_currency
    currency_converter.outputValue = output_value
    currency_converter.save
  end

end
