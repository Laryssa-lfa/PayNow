class AddCompanyTokenToEndClient < ActiveRecord::Migration[6.1]
  def change
    add_column :end_clients, :company_token, :string
  end
end
