class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :material, foreign_key: true
      t.references :user, foreign_key: true
      t.string :operation
      t.integer :ammount

      t.timestamps
    end
  end
end
