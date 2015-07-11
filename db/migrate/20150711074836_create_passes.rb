class CreatePasses < ActiveRecord::Migration
  def change
    create_table :passes do |t|
      t.string :pass_type_id, default: ""
      t.string :serial_number, default: ""
      t.integer :screening_id

      t.timestamps null: false
    end
    add_index :passes, :screening_id
  end
end
