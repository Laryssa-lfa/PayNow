class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boletos
  has_many :cards
  has_many :pixes

  validates :email,
  format: { with: /(.+)@paynow.com.br/, message: "inválido"  },
            uniqueness: true,
            presence: true,
            length: { minimum: 4, maximum: 254 }
end
