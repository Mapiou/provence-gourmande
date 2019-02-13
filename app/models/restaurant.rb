class Restaurant < ApplicationRecord
  has_many :restaurant_reviews, dependent: :destroy
  validates :name, :address, :phone, presence: true
  PRICE_RANGE = ["€", "€€", "€€€", "€€€€"]
  validates :price, presence: true, inclusion: { in: Restaurant::PRICE_RANGE }
end
