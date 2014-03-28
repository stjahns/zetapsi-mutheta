class AddRecieptToTransaction < ActiveRecord::Migration
  def self.up
    change_table :transactions do |t|
      t.attachment :receipt
    end
  end

  def self.down
    drop_attached_file :transactions, :receipt
  end
end
