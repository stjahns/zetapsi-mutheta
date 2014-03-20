class AddHasEndToEvents < ActiveRecord::Migration
  def up
    add_column :events, :has_end, :boolean, default: true
  end
  def down
    remove_column :events, :has_end
  end
end
