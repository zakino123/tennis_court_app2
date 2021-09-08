class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :context
      t.references :user, null: false, foreign_key: true
      t.references :court, null: false, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:court_id, :created_at]
  end
end
