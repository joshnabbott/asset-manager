class Asset < ActiveRecord::Base
  belongs_to :owner
<<<<<<< HEAD:app/models/asset.rb
end
=======
  acts_as_taggable_on :tags

  # Ruby method to call system identify. Accepts regular arguments of `identify`
  # Run identify -help in a terminal window to see available options
  def identify(image, *args)
    `identify #{args.join(' ')} #{image}`
  end
end
>>>>>>> origin/videos:app/models/asset.rb
