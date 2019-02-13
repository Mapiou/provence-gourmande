class Restaurant < ApplicationRecord
  has_many :restaurant_reviews, , dependent: :destroy
  validates :name, :address, :phone, presence: true
  price_range = ["€", "€€", "€€€", "€€€€"]
  validates :price, presence: true, inclusion: { in: Restaurant::price_range }
end
