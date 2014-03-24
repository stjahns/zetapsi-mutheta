class DropInvitations < ActiveRecord::Migration
  def up
    drop_table :invitations
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
