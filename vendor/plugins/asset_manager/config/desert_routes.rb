# Add your custom routes here.  If in config/routes.rb you would 
# add <tt>map.resources</tt>, here you would add just <tt>resources</tt>

# resources :asset_managers

with_options(:path_prefix => "asset_manager") do |am|
  am.resources :video_formats

  am.resources :asset_categories
  am.resources :crop_definitions

  am.resources :audios
  am.edit_batch_audios 'audios/*ids/edit', :controller => 'audios', :action => 'edit_batches', :conditions => { :method => :get }
  am.update_batch_audios 'audios/*ids', :controller => 'audios', :action => 'update_batches', :conditions => { :method => :put }
  am.destroy_batch_audios 'audios/*ids', :controller => 'audios', :action => 'destroy_batches', :conditions => { :method => :delete }

  # Routes for images, this includes custom routes for batch options
  am.resources :images, :has_many => [ :crops ]
  # Path for crop
  am.cropped_image '/images/:id/:name.:format', :controller => 'images', :action => 'show', :requirements => { :name => /[0-9a-z]{32}/ }

  am.edit_batch_images 'images/*ids/edit', :controller => 'images', :action => 'edit_batches', :conditions => { :method => :get }
  am.update_batch_images 'images/*ids', :controller => 'images', :action => 'update_batches', :conditions => { :method => :put }
  am.destroy_batch_images 'images/*ids', :controller => 'images', :action => 'destroy_batches', :conditions => { :method => :delete }

  # Routes for videos, this includes custom routes for batch options
  am.resources :videos
  am.resources :encoded_videos
  am.encode 'videos/:id/encode', :controller => 'videos', :action => 'encode'
  am.preview 'videos/:id/preview', :controller => 'videos', :action => 'preview'
  am.edit_batch_videos 'videos/*ids/edit', :controller => 'videos', :action => 'edit_batches', :conditions => { :method => :get }
  am.update_batch_videos 'videos/*ids', :controller => 'videos', :action => 'update_batches', :conditions => { :method => :put }
  am.detroy_batch_videos 'videos/*ids', :controller => 'videos', :action => 'destroy_batches', :conditions => { :method => :delete }
end