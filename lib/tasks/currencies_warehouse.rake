require "currencies/currency_client"

namespace :currency do
  desc "Get daily values for crypto currencies"
  task seed: "db:seed" do
    include CurrencyClient
    begin

      ['bitcoin', 'ethereum', 'nasdaq'].each do |currency|
        insert_new_recent_rows(CurrencyClient.send("get_#{currency}s"), "#{currency}")
      end

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
      currency = Currency.create(currency_type: currency_type, date: date, value: value)
      print_currency_inserterd(currency_type.capitalize, date, value)
    end
  end
end

def print_currency_inserterd(currency, date, value)
  puts "New row added: #{currency}'s value on #{date}: #{value} USD"
end
