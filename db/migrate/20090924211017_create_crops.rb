class CreateCrops < ActiveRecord::Migration
  def self.up
    create_table :crops do |t|
      t.belongs_to :image
      t.belongs_to :crop_definition
      t.integer :offset_x
      t.integer :offset_y
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :crops
  end
end
