class CreateFoodPrices < ActiveRecord::Migration[6.1]
  def change
    create_table :food_prices, id: false do |t|
      t.date :date
      t.string :cmname
      t.string :unit
      t.string :category
      t.float :price
      t.string :currency
      t.string :country
      t.string :admname
      t.integer :adm1id
      t.string :mktname
      t.integer :mktid
      t.integer :cmid
      t.integer :ptid
      t.integer :umid
      t.integer :catid
      t.string :sn
      t.string :default
    end
  end
end
