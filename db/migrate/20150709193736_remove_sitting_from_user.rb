class RemoveSittingFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :sitting, :integer
  end
end
