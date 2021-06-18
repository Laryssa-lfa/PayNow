class CreatePixes < ActiveRecord::Migration[6.1]
  def change
    create_table :pixes do |t|
      t.decimal :rate
      t.string :code
      t.integer :bank_code
      t.boolean :status, null: false, default: false
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
