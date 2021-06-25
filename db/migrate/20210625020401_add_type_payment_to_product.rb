class AddTypePaymentToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :type_payment, :string
  end
end
