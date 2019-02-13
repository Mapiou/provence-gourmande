class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.string :photo
      t.string :city
      t.string :address
      t.string :phone
      t.string :price
      t.text :menu

      t.timestamps
    end
  end
end
