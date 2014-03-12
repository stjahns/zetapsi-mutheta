class AddAttachmentProfilePhotoToMembers < ActiveRecord::Migration
  def self.up
    change_table :members do |t|
      t.attachment :profile_photo
    end
  end

  def self.down
    drop_attached_file :members, :profile_photo
  end
end
