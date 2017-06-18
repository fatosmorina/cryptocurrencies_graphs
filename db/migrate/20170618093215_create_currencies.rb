class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string :type
      t.float :value
      t.date :date

      t.timestamps
    end
  end
end
