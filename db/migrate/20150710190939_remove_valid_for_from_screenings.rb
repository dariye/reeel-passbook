class RemoveValidForFromScreenings < ActiveRecord::Migration
  def change
    remove_column :screenings, :valid_for, :integer
  end
end
