class AddIndexToCourtsAddress < ActiveRecord::Migration[6.1]
  def change
    add_index :courts, :address, unique: true, length: { address: 255 }
    add_index :courts, :latitude, unique: true
    add_index :courts, :longitude, unique: true
  end
end
