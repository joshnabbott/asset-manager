class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.belongs_to :owner
      t.string :owner_type
      t.string :type, :file_file_name, :file_content_type
      t.integer :file_file_size
      t.string :title
      t.text :description
      t.datetime :file_updated_at
      t.decimal :file_width, :precision => 8, :scale => 3
      t.decimal :file_height, :precision => 8, :scale => 3
      t.decimal :file_aspect_ratio, :precision => 6, :scale => 6
      t.text :file_meta_data

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
