class AddColumnToCourts < ActiveRecord::Migration[6.1]
  def change
    add_column :courts, :price, :integer
    add_column :courts, :remarks, :text
    add_column :courts, :image, :text
    add_column :courts, :latitude, :float
    add_column :courts, :longitude, :float
    add_column :courts, :number, :integer
  end
end
