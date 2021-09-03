class CreateCourts < ActiveRecord::Migration[6.1]
  def change
    create_table :courts do |t|
      t.text :name
      t.text :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
