class AddNameToPools < ActiveRecord::Migration[7.2]
  def change
    add_column :pools, :name, :string
  end
end
