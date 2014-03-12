class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :position
      t.string :program
      t.text :about

      t.timestamps
    end
  end
end
