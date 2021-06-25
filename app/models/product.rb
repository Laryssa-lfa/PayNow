class Product < ApplicationRecord
  belongs_to :company

  validates :name, :price, :token, :type_payment,
            :company_id, presence: true
  validates :token, uniqueness: true

  def generate_token
    token = SecureRandom.alphanumeric(20)
    if Company.exists?(token: token)
      self.token = SecureRandom.alphanumeric(20)
    else
      self.token = token
    end
  end
end
