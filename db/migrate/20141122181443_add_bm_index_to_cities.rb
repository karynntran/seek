class AddBmIndexToCities < ActiveRecord::Migration
  def change
    add_column :cities, :bm_index, :string
  end
end
