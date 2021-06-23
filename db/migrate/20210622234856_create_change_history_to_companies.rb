class CreateChangeHistoryToCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :change_history_to_companies do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :cnpj
      t.string :corporate_name
      t.string :address
      t.string :email
      t.string :token
      t.integer :client_id
      t.string :status

      t.timestamps
    end
  end
end
