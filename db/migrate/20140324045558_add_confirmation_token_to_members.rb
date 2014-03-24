class AddConfirmationTokenToMembers < ActiveRecord::Migration
  def change
    change_table(:members) do |t|
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
    end
    
    add_index :members, :confirmation_token, :unique => true
  end
end
