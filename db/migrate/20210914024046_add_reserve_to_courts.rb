class AddReserveToCourts < ActiveRecord::Migration[6.1]
  def change
    add_column :courts, :reserve, :string
  end
end
