class CreateBillingIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :billing_issues do |t|
      t.string :company_token
      t.string :product_token
      t.string :payment_method
      t.string :end_client_token
      t.string :card_number
      t.string :name_client_card
      t.string :verification_code
      t.string :full_address
      t.decimal :price_product
      t.decimal :price_discount
      t.boolean :status, null: false, default: false
      t.string :token

      t.timestamps
    end
  end
end
