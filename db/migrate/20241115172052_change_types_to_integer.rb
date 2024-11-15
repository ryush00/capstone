class ChangeTypesToInteger < ActiveRecord::Migration[7.2]
  def change
    # places의 place_type
    change_column :places, :place_type, :integer

    # pools의 pool_type
    change_column :pools, :pool_type, :integer
  end
end
