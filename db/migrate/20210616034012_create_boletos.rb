class CreateBoletos < ActiveRecord::Migration[6.1]
  def change
    create_table :boletos do |t|
      t.decimal :rate
      t.integer :bank_code
      t.integer :bank_agency
      t.integer :bank_account
      t.boolean :status, null: false, default: false
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
