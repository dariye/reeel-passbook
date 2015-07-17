class RemoveUserIdFromPasses < ActiveRecord::Migration
  def change
    remove_index :passes, :user_id
    remove_column :passes, :user_id, :integer
  end
end
