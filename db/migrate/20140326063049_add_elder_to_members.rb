class AddElderToMembers < ActiveRecord::Migration
  def up
    add_column :members, :elder, :boolean, default: false
  end
  def down
    remove_column :members, :elder
  end
end
