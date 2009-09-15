class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.belongs_to :owner
      t.string :owner_type
      t.string :type
      t.string :title
      t.text :description
      t.string :author
      t.date :date_taken
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
