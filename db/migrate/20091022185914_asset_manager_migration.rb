class AssetManagerMigration < ActiveRecord::Migration
  def self.up
    migrate_plugin('asset_manager', 20090914223529)
    migrate_plugin('asset_manager', 20090916174802)
    migrate_plugin('asset_manager', 20090924203547)
    migrate_plugin('asset_manager', 20090924203705)
    migrate_plugin('asset_manager', 20090924205247)
    migrate_plugin('asset_manager', 20090924211017)
    migrate_plugin('asset_manager', 20091008172609)
    migrate_plugin('asset_manager', 20091009204741)
  end

  def self.down
    migrate_plugin('asset_manager', 0)
  end
end
