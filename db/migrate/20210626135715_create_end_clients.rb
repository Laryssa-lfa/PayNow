class CreateEndClients < ActiveRecord::Migration[6.1]
  def change
    create_table :end_clients do |t|
      t.string :name
      t.integer :cpf
      t.string :token

      t.timestamps
    end
  end
end
