class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :airport
      t.string :lat_long
      t.boolean :origin

      t.timestamps
    end
  end
end
