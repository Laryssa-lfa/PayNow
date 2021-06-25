class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.references :company, null: false, foreign_key: true
      t.references :boleto, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.references :pix, null: false, foreign_key: true

      t.timestamps
    end
  end
end
