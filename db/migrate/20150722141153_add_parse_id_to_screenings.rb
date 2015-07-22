class AddParseIdToScreenings < ActiveRecord::Migration
  def change
    add_column :screenings, :parse_id, :string, default: ""
  end
end
