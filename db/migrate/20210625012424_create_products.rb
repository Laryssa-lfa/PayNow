class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.decimal :price
      t.decimal :discount
      t.string :token

      t.timestamps
    end
  end
end
