class PaymentMethod < ApplicationRecord
  belongs_to :company
  belongs_to :boleto
  belongs_to :card
  belongs_to :pix
end
