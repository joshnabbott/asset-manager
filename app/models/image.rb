# TODO: get_meta_data and santized_meta_data_for_yaml seem to be very out of place here.
class Image < Asset
  attr_accessor :image_ids
  has_attached_file :file, :url => "/system/images/:attachment/:id/:style/:filename",
    :styles => {
      :thumbnail => "125x125>",
      :edit => "200x200>",
      :small => "800x800>" }

  before_file_post_process :set_data_columns
  serialize :meta_data

  # has_and_belongs_to_many :asset_categories, :join_table => :asset_categories_assets, :foreign_key => :asset_id
  has_many :crops
  has_many :crop_definitions, :finder_sql => 'SELECT `crop_definitions`.* FROM crop_definitions
  INNER JOIN asset_categories ON `asset_categories`.`id` = `crop_definitions`.`asset_category_id`
  INNER JOIN asset_categories_assets ON `asset_categories_assets`.`asset_category_id` = `crop_definitions`.`asset_category_id`
  WHERE `asset_categories_assets`.`asset_id` = #{self.id}'

  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => /image/

protected
  def get_meta_data(file_path)
    data = Paperclip.run("identify", %Q[-verbose "#{file_path}"[0]])

    begin
      YAML::load(sanitized_meta_data_for_yaml(data))
    rescue Exception => e
      logger.debug("Error raised while trying to read #{data} as YAML:\r\n#{e.inspect}")
    end
  end

  def sanitized_meta_data_for_yaml(data)
    data = data.gsub("\n\n", "\n")
    data = data.gsub(/\n\s{2}/, "\r\n")
  end

  def set_data_columns
    file_path         = self.file.queued_for_write[:original].path
    image             = Paperclip::Geometry.from_file(file_path)
    self.height       = image.try(:height)
    self.width        = image.try(:width)
    self.aspect_ratio = image.try(:aspect)
    self.meta_data    = self.get_meta_data(file_path)
  end
end