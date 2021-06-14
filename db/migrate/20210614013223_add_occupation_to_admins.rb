class AddOccupationToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :occupation, :string
  end
end
