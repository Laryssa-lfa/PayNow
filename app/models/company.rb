class Company < ApplicationRecord
  belongs_to :client

# TODO: colocar :token como unico e present
  validates :cnpj, :corporate_name, :address,
            :email, presence: true
  validates :cnpj, :corporate_name, uniqueness: true


  def view_status
    self.status ? "Empresa habilitada" : "Empresa desabilitada"
  end
end
