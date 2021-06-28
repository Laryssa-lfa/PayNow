class AddTypePaymentToBillingIssue < ActiveRecord::Migration[6.1]
  def change
    add_column :billing_issues, :type_payment, :string
  end
end
