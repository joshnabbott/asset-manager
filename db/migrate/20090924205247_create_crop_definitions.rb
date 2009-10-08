class CreateCropDefinitions < ActiveRecord::Migration
  def self.up
    create_table :crop_definitions do |t|
      t.belongs_to :asset_category
      t.string :name
      t.integer :minimum_width
      t.integer :minimum_height
      t.integer :x
      t.integer :y
      t.boolean :locked_ratio, :null => false, :default => false
      t.boolean :selection_enabled, :selection_moveable, :selection_resizable, :null => false, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :crop_definitions
  end
end
