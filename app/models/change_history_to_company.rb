class ChangeHistoryToCompany < ApplicationRecord
  belongs_to :company

  validates :cnpj, :corporate_name, :address, :email, :token,
            :status, :client_id, :company_id, presence: true
end
