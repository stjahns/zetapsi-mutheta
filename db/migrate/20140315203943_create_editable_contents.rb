class CreateEditableContents < ActiveRecord::Migration
  def change
    create_table :editable_contents do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
    add_index :editable_contents, :name
  end
end
