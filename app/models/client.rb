class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :companies

  validates :email,
  format: { without: /(.+)@gmail|hotmail|yahoo|paynow|bol|outlook(.+)/, message: "inválido"  },
            uniqueness: true,
            presence: true,
            length: { minimum: 4, maximum: 254 }

  enum role: { employee: 0, admin: 1 }


end
