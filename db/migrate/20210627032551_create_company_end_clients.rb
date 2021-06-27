class CreateCompanyEndClients < ActiveRecord::Migration[6.1]
  def change
    create_table :company_end_clients do |t|
      t.references :company, null: false, foreign_key: true
      t.references :end_client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
