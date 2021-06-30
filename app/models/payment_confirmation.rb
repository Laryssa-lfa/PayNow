class PaymentConfirmation < ApplicationRecord
  before_create :generate_token

  has_many :billing_issues

  def generate_token
    token = SecureRandom.alphanumeric(20)
    if PaymentConfirmation.exists?(token: token)
      self.token = SecureRandom.alphanumeric(20)
    else
      self.token = token
    end
  end
end
