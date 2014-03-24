class RemovePasswordDigestRememberTokenFromMembers < ActiveRecord::Migration
  def change
    change_table(:members) do |t|
      t.remove :password_digest
      t.remove :remember_token
      #t.remove_index :remember_token
    end
  end
end
