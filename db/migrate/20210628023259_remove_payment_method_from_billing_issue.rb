class RemovePaymentMethodFromBillingIssue < ActiveRecord::Migration[6.1]
  def change
    remove_column :billing_issues, :payment_method, :string
  end
end
