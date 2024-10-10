class CreateBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.references :pool, null: false, foreign_key: { on_delete: :nullify }
      t.references :user, null: false, foreign_key: { on_delete: :nullify }

      t.timestamps
    end
  end
end
