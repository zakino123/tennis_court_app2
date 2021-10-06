class AddColumnToCourts < ActiveRecord::Migration[6.1]
  def change
    change_table :courts, bulk: true do |t|
      t.integer :price
      t.text :remarks
      t.text :image
      t.float :latitude
      t.float :longitude
      t.integer :number
    end
  end
end
