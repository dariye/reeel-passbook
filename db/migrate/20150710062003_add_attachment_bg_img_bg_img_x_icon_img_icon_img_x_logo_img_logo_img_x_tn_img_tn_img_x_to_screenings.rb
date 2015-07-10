class AddAttachmentBgImgBgImgXIconImgIconImgXLogoImgLogoImgXTnImgTnImgXToScreenings < ActiveRecord::Migration
  def self.up
    change_table :screenings do |t|
      t.attachment :bg_img
      t.attachment :bg_img_x
      t.attachment :icon_img
      t.attachment :icon_img_x
      t.attachment :logo_img
      t.attachment :logo_img_x
      t.attachment :tn_img
      t.attachment :tn_img_x
    end
  end

  def self.down
    remove_attachment :screenings, :bg_img
    remove_attachment :screenings, :bg_img_x
    remove_attachment :screenings, :icon_img
    remove_attachment :screenings, :icon_img_x
    remove_attachment :screenings, :logo_img
    remove_attachment :screenings, :logo_img_x
    remove_attachment :screenings, :tn_img
    remove_attachment :screenings, :tn_img_x
  end
end
