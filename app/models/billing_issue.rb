class BillingIssue < ApplicationRecord
  before_create :generate_token

  validates :company_token, :product_token, :end_client_token,
            :type_payment, presence: true
  validates :card_number, :name_client_card,
            :verification_code, presence: true, if: :paid_with_card?
  validates :full_address, presence: true, if: :paid_with_boleto?
  validates :token, uniqueness: true

  def generate_token
    token = SecureRandom.alphanumeric(20)
    if BillingIssue.exists?(token: token)
      self.token = SecureRandom.alphanumeric(20)
    else
      self.token = token
    end
  end

  def paid_with_card?
    type_payment == "Cartão de Crédito"
  end
  
  def paid_with_boleto?
    type_payment == "Boleto Bancário"
  end

  def product_attributes
    @product = Product.where(token: product_token)
    if @product
      self.type_payment = @product[0]['type_payment']
      self.price_product = @product[0]['price']
      if @product[0]['discount']
        self.price_discount = (@product[0]['price'] - @product[0]['discount'])
      end
    end
  end
end
