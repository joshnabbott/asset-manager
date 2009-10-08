module ApplicationHelper
  include TagsHelper

  def stylesheet_for_controller
    # Automatically includes current controller's stylesheet if it exists
    # If the controller were the people controller, stylesheet would need to be named people_controller.css and 
    # live in the stylesheets directory
    file_name = [controller.controller_name, '_controller'].join
    stylesheet_link_tag(file_name) if File.exists?(File.join(RAILS_ROOT, 'public', 'stylesheets', file_name + '.css'))
  end
end
