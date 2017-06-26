class ChangeCurrencyTypeToInteger < ActiveRecord::Migration[5.0]
  def change
  	change_column :currencies, :currency_type, :integer, using: 'currency_type::integer'
  end
end
