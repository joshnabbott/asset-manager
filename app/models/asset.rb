require 'mime/types'
class Asset < ActiveRecord::Base
  belongs_to :owner
  acts_as_taggable_on :tags
  has_and_belongs_to_many :asset_categories

  # Add default per_page method for will_paginate
  def self.per_page
    10
  end

  def uploadify_file=(file_data)
    file_data.content_type = MIME::Types.type_for(file_data.original_filename).to_s
    self.file              = file_data
  end

end