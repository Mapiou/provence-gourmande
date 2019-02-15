class AddIngredientsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :ingredients, :text, default: [], array: true
    add_column :recipes, :steps, :text, default: [], array: true
  end
end
