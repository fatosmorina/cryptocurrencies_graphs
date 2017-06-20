class RenameTypeToCurrencyType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :currencies, :type, :currency_type
  end
end
