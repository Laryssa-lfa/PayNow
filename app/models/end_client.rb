class EndClient < ApplicationRecord
  before_create :generate_token

  has_many :company_end_clients
  has_many :companies, through: :company_end_clients

  validates :name, :cpf, :company_token, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, length: {is: 11, message: 'Deve conter 11 caracteres' }

  def generate_token
    token = SecureRandom.alphanumeric(20)
    if EndClient.exists?(token: token)
      self.token = SecureRandom.alphanumeric(20)
    else
      self.token = token
    end
  end
end
