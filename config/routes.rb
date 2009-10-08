ActionController::Routing::Routes.draw do |map|
  map.resources :video_formats

  map.resources :asset_categories
  map.resources :crop_definitions

  map.resources :audios
  map.edit_batch_audios 'audios/*ids/edit', :controller => 'audios', :action => 'edit_batches', :conditions => { :method => :get }
  map.update_batch_audios 'audios/*ids', :controller => 'audios', :action => 'update_batches', :conditions => { :method => :put }
  map.destroy_batch_audios 'audios/*ids', :controller => 'audios', :action => 'destroy_batches', :conditions => { :method => :delete }

  # Routes for images, this includes custom routes for batch options
  map.resources :images, :has_many => [ :crops ]
  map.edit_batch_images 'images/*ids/edit', :controller => 'images', :action => 'edit_batches', :conditions => { :method => :get }
  map.update_batch_images 'images/*ids', :controller => 'images', :action => 'update_batches', :conditions => { :method => :put }
  map.destroy_batch_images 'images/*ids', :controller => 'images', :action => 'destroy_batches', :conditions => { :method => :delete }

  # Routes for videos, this includes custom routes for batch options
  map.resources :videos
  map.edit_batch_videos 'videos/*ids/edit', :controller => 'videos', :action => 'edit_batches', :conditions => { :method => :get }
  map.update_batch_videos 'videos/*ids', :controller => 'videos', :action => 'update_batches', :conditions => { :method => :put }
  map.detroy_batch_videos 'videos/*ids', :controller => 'videos', :action => 'destroy_batches', :conditions => { :method => :delete }
end
