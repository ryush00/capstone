class AddNameToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :name, :stringsdaads
  end
end
