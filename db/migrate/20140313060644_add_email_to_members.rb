class AddEmailToMembers < ActiveRecord::Migration
  def change
    change_table :members do |t|
      t.string :email
    end
  end
end
