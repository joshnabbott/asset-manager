class CreateVideoFormats < ActiveRecord::Migration
  def self.up
    create_table :video_formats do |t|
      t.string :title
      t.text :description
      t.text :conversion_command
      t.string :resolution
      t.string :output_file_extension

      t.timestamps
    end
  end

  def self.down
    drop_table :video_formats
  end
end
