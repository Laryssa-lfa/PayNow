class RemoveAdminIdFromClient < ActiveRecord::Migration[6.1]
  def change
    remove_column :clients, :admin_id, :integer
  end
end
