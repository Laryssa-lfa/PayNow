class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.integer :cnpj
      t.string :corporate_name
      t.string :address
      t.string :email
      t.string :token
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
