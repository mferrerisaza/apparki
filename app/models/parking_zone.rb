class ParkingZone < ApplicationRecord
  belongs_to :user
  has_many :tickets

  monetize :price_cents

  validates :name, :city, :price, presence: true
  validates :name, uniqueness: { scope: :city }
end
