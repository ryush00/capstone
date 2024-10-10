class CreatePools < ActiveRecord::Migration[7.2]
  def change
    create_table :pools do |t|
      t.string :pool_type
      t.references :user, null: false, foreign_key: { on_delete: :nullify }
      t.datetime :start_at
      t.datetime :end_at
      t.references :start_place, null: false, foreign_key: { to_table: :places, on_delete: :nullify }
      t.references :end_place, null: false, foreign_key: { to_table: :places, on_delete: :nullify }
      t.integer :user_max
      t.integer :user_min

      t.timestamps
    end
  end
end
