class Card < ApplicationRecord
  belongs_to :admin

  has_many :payment_methods
  has_many :companies, through: :payment_methods
end
