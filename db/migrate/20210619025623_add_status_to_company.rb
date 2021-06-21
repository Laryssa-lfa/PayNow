class AddStatusToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :status, :boolean, null: false, default: false
  end
end
