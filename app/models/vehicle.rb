class Vehicle < ApplicationRecord
  has_many :tickets

  validates :plate, presence: true
  validates :plate, uniqueness: true

  col_plate_regex = /([A-Z]{3}\d{3})|([A-Z]{2}\d{4})|([A-Z]{1}\d{4})|([A-Z]{3}\d{2}[A-Z])/
  validates :plate, format: { with: col_plate_regex }
end
