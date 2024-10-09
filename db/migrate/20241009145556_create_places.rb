class CreatePlaces < ActiveRecord::Migration[7.2]
  def change
    create_table :places do |t|
      t.string :place_type
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
