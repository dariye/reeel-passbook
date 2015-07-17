class AddLocationNameToScreenings < ActiveRecord::Migration
  def change
    add_column :screenings, :location_name, :string, default: ""
  end
end
