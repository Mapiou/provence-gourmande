class CreateRecipeReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_reviews do |t|
      t.text :content
      t.integer :rating
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
