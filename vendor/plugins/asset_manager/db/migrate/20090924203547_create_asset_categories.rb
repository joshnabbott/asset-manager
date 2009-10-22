class CreateAssetCategories < ActiveRecord::Migration
  def self.up
    create_table :asset_categories do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :asset_categories
  end
end
