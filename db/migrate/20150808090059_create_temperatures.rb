class CreateTemperatures < ActiveRecord::Migration
  def change
    create_table :temperatures do |t|
      t.integer :value
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end
