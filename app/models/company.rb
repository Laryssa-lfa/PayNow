require 'securerandom'

class Company < ApplicationRecord
  belongs_to :client

  has_many :ChangeHistoryToCompanies
  has_many :payment_methods
  has_many :boletos, through: :payment_methods
  has_many :cards, through: :payment_methods
  has_many :pixes, through: :payment_methods
  has_many :products
  has_many :company_end_clients
  has_many :end_clients, through: :company_end_clients

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
