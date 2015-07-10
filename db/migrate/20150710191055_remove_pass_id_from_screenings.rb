class RemovePassIdFromScreenings < ActiveRecord::Migration
  def change
    remove_column :screenings, :pass_id, :integer
  end
end
