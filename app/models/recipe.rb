class Recipe < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :recipe_reviews, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
