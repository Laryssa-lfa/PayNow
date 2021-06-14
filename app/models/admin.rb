class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email,
  format: { with: /(.+)@paynow.com.br/, message: "E-mail inválido"  },
            uniqueness: true,
            presence: true,
            length: { minimum: 6, maximum: 254 }
end
