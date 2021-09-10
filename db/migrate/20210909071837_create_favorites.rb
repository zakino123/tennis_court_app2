class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :court, null: false, foreign_key: true
      t.index [:user_id, :court_id], unique: true

      t.timestamps
    end
  end
end
