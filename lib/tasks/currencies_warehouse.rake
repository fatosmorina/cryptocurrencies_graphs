  require "factory_girl"
  require "currencies/currency_client"

  namespace :currency do
    desc "Get daily values for crypto currencies"
    task seed: "db:seed" do
      include FactoryGirl::Syntax::Methods
      include CurrencyClient
      begin
          insert_new_recent_rows(CurrencyClient.get_bitcoins, 'bitcoin')
          insert_new_recent_rows(CurrencyClient.get_ethereums, 'ethereum')
          insert_new_recent_rows(CurrencyClient.get_nasdaqs, 'nasdaq')

      rescue ActiveRecord::StatementInvalid
        # ...which we ignore.
      end
    end
  end

  def insert_new_recent_rows(currencies, currency_type)
    Hash[currencies.sort_by{|k,v| k}.reverse].each do |currency|
        date = currency[0]
        value = currency[1]
        currency = Currency.where(date: date, currency_type: currency_type)
        break if currency.present?
          ActiveRecord::Base.transaction do
              currency = create(:currency, currency_type: currency_type, date: date, value: value)
              print_currency_inserterd(currency_type.capitalize, date, value)
          end
    end
  end

  def print_currency_inserterd(currency, date, value)
    puts "New row added: #{currency}'s value on #{date}: #{value} USD"
  end
