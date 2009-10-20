class CreateEncodedVideos < ActiveRecord::Migration
  def self.up
    create_table :encoded_videos do |t|
      t.integer :video_id
      t.integer :video_format_id
      t.string :file_file_path
      t.string :file_content_type
      t.integer :file_file_size
      t.string :preview_file_path
      t.string :preview_content_type
      t.integer :preview_file_size
      t.integer :width
      t.integer :height
      t.float :aspect_ratio
      
      t.timestamps
    end
  end

  def self.down
    drop_table :encoded_videos
  end
end
