ActionController::Routing::Routes.draw do |map|
  map.resources :videos
  map.resources :images
  map.edit_batch_images 'images/*ids/edit', :controller => 'images', :action => 'edit_batches', :conditions => { :method => :get }
  map.update_batch_images 'images/*ids', :controller => 'images', :action => 'update_batches', :conditions => { :method => :put }
end
