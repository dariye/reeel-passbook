class RemovePassBarcodeStringFromScreenings < ActiveRecord::Migration
  def change
    remove_column :screenings, :pass_barcode_string, :string
  end
end
