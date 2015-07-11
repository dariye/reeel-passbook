class AddParseScreeningObjectIdToScreenings < ActiveRecord::Migration
  def change
    add_column :screenings, :parse_screening_object_id, :string, default: ""
  end
end
