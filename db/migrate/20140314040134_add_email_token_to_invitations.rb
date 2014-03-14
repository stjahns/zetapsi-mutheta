class AddEmailTokenToInvitations < ActiveRecord::Migration
  def change
    change_table :invitations do |t|
      t.string :email_token
    end
  end
end
