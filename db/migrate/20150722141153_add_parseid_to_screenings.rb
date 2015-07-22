class AddParseidToScreenings < ActiveRecord::Migration
  def change
    add_column :screenings, :parseid, :string, default: ""
  end
end
