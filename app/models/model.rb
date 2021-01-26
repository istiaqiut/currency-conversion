# this is a simple model example
# check https://datamapper.org/getting-started.html
class CurrencyConverter
  include DataMapper::Resource

  property :id, Serial # An auto-increment integer key
  property :inputCurrency, String
  property :inputValue, Numeric
  property :outputCurrency, String
  property :outputValue, Numeric
  property :created_at, DateTime
  property :updated_at, DateTime

end

DataMapper.finalize

CurrencyConverter.auto_upgrade!
