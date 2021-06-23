require 'securerandom'

class Company < ApplicationRecord
  belongs_to :client

  has_many :ChangeHistoryToCompanies

  validates :cnpj, :corporate_name, :address,
            :email, :token, presence: true
  validates :cnpj, :token,  :corporate_name, uniqueness: true

  def view_status
    self.status ? "Empresa habilitada" : "Empresa desabilitada"
  end

  def generate_token
    token = SecureRandom.alphanumeric(20)
    if Company.exists?(token: token)
      self.token = SecureRandom.alphanumeric(20)
    else
      self.token = token
    end
  end
end
