class User < ApplicationRecord
  has_many :parking_zones
  has_many :entry_tickets, class_name: 'Ticket', foreign_key: 'entry_user_id'
  has_many :exit_tickets, class_name: 'Ticket', foreign_key: 'exit_user_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    "#{id} -  #{email}"
  end
end
