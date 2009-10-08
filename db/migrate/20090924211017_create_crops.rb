class CreateCrops < ActiveRecord::Migration
  def self.up
    create_table :crops do |t|
      t.belongs_to :image
      t.belongs_to :crop_definition
      t.integer :x1, :x2, :y1, :y2, :width, :height

      t.timestamps
    end
  end

  def self.down
    drop_table :crops
  end
end
