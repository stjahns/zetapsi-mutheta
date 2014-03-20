class AddEndTimeToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.datetime "end_time"
    end
  end
end
