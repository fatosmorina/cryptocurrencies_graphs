require "currencies/currency_client"

namespace :dev do
  desc "Insert all crypto currencies in the database"
  task seed: "db:seed" do
    include CurrencyClient

    begin
      bitcoins = CurrencyClient.get_bitcoins
      ethereums = CurrencyClient.get_ethereums
      nasdaqs = CurrencyClient.get_nasdaqs

      insert_currencies('bitcoin', bitcoins)
      insert_currencies('ethereum', ethereums)
      insert_currencies('nasdaq', nasdaqs)

      puts "Congratulations! You have all crypto currencies values in your database now!"

    rescue ActiveRecord::StatementInvalid
      # ...which we ignore.
    end
  end
end


def insert_currencies(type, currencies)
  currencies.each do |date, value|
    ActiveRecord::Base.transaction do
      Currency.create(currency_type: type, date: date, value: value)
      print_currency(type.capitalize, date, value)
    end
  end	
end

def print_currency(currency, date, value)
  puts "#{currency}'s value on #{date}: #{value} USD"
end
