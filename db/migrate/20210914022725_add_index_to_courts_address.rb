class AddIndexToCourtsAddress < ActiveRecord::Migration[6.1]
  def change
    change_table :courts, bulk: true do |t|
      t.index :address, unique: true, limit: 255
      t.index :latitude, unique: true
      t.index :longitude, unique: true
    end
  end
end
