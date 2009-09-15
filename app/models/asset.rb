class Asset < ActiveRecord::Base
  belongs_to :owner

  # Ruby method to call system identify. Accepts regular arguments of `identify`
  # Run identify -help in a terminal window to see available options
  def identify(image, *args)
    `identify #{args.join(' ')} #{image}`
  end
end