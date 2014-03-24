class AddRolesMaskToMembers < ActiveRecord::Migration
  def change
    add_column :members, :roles_mask, :integer
  end
end
