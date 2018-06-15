class User < ApplicationRecord
  has_many :parking_zones
  has_many :tickets, through: :parking_zones
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
