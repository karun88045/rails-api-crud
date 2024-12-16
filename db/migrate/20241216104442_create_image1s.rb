class CreateImage1s < ActiveRecord::Migration[7.2]
  def change
    create_table :image1s do |t|
      t.string :url
      t.string :imageable_type
      t.integer :imageable_id

      t.timestamps
    end
  end
end
