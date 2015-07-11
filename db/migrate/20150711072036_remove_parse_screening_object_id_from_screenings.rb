class RemoveParseScreeningObjectIdFromScreenings < ActiveRecord::Migration
  def change
    remove_column :screenings, :parse_screening_object_id, :string
  end
end
