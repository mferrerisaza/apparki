class Vehicle < ApplicationRecord
  has_many :tickets

  validates :plate, presence: true
  validates :plate, uniqueness: true
end
