# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091009204741) do

  create_table "asset_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_categories_assets", :id => false, :force => true do |t|
    t.integer "asset_id"
    t.integer "asset_category_id"
  end

  create_table "assets", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "type"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.string   "preview_file_name"
    t.string   "preview_content_type"
    t.integer  "preview_file_size"
    t.integer  "preview_offset"
    t.datetime "file_updated_at"
    t.string   "title"
    t.text     "description"
    t.integer  "width"
    t.integer  "height"
    t.float    "aspect_ratio"
    t.text     "meta_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crop_definitions", :force => true do |t|
    t.integer  "asset_category_id"
    t.string   "name"
    t.integer  "minimum_width"
    t.integer  "minimum_height"
    t.integer  "x"
    t.integer  "y"
    t.boolean  "locked_ratio",        :default => false, :null => false
    t.boolean  "selection_enabled",   :default => true,  :null => false
    t.boolean  "selection_moveable",  :default => true,  :null => false
    t.boolean  "selection_resizable", :default => true,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crops", :force => true do |t|
    t.integer  "image_id"
    t.integer  "crop_definition_id"
    t.integer  "x1"
    t.integer  "x2"
    t.integer  "y1"
    t.integer  "y2"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "encoded_videos", :force => true do |t|
    t.integer  "video_id"
    t.integer  "video_format_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.string   "preview_file_name"
    t.string   "preview_content_type"
    t.integer  "preview_file_size"
    t.integer  "width"
    t.integer  "height"
    t.float    "aspect_ratio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "video_formats", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "conversion_command"
    t.string   "output_file_extension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
