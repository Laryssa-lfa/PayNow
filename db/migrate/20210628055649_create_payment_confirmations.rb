class CreatePaymentConfirmations < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_confirmations do |t|
      t.string :status_code
      t.string :payment_date
      t.string :billing_token
      t.string :token

      t.timestamps
    end
  end
end
