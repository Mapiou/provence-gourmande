class ChangeIngredientsInRecipes < ActiveRecord::Migration[5.2]
  def change
    rename_column :recipes, :ingredients, :ingredients_list
  end
end
