class Guest < ApplicationRecord
  has_many :phone_numbers, dependent: :destroy
  has_many :reservations, dependent: :destroy
  accepts_nested_attributes_for :phone_numbers

  validates :email, uniqueness: true
end
