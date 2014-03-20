class RenameEventTimeToStartTime < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.rename :time, :start_time
    end
  end
end
