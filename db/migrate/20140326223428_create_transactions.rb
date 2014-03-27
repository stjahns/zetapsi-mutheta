class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :member_id
      t.string :type
      t.string :description
      t.decimal :amount, :precision => 10, :scale => 2, :default => 0.0
      t.timestamps
    end
  end
end
