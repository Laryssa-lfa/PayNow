class AddRoleToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :role, :integer, null: false, default: 0
  end
end
