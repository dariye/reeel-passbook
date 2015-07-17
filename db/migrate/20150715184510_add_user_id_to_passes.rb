class AddUserIdToPasses < ActiveRecord::Migration
  def change
    add_column :passes, :user_id, :integer
    add_index :passes, :user_id
  end
end
