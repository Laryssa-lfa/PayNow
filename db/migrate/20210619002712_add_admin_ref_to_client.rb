class AddAdminRefToClient < ActiveRecord::Migration[6.1]
  def change
    add_reference :clients, :admin, null: false, foreign_key: true
  end
end
