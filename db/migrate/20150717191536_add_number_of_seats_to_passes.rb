class AddNumberOfSeatsToPasses < ActiveRecord::Migration
  def change
    add_column :passes, :number_of_seats, :integer, default: 1
  end
end
