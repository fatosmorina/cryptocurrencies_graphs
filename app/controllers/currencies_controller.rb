require "#{Rails.root}/lib/currencies/currency_client.rb"

class CurrenciesController < ApplicationController

 def show
 	@currencies = params[:id] ? params[:id].downcase : ''
 	case @currencies
 	when  !Currency.currency_types.include?(@currencies) 
 		@currencies = {}
 	else
 		@currencies = set_currencies(@currencies)
 	end
 end

 private

 def set_currencies(currency_type)
 	@currencies = Currency.where(currency_type: Currency.currency_types["#{currency_type}"])
 	@currencies.inject({}) do |new_element, current_element|
      date = current_element.date
      value = current_element.value
      new_element[date] = value
      new_element
    end
 end


end