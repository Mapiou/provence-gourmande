class Dose < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  validates :recipe, uniqueness: { scope: :ingredient }
end
