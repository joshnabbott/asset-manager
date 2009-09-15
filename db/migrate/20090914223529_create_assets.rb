class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.belongs_to :owner
      t.string :owner_type
      t.string :type, :file_file_name, :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at
      t.string :title
      t.text :description
      t.integer :width
      t.integer :height
      t.decimal :aspect_ratio, :precision => 6, :scale => 6
      t.text :meta_data

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
