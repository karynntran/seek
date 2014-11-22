class AddFavoritesModel < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user
      t.string :link

      t.timestamps
    end
  end
end
