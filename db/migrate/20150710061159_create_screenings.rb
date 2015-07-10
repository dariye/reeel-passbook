class CreateScreenings < ActiveRecord::Migration
  def change
    create_table :screenings do |t|
      t.string :title, default: ""
      t.string :location, default: ""
      t.datetime :time_date, default: Time.now 
      t.integer :valid_for, default: 0
      t.text :terms_n_conditions, default: ""
      t.string :pass_barcode_string, default: ""
      t.integer :pass_id

      t.timestamps null: false
    end
    add_index :screenings, :pass_id
  end
end
